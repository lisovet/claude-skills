# QA Monkey — Software Architecture

## System Overview

```
┌──────────────────────────────────────────────────────────────────┐
│                       Claude Code CLI                            │
│                                                                  │
│  User: /qa-monkey "check the API"                                │
│         │                                                        │
│         ▼                                                        │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │              QA Monkey Orchestrator                       │   │
│  │                                                          │   │
│  │  1. Read qa-findings.md (what's already verified)        │   │
│  │  2. Select agents (conditional activation)               │   │
│  │  3. Dispatch agents (parallel where independent)         │   │
│  │  4. Collect findings, deduplicate, score                 │   │
│  │  5. Apply early-agreement skepticism                     │   │
│  │  6. Update qa-findings.md                                │   │
│  │  7. Exit → stop hook re-injects                          │   │
│  └──────┬───────┬───────┬───────┬───────┬───────┬──────────┘   │
│         │       │       │       │       │       │               │
│         ▼       ▼       ▼       ▼       ▼       ▼               │
│  ┌─────────┐┌────────┐┌──────┐┌──────┐┌──────┐┌────────────┐  │
│  │Invariant││Silent  ││Drift ││Data  ││Test  ││  Visual    │  │
│  │Checker  ││Failure ││Detect││Integ ││Gap   ││  Auditor   │  │
│  │         ││Hunter  ││      ││      ││Finder││            │  │
│  │ Rules   ││ Errors ││Config││Counts││Cover ││ Puppeteer  │  │
│  │ Guards  ││ Catch  ││ Env  ││Match ││ age  ││ Screenshot │  │
│  │ Logic   ││ Pass   ││ Drift││ Math ││ Gaps ││ Multimodal │  │
│  └─────────┘└────────┘└──────┘└──────┘└──────┘└────────────┘  │
│         │       │       │       │       │       │               │
│         └───────┴───────┴───┬───┴───────┴───────┘               │
│                             ▼                                    │
│                    ┌─────────────────┐                           │
│                    │ qa-findings.md  │                           │
│                    │ (persists       │                           │
│                    │  across         │                           │
│                    │  sessions)      │                           │
│                    └─────────────────┘                           │
│                                                                  │
│  Tools: Bash, Read, Write, Grep, Glob, WebFetch, Agent          │
│  Optional: Puppeteer MCP, Playwright MCP                         │
└──────────────────────────────────────────────────────────────────┘
```

## Plugin Structure

```
qa-monkey/
├── .claude-plugin/
│   └── plugin.json              # Plugin metadata + skill registry
├── commands/
│   ├── qa-monkey.md             # Investigation orchestrator (/qa-monkey)
│   ├── qa-fix.md                # Remediation orchestrator (/qa-fix)
│   ├── qa-findings.md           # Show findings (/qa-findings)
│   └── cancel-qa.md             # Cancel loop (/cancel-qa)
├── agents/
│   ├── invariant-checker.md     # Domain rules + guardrails
│   ├── silent-failure-hunter.md # Error handling gaps
│   ├── drift-detector.md        # Config vs runtime divergence
│   ├── data-integrity.md        # Counts, math, timestamps
│   ├── test-gap-finder.md       # Coverage gaps + missing tests
│   ├── visual-auditor.md        # Puppeteer screenshots + multimodal
│   └── prd-generator.md         # Generates remediation PRDs
├── prompts/
│   └── heuristics.md            # Reference library of checks
├── hooks/
│   └── stop-hook.sh             # Ralph-loop style iteration (qa-monkey only)
├── scripts/
│   ├── setup-qa-monkey.sh       # Initialize investigation loop
│   └── setup-qa-fix.sh          # Initialize remediation pipeline
├── templates/
│   ├── qa-findings.md           # Findings file template
│   ├── qa-known-issues.md       # User marks accepted risks
│   ├── qa-exceptions.md         # Patterns to ignore
│   ├── remediation-prd-light.md # Lightweight PRD template
│   └── remediation-prd-full.md  # Full PRD template
└── README.md
```

## Component Design

### 1. Orchestrator (`commands/qa-monkey.md`)

The orchestrator is NOT an investigator. It's a coordinator. Each iteration:

```
Phase 1: ORIENT
  - Read .claude/qa-findings.md (what's done)
  - Read CLAUDE.md, README (what this project does)
  - Read .claude/qa-known-issues.md (accepted risks — don't re-report)
  - Read .claude/qa-exceptions.md (patterns to ignore)
  
Phase 2: SELECT AGENTS
  - Which agents are relevant? (conditional activation)
    - No UI → skip Visual Auditor
    - No tests → skip Test Gap Finder but flag it as WARNING
    - All code heuristics verified → deploy Visual Auditor
    - Previous iteration found CRITICAL → re-deploy that agent to verify fix
  - Which agents can run in parallel? (no data dependencies)
  
Phase 3: DISPATCH
  - Launch selected agents via Agent tool (subagent_type for each)
  - Parallel where independent, sequential where dependent
  - Each agent receives: project context, findings so far, specific focus
  
Phase 4: COLLECT & SCORE
  - Gather findings from all agents
  - Deduplicate: same root cause from 2 agents → merge, keep highest confidence
  - Apply confidence threshold (default ≥80)
  - Apply known-issues filter (suppress accepted risks)
  - Disagreement check: if agents contradict each other, flag as investigation target
  
Phase 5: SKEPTICISM CHECK
  - If iteration ≤ 2 AND 0 findings: force deeper pass
  - Pick least-explored heuristic and explicitly run it
  - "You found nothing. Prove you actually looked."
  
Phase 6: MULTI-HYPOTHESIS (for complex findings)
  - For any finding with confidence 70-89:
    - Generate 3 hypotheses for root cause
    - Test each with specific commands
    - Upgrade to ≥80 or downgrade to <70
  
Phase 7: UPDATE
  - Append to qa-findings.md
  - Note remaining angles, rejected hypotheses
  - Exit (stop-hook re-injects for next iteration)
```

### 2. Agent Prompts

Each agent follows a consistent structure:

```markdown
# Agent: {Name}

## Persona
You are a {specialization}. You are suspicious, thorough, and evidence-based.

## Scope
You ONLY investigate {specific focus}. Do not investigate other areas.

## Process
1. Read the project context provided
2. Identify {N} specific checks to run
3. For each check:
   - State what you're checking and why
   - Run the check (commands, file reads, etc.)
   - Record: expected vs actual
   - Assign confidence (0-100) and criticality (1-10)
4. Return findings in structured format

## Output Format
Return JSON array of findings:
[
  {
    "type": "CRITICAL|WARNING|INFO|VERIFIED",
    "confidence": 0-100,
    "criticality": 1-10,
    "summary": "One-line description",
    "evidence": "I ran X, expected Y, got Z",
    "check": "What specific check was performed",
    "suggestion": "How to fix (if applicable)",
    "hypotheses": ["tested A ✅", "tested B ❌"] // optional
  }
]

## Rules
- Every finding MUST have evidence. No "this looks wrong" without proof.
- If you can't verify something, say so honestly. Don't guess.
- If you find something outside your scope, note it for another agent.
- Respect rate limits. Back off on 429s.
- Never expose secrets in findings.
```

### 3. Visual Auditor Agent (`agents/visual-auditor.md`)

```markdown
# Agent: Visual Auditor

## Persona
You are a suspicious UX tester with 20/20 vision. You look at 
screens and immediately spot when something doesn't look right.

## Scope
Browser-based testing of web UIs. You open pages, take screenshots,
and verify what the user sees matches what the system reports.

## Prerequisites
- Puppeteer or Playwright available (check via `which puppeteer` or 
  check for @anthropic/puppeteer MCP)
- If unavailable: fall back to curl + HTML parsing. Note degraded 
  testing in findings.
- URLs from project config, env vars, or code analysis

## Process

### Step 1: Discover UIs
Find all web endpoints:
- Dashboard URLs in config/env
- HTML files in source
- Routes in Express/FastAPI/etc.

### Step 2: Screenshot Each Page
For each URL:
- Open in headless browser
- Wait for data to load (2s default, 10s for WebSocket)
- Screenshot full page
- Store in .claude/qa-screenshots/{page}-{timestamp}.png

### Step 3: Visual Inspection (Multimodal)
Look at each screenshot and check:
- Do the numbers make sense? (negative P&L shown in green?)
- Are all panels populated? (empty tables, $0 values, loading spinners stuck)
- Does the layout look broken? (overlapping elements, missing sections)
- Is the data current? (timestamps from hours ago on a "live" dashboard)

### Step 4: API vs Display Comparison
For each data-displaying element:
- Fetch the same data from API
- Compare to what's displayed
- Flag discrepancies > 5% or missing data

### Step 5: Interactive Testing
If --interactive flag:
- Click buttons, check responses
- Submit forms, verify confirmation
- Navigate between pages, check routing
- Trigger error states, verify error UI

### Step 6: Visual Regression
If previous screenshots exist:
- Compare current vs previous
- Flag significant visual changes
- Distinguish data changes (expected) from layout changes (investigate)

## Fallback: No Browser Available
If Puppeteer/Playwright not available:
1. curl each URL, check HTTP status
2. Parse HTML, extract text content
3. Compare extracted text to API values
4. Note: "Visual testing degraded — no browser available"

## Edge Cases
- SPA with client-side routing → navigate via URL hash/path changes
- Auth-required pages → read credentials from env, never log them
- Dynamic content → multiple screenshots with delays, check stability
- Large pages → crop to specific panels, send multiple smaller images
- Dark mode → note which theme was tested
- Mobile responsive → screenshot at 375px, 768px, 1440px widths

## Output Format
Include screenshot file paths in evidence:
{
  "type": "WARNING",
  "confidence": 88,
  "criticality": 7,
  "summary": "Dashboard shows 0 active users — API reports 4,385",
  "evidence": "Screenshot: .claude/qa-screenshots/dashboard-001.png\nAPI /health: active_users.total=4385\nDisplayed value: 0",
  "check": "Compared dashboard active-users panel to /health API response",
  "suggestion": "Panel may not update until first poll completes. Check data binding."
}
```

### 4. Stop Hook (`hooks/stop-hook.sh`)

Same pattern as Ralph loop but with QA-specific state:

```bash
#!/bin/bash
STATE_FILE=".claude/qa-monkey.local.md"

if [ ! -f "$STATE_FILE" ]; then
  exit 0  # not active
fi

ITERATION=$(grep "^iteration:" "$STATE_FILE" | cut -d' ' -f2)
MAX=$(grep "^max_iterations:" "$STATE_FILE" | cut -d' ' -f2)
PROMISE=$(grep "^completion_promise:" "$STATE_FILE" | cut -d' ' -f2-)

# Max iterations
if [ "$MAX" -gt 0 ] && [ "$ITERATION" -ge "$MAX" ]; then
  rm "$STATE_FILE"
  exit 0
fi

# Completion promise
if [ -n "$PROMISE" ] && [ "$PROMISE" != "null" ]; then
  if echo "$CLAUDE_OUTPUT" | grep -q "<promise>$PROMISE</promise>"; then
    rm "$STATE_FILE"
    exit 0
  fi
fi

# Stale check: if last 3 iterations had 0 new findings, stop
FINDINGS_FILE=".claude/qa-findings.md"
if [ -f "$FINDINGS_FILE" ]; then
  RECENT=$(tail -30 "$FINDINGS_FILE" | grep -c "confidence:")
  # Simple heuristic: if recent section has no confidence-scored findings
  # for 3 iterations, consider it clean
fi

# Increment and continue
NEW_ITER=$((ITERATION + 1))
sed -i '' "s/^iteration: .*/iteration: $NEW_ITER/" "$STATE_FILE" 2>/dev/null || \
  sed -i "s/^iteration: .*/iteration: $NEW_ITER/" "$STATE_FILE"

TASK=$(awk '/^---$/{n++} n==2{print}' "$STATE_FILE")
echo "$TASK"
exit 1  # block exit, feed back
```

### 5. Findings File Format

```markdown
# QA Monkey Findings

Project: {detected from CLAUDE.md or package.json}
Started: {UTC timestamp}
Iterations: {N}
Last updated: {UTC timestamp}

## Confidence Map
What we've verified is working (builds trust over time):
- [x] Health endpoint returns real data (iter 1, conf 95)
- [x] Test suite passes (iter 1, conf 92)
- [x] Profile cron fires on schedule (iter 2, conf 88)
- [ ] Background job completion working (investigating)
- [ ] Dashboard matches API (not yet checked)

## Active Findings

### CRITICAL-001 [confidence: 95, criticality: 9] — Iteration 1
**Background jobs never complete — 3,855 stuck pending**
Evidence: Checked completed count over 2 polls: 80 → 80 (flat)
Expected: Growing ~30/poll
Root cause: worker pool missing job processor registration (line 1273)
Hypotheses: [code broken ❌] [queue not draining ✅] [jobs not created ❌]
Status: FIXED in commit abc123

### WARNING-001 [confidence: 85, criticality: 7] — Iteration 2
**Dashboard shows 0 active users during first load**
Evidence: Screenshot .claude/qa-screenshots/dash-001.png shows 0
API: /health active_users.total = 4385
Cause: Data loads after first poll completes, not at startup
Status: OPEN — cosmetic but misleading

## Resolved Findings
(Moved here after fix verified)

## Rejected Hypotheses
(Useful for future investigators)
- "Job handler code is broken" — code is correct, the issue was data flow
- "Profiles are stale" — profiles refresh every 6h via cron
```

## Data Flow Between Iterations

```
Iteration 1 (cold start):
  Orchestrator → reads project files → deploys all agents in parallel
  Agents → run heuristics → return findings with confidence scores
  Orchestrator → deduplicates → filters ≥80 → writes qa-findings.md
  
Iteration 2:
  Orchestrator → reads qa-findings.md → sees 12/15 heuristics verified
  Deploys only: drift-detector (unverified) + visual-auditor (unverified)
  If CRITICAL from iter 1 was fixed: re-verify with original agent
  
Iteration 3:
  All base heuristics verified. Orchestrator enters "deep mode":
  - Follow up on WARNINGs
  - Run multi-hypothesis testing on ambiguous findings
  - Visual Auditor: screenshot regression against iter 2
  
Iteration 4+:
  If 0 new findings for 3 iterations → "System verified clean" → stop
  If new code deployed (git diff detects changes) → reset relevant checks
```

## Conditional Agent Activation

| Condition | Agents Activated |
|-----------|-----------------|
| First run (cold start) | All 6 |
| All base checks pass | Visual Auditor + deep mode on warnings |
| Previous CRITICAL found | Re-verify agent that found it + 1 adjacent |
| `--focus api` | Data Integrity + Drift Detector only |
| `--focus ui` | Visual Auditor only |
| `--visual` flag | Force Visual Auditor even if no UI detected |
| No tests in project | Skip Test Gap Finder, add WARNING finding |
| No UI in project | Skip Visual Auditor entirely |
| CI mode (`--ci`) | All agents, single pass, no loop |

## Remediation Pipeline (`/qa-fix`)

Unlike the investigation loop (which uses a stop hook to repeat iterations), the remediation pipeline runs as a **single long-running command**. No stop hook needed.

### Architecture Decision: Why No Stop Hook

The investigation loop repeats the same prompt each iteration — perfect for a stop hook. The remediation pipeline needs **phase transitions** (triage -> PRD -> review -> approve -> implement -> verify -> ship). These phases have different prompts, tools, and user interaction models. Driving this via a stop hook would require the hook to construct different prompts per phase, detect user input from transcripts, and manage complex state — all fragile.

Instead, `qa-fix.md` is a long-running orchestrator prompt that manages phases internally. A state file (`.claude/qa-fix.local.md`) exists only for **resume capability** — if the session dies, `/qa-fix` reads it and offers to continue.

### Architecture Decision: Orchestrator Does TDD, Not a Subagent

A subagent doing TDD (write tests, run tests, implement, run tests again, run lint, run typecheck) easily exhausts its token budget. Investigation agents are read-only and bounded; implementation agents are write-heavy and unbounded.

The orchestrator does TDD directly. Subagents are used only for:
- **PRD generation** — read-only analysis, bounded output
- **Complex verification** — scoped to one finding, read-only

### Flow

```
/qa-monkey (stop-hook loop)         /qa-fix (single session)

  Investigate -> Findings  ------>  1. Triage (parse, group, sort)
                   |                2. PRD Generation (prd-generator agents)
                   v                3. Review (orchestrator sanity check)
            qa-findings.md          4. Approval (user gate: Y/n/select)
                                    5. TDD Implementation (orchestrator)
                                    6. Verification (tests + code check)
                                    7. Checkpoint (user: continue/skip/stop)
                                    8. Ship (push + PR)
                                    9. Cleanup
```

### State Files

| File | Purpose | Lifecycle |
|------|---------|-----------|
| `.claude/qa-monkey.local.md` | Investigation loop state | Created by setup-qa-monkey.sh, deleted on completion |
| `.claude/qa-fix.local.md` | Remediation pipeline state | Created by setup-qa-fix.sh, deleted on completion |
| `.claude/qa-findings.md` | Findings (persists across sessions) | Created on first investigation, updated by both pipelines |
| `.claude/qa-fix-prds/*.md` | Generated remediation PRDs | Created during PRD gen, kept for reference |

### Auto-Chain

When `/qa-monkey` finishes investigation:
- With `--fix` flag: auto-invokes `/qa-fix`
- Without `--fix`: asks user "Want me to fix them? [Y/n]"
- No findings: "System verified clean."

## Security Model

- **Secrets**: Never include env var VALUES in findings. Only key names.
- **Credentials**: Visual Auditor may need auth tokens. Read from env, never log.
- **Branch safety**: All `--fix` changes go to `qa-monkey/fix-{issue-id}` branches.
- **Rate limits**: Back off exponentially on 429s. Max 1 req/sec to external APIs.
- **Read-only default**: No writes unless `--fix` is explicit.
- **Screenshot privacy**: Screenshots stored locally, never uploaded. Findings reference file paths.
- **Known issues**: `.claude/qa-known-issues.md` prevents re-reporting accepted risks.

## Extensibility

### Custom Heuristics
Users add project-specific checks in `.claude/qa-heuristics.md`:

```markdown
## Custom: User Count Consistency
Trigger: Project has user_service.py
Method: Compare active users in /health vs /api/users?status=active
Expected: Same count (within 5%)
Red flags: >10% difference, one source showing 0
```

### Custom Agents
Users can add agents in `.claude/qa-agents/`:
```markdown
# Agent: Compliance Checker
## Persona
You verify regulatory compliance requirements.
## Scope
Check GDPR data handling, PCI DSS for payments, SOC2 controls.
```

### Integration Hooks
- **Pre-commit**: Run QA Monkey in CI mode on staged files
- **Post-deploy**: Trigger QA Monkey after Railway/Vercel deploy
- **Scheduled**: Cron-triggered `/qa-monkey --ci --watch` for continuous monitoring
- **PR review**: Integrate with `pr-review-toolkit` — QA Monkey as additional reviewer
