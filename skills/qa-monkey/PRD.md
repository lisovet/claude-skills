# QA Monkey — Product Requirements Document

## What is it?

A Claude Code plugin that acts as a suspicious, curious QA engineer. You point it at any project and it starts poking around — verifying claims, checking if things actually work, finding discrepancies between what the code says and what's actually happening.

It's not a test runner. It's not a linter. It's an AI that asks "but does this actually work?" and then checks.

## The Problem

Developers build systems and assume they work. CI passes, deploy succeeds, health endpoint returns 200. But underneath:
- A feature was added but never wired up (a background job processor had no handlers for 16 hours)
- Data is contaminated and nobody noticed (stale cache inflated metrics for days)
- Two systems run in parallel doing the same thing, neither fully working
- Config says one thing, runtime does another
- An API endpoint returns 200 but the data is wrong
- The dashboard shows numbers that don't match the API
- A cron job was set up but never actually ran

These bugs don't crash the app. They silently corrupt data, waste resources, or make features useless. They're only found when a human gets suspicious and starts digging.

QA Monkey automates the suspicion.

## User Experience

### Entry Point
```
/qa-monkey
```
No args needed. It reads the project, figures out what to check, and starts investigating.

```
/qa-monkey "verify the background workers are processing jobs"
/qa-monkey --focus api --max-iterations 10
/qa-monkey --fix                          # allow auto-fixes on critical issues
/qa-monkey --visual                       # include Puppeteer UI testing
/qa-monkey --ci                           # single pass, exit code for CI pipelines
/qa-monkey --watch                        # run forever, alert on new findings
/qa-monkey --completion-promise "ALL CHECKS PASS"
```

### What the User Sees

The monkey orchestrates 6 specialist agents, each focused on a different class of bugs. Each iteration:

1. **Orchestrator** reads `qa-findings.md` to see what's been verified
2. Selects which specialist agents to deploy (conditional activation — only runs agents relevant to what changed or what's unverified)
3. Agents run in parallel, each producing findings with **confidence scores (0-100)**
4. Only findings with **confidence >= 80** are surfaced (kills noise)
5. Findings classified by **criticality (1-10)** with clear definitions
6. Updates `qa-findings.md` with evidence-backed findings
7. If `--fix` mode: fixes critical issues on a branch

The user can watch, interrupt, or let it run unattended. Findings persist across sessions.

### Completion

The monkey stops when:
- `--max-iterations` reached
- `--completion-promise` condition met
- 3 consecutive iterations with 0 new findings ≥ 80 confidence (system is clean)
- User cancels (`/cancel-qa`)

### Early Agreement Skepticism

If all agents report "clean" in < 2 iterations, the orchestrator forces a deeper pass. Too-fast consensus means rubber-stamping, not real investigation. The monkey asks: "Did you actually check, or did you just not find anything because you didn't look hard enough?"

---

## Multi-Agent Architecture

The monkey is NOT one monolithic agent. It's 6 specialists orchestrated by a command, following the `pr-review-toolkit` pattern from Anthropic's official plugins.

### Agent 1: Invariant Checker
**Focus:** Domain rules, business logic, guardrails from CLAUDE.md
- Reads project rules/guardrails (CLAUDE.md, .claude/rules/)
- Verifies each rule is actually enforced in code
- Checks if runtime behavior matches documented constraints
- Example: "CLAUDE.md says max retry count is 5. Is that actually checked? What happens if it's exceeded?"

### Agent 2: Silent Failure Hunter
**Focus:** Error handling gaps, swallowed exceptions, empty catch blocks
- 5-step audit: identify try/except → scrutinize what's caught → examine fallback behavior → check hidden paths → validate state after errors
- Finds `except: pass`, broad `Exception` catches, errors logged but not handled
- Checks if error states are recoverable or if they corrupt downstream data
- Example: "This function catches all exceptions and returns None. 47 callers assume it returns a dict."

### Agent 3: Drift Detector
**Focus:** Config vs code vs runtime divergence
- Compares .env, .env.example, Railway/Vercel vars, code defaults
- Finds env vars referenced in code but not set in production
- Detects feature flags stuck in one state
- Finds stale config (values that were relevant 6 months ago but not now)
- Example: "PROFILES_URL is set but the firewall blocks it. The code falls back silently."

### Agent 4: Data Integrity Auditor
**Focus:** Counts match, numbers are real, timestamps fresh
- Finds multiple data sources for the same thing and compares them
- Verifies computed values (does the math actually work?)
- Checks data files for corruption (NaN, inf, empty required fields)
- Monitors growth rates (active records should be growing, not flat)
- Example: "Health endpoint says 3,706 active users. API says 9,802. Which is right?"

### Agent 5: Test Gap Finder
**Focus:** What's untested, what edge cases are missing
- Runs test suite, analyzes coverage
- Identifies critical code paths with no tests
- Suggests specific test cases for uncovered branches
- Checks if test data matches production reality
- Example: "The exit calculation has 0% test coverage. It handles 3 directions but tests only check buy_yes."

### Agent 6: Visual Auditor
**Focus:** Puppeteer-driven UI/UX verification
- Opens dashboard/web UI in headless browser (Puppeteer or Playwright)
- Takes screenshots of each page, panel, and state
- Claude LOOKS at screenshots (multimodal) and asks: "Does this make sense?"
- Compares what's displayed on screen vs what the API returns
- Checks interactive elements (buttons respond, forms submit, navigation works)
- Screenshot diffing against last known good state
- Catches CSS bugs (green number that's negative), empty panels, broken layouts
- Example: "Dashboard shows $0 capital at risk but the API returns $4,385. The panel didn't load."

---

## Confidence Scoring (from pr-review-toolkit)

Every finding gets two scores:

### Confidence (0-100)
How sure is the agent that this IS a real problem?
- **90-100**: Verified with evidence. "I ran X, got Y, expected Z."
- **80-89**: Strong signal but couldn't fully verify. "This looks wrong based on code analysis."
- **70-79**: Suspicious but could be intentional. NOT surfaced by default.
- **<70**: Noise. Suppressed entirely.

Threshold: Only findings ≥ 80 are shown. Users can lower with `--confidence 60`.

### Criticality (1-10)
How bad is it if this is real?
- **9-10**: Data loss, security vulnerability, critical failure
- **7-8**: Feature broken, users affected, silent corruption
- **5-6**: Suboptimal behavior, tech debt, future risk
- **3-4**: Style, optimization, nice-to-have
- **1-2**: Observation, suggestion

---

## Investigation Framework

### Layer 1: Does it run?
- Health endpoints return sensible data (not just 200 OK)
- Test suite passes
- No crash loops in logs
- Process is actually alive
- Cron jobs firing on schedule

### Layer 2: Does it do what it claims?
- Features described in README/CLAUDE.md actually exist in code
- API endpoints return data that matches their description
- Config values are actually used (not dead config)
- Imports that could fail silently
- Dashboard shows what the API returns (Visual Auditor)

### Layer 3: Is the data correct?
- Numbers that should match across systems DO match
- Counts that should grow ARE growing
- Timestamps that should be recent ARE recent
- Files that should exist DO exist and aren't empty
- Computed values are mathematically correct
- Visual numbers match API numbers (Visual Auditor)

### Layer 4: Are there hidden failures?
- try/except blocks that swallow errors
- Features that exist in code but aren't called
- Parallel systems that should be one
- Data that's written but never read
- Race conditions (file written then immediately read)
- UI elements that render but don't function (Visual Auditor)

### Layer 5: Does it make sense?
- Business logic sanity checks (is a 100% win rate real?)
- Performance that's too good or too bad
- Metrics that contradict each other
- Edge cases the developer didn't consider
- UX that's confusing or misleading (Visual Auditor)

---

## Multi-Hypothesis Testing (from SWE-bench agents)

When investigating a suspicious finding, the monkey doesn't jump to conclusions. It:

1. **Generates 3 hypotheses** about what's wrong
2. **Tests each** with specific, falsifiable checks
3. **Picks the one with evidence**, discards the others
4. **Records the rejected hypotheses** (helps future investigations)

Example from a background job system:
- Hypothesis A: "Jobs aren't completing because the handler code is broken"
- Hypothesis B: "Jobs aren't completing because the queue isn't draining"
- Hypothesis C: "Jobs aren't completing because they were never enqueued"
- Test B: Check queue depth over time → growing unbounded → **B confirmed**

---

## Built-in Heuristics

### Code-Level (Agents 1-5)
1. **Endpoint Probe**: Find URLs → hit them → check response shape and data quality
2. **Test Runner**: Find test suite → run it → analyze failures and coverage
3. **Config Audit**: Compare env vars across environments → find drift
4. **File Integrity**: Check referenced files exist, sizes are sane, JSON parses
5. **Count Comparison**: Find multiple sources of truth → compare counts
6. **Staleness Check**: Find timestamps → check freshness
7. **Dead Code Detection**: Find unused imports, functions, files
8. **Parallel System Detection**: Find duplicate implementations
9. **Silent Failure Scan**: Find swallowed exceptions
10. **Log Analysis**: Grep for error patterns, repeated failures, retry loops

### Visual-Level (Agent 6)
11. **Screenshot Capture**: Open each page → screenshot → store in `.claude/qa-screenshots/`
12. **API vs Display**: Compare API JSON values to what's rendered on screen
13. **Interactive Probe**: Click buttons, submit forms, check navigation
14. **Responsive Check**: Screenshot at mobile, tablet, desktop widths
15. **Error State Check**: Trigger error conditions → screenshot → verify error UI exists
16. **Empty State Check**: What does a new user see? Is it helpful or broken?
17. **Visual Regression**: Compare current screenshot to last known good → flag changes
18. **Accessibility Probe**: Check contrast, labels, keyboard navigation (if tools available)

---

## Memory Between Iterations

Each iteration reads `.claude/qa-findings.md` to avoid repeating work:

```markdown
# QA Monkey Findings

Project: commodity-bot
Started: 2026-04-06 14:30 UTC
Iterations: 5
Agents deployed: invariant-checker, silent-failure-hunter, data-integrity, visual-auditor

## Summary
- Critical (≥80 confidence): 2
- Warning (≥80 confidence): 4
- Verified OK: 12
- Hypotheses tested: 8 (6 confirmed, 2 rejected)
- Screenshots: 3 captured

## Iteration 1 — 2026-04-06 14:30
Agents: invariant-checker, data-integrity

### CRITICAL [confidence: 95, criticality: 9]
**Background job processor not completing — 3,855 jobs stuck pending**
- Checked: completed count over 2 polls → 80 both times (flat)
- Expected: growing by ~30/poll (matching worker throughput)
- Found: worker_ids set only includes legacy processor
- Root cause: line 1273 iterates self._processors, not self._job_processors
- Hypotheses tested: [code broken ❌] [queue not draining ✅] [jobs not created ❌]

### VERIFIED OK [confidence: 92]
- Health endpoint returns real operational data (not just {"status": "ok"})
- Test suite: 280 passed, 2 pre-existing failures
- Profile cron ran at 07:16 and 12:00, uploaded 68MB successfully

## Iteration 2 — 2026-04-06 14:35
Agents: visual-auditor, drift-detector

### WARNING [confidence: 85, criticality: 7]
**Dashboard shows 0 active users — should be 4,385**
- Screenshot: .claude/qa-screenshots/dashboard-001.png
- API /health returns active_users.total: 4385
- Dashboard panel renders but data binding broken (poll hadn't completed)
- After poll: renders correctly

### VERIFIED OK [confidence: 90]
- Screenshot comparison: dashboard layout matches expected wireframe
- All 6 panels render with data
- Telegram env vars match between Railway and code defaults
```

---

## Edge Cases

### Project Characteristics
- **No tests** → monkey notes this as a finding (criticality 6), doesn't block. Focuses on other heuristics.
- **No health endpoints** → skips endpoint probing, focuses on code and files
- **No UI** → Visual Auditor agent skipped entirely (conditional activation)
- **Monorepo** → respects `--focus frontend` or auto-detects changed packages
- **No CLAUDE.md** → monkey notes this, uses README and package.json for context. Less effective but still useful.

### Runtime Behavior
- **Monkey finds a bug mid-fix** → stops current fix, reports the new finding. Never leaves code in a half-fixed state.
- **Monkey breaks something** → all changes on a branch, easy to revert. Read-only mode by default.
- **Rate-limited API** → respects rate limits, backs off exponentially. Notes rate limiting as an INFO finding.
- **Huge codebase** → focuses on recently changed files (`git diff --name-only HEAD~10`). Expands scope in later iterations.
- **Long-running investigation** → each iteration has a 5-minute timeout. If an agent hangs, orchestrator moves to the next one.

### Multi-Agent Coordination
- **Two agents find the same bug** → deduplicate by root cause. Highest confidence wins.
- **Agents disagree** → disagreement IS a finding. "Agent 2 says this error is caught. Agent 4 says it's swallowed. Investigate."
- **One agent depends on another's output** → orchestrator serializes dependent agents. Independent agents run in parallel.
- **Agent exceeds context window** → agent summarizes findings so far, spawns a continuation.

### Visual Auditor Specific
- **No browser available** → falls back to curl + HTML parsing. Notes degraded visual testing in findings.
- **Dashboard requires auth** → monkey reads env vars for credentials, or asks user. Never stores credentials in findings.
- **Dynamic content** → takes multiple screenshots with 2s delays. Compares for stability.
- **SPA with client-side routing** → navigates via URL changes, not just page loads.
- **WebSocket-dependent dashboards** → waits for WS data before screenshotting. Timeout after 10s.
- **Screenshot too large for context** → crops to relevant panels, sends multiple smaller images.

### False Positive Prevention
- **Every finding requires evidence** → "I ran X, expected Y, got Z." No "this looks wrong" without proof.
- **Confidence threshold** → default 80. Noisy projects can raise to 90.
- **Known issues list** → `.claude/qa-known-issues.md` lets users mark findings as "accepted risk". Monkey won't re-report these.
- **Project-specific exceptions** → `.claude/qa-exceptions.md` defines patterns to ignore (e.g., "test_* files are allowed to have broad except blocks").
- **Hallucination guardrail** → if a finding can't be reproduced on second check, downgrade confidence to <80 (suppressed).

---

## Risks & Mitigations

| Risk | Mitigation |
|------|-----------|
| False positives waste user time | Confidence scoring ≥80 threshold + evidence requirement |
| Monkey breaks something | Read-only default. `--fix` requires explicit flag. Branch-only fixes. |
| Noisy on large codebases | `--focus` flag. Default to changed files. Conditional agent activation. |
| Context window exhaustion | Per-agent isolation. Findings summarized between iterations. |
| Puppeteer fails/unavailable | Graceful degradation. Visual Auditor is optional. |
| Secrets exposure | Redact env var values in findings. Never include tokens/keys. |
| Infinite loop on unfixable issue | 3-iteration stale check. Max iteration limit. |
| Claude hallucinates a problem | Reproducibility check — verify finding on second pass before reporting |

---

## Scope

### V1 (MVP)
- Orchestrator command + stop-hook loop
- 4 specialist agents (invariant-checker, silent-failure-hunter, data-integrity, drift-detector)
- Confidence scoring with 80 threshold
- Findings file with evidence
- 10 code-level heuristics
- Read-only by default
- `--max-iterations` and `--focus` flags
- Known issues / exceptions files

### V2
- Visual Auditor agent (Puppeteer screenshots + multimodal analysis)
- Test Gap Finder agent
- `--fix` mode with branch-based auto-fixes
- Multi-hypothesis testing
- Early agreement skepticism
- GitHub issue creation for warnings
- CI mode (`--ci` flag, exit code)

### V3
- Telegram/Slack/Discord alerting on CRITICAL findings
- Cross-project memory (learn patterns across runs)
- Custom heuristic plugins
- Dashboard for findings history
- Team mode (multiple monkeys on different codebases, shared learnings)
