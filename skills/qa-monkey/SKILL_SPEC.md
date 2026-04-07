# QA Monkey — Claude Code Skill Specification

## Plugin Definition

### `.claude-plugin/plugin.json`

```json
{
  "name": "qa-monkey",
  "display_name": "QA Monkey",
  "version": "0.1.0",
  "description": "A suspicious, curious QA engineer that continuously probes your project for bugs, silent failures, and visual inconsistencies",
  "author": "Toronto Labs"
}
```

### Commands (`commands/`)

#### `commands/qa-monkey.md`
```yaml
---
description: "Start a QA investigation loop. Analyzes your project with 6 specialist agents to find bugs, silent failures, and UI issues."
argument-hint: "[focus area] [--max-iterations N] [--fix] [--visual] [--ci] [--confidence N]"
allowed-tools: ["Agent", "Bash", "Read", "Write", "Grep", "Glob", "WebFetch"]
model: opus
---
```

#### `commands/qa-findings.md`
```yaml
---
description: "Show current QA Monkey findings report"
allowed-tools: ["Read"]
model: haiku
---
```

#### `commands/cancel-qa.md`
```yaml
---
description: "Stop an active QA Monkey loop"
allowed-tools: ["Bash", "Read"]
model: haiku
---
```

### Agents (`agents/`)

Each agent runs as a subagent via the Agent tool. Isolated context, specific persona.

#### `agents/invariant-checker.md`
```yaml
---
name: invariant-checker
description: "Verifies domain rules, business logic, and guardrails from CLAUDE.md are actually enforced in code and at runtime"
model: sonnet
color: blue
---
```

**Trigger conditions:** Always runs on first iteration. Re-runs when CLAUDE.md or rules files change.

**Key checks:**
- Parse every rule in CLAUDE.md / .claude/rules/ → verify enforcement in code
- Check runtime values against documented constraints
- Test boundary conditions (what happens at the limit?)
- Verify error messages match actual error conditions

---

#### `agents/silent-failure-hunter.md`
```yaml
---
name: silent-failure-hunter
description: "Finds error handling gaps, swallowed exceptions, empty catch blocks, and silent fallback behavior that masks real problems"
model: sonnet
color: red
---
```

**Trigger conditions:** Always runs. Priority if recent deploys touched error handling.

**5-step audit process:**
1. IDENTIFY: Find all try/except, .catch(), error callbacks
2. SCRUTINIZE: For each, what's caught? Is it logged? Is state restored?
3. EXAMINE: Check fallback behavior — does the fallback mask real problems?
4. CHECK HIDDEN: Find code paths that return early, default values that hide failures
5. VALIDATE: Run the happy path, then force an error — does the system handle it?

---

#### `agents/drift-detector.md`
```yaml
---
name: drift-detector
description: "Finds divergence between config files, environment variables, code defaults, and actual runtime behavior"
model: sonnet
color: yellow
---
```

**Trigger conditions:** Runs when env vars or config files are involved.

**Key checks:**
- .env vs .env.example vs Railway/Vercel vars vs code defaults
- Feature flags: are they stuck? Does the "off" path still work?
- Dead config: env vars set but never read in code
- Missing config: code references env var that doesn't exist
- Stale config: values from a feature that was removed

---

#### `agents/data-integrity.md`
```yaml
---
name: data-integrity-auditor
description: "Verifies data consistency across multiple sources, checks for corruption, validates computed values, and monitors growth trends"
model: sonnet
color: green
---
```

**Trigger conditions:** Always runs. Priority when data files, APIs, or databases are involved.

**Key checks:**
- Multiple sources of truth → do counts match?
- Computed values → does the math check out?
- Timestamps → are they recent enough for "live" data?
- Data files → valid JSON/schema? No NaN/inf? No empty required fields?
- Growth trends → is count growing when it should be? Flat when it shouldn't?
- Cross-system consistency → does API match database match disk files?

---

#### `agents/test-gap-finder.md`
```yaml
---
name: test-gap-finder
description: "Identifies untested code paths, missing edge case tests, and test suite health issues"
model: sonnet
color: purple
---
```

**Trigger conditions:** Runs when test files exist. Skips with WARNING if no tests found.

**Key checks:**
- Run test suite → analyze failures
- Coverage report → identify uncovered critical paths
- Test data quality → does test data match production reality?
- Edge cases → are boundary conditions tested?
- Integration vs unit → are critical integrations actually tested end-to-end?
- Flaky tests → any tests that pass/fail inconsistently?

---

#### `agents/visual-auditor.md`
```yaml
---
name: visual-auditor
description: "Opens web UIs in headless browser, takes screenshots, verifies what users see matches what the API reports, and checks UX sanity"
model: opus
color: orange
---
```

**Trigger conditions:** Runs when `--visual` flag is set, or when HTML files / dashboard URLs are detected.

**Prerequisites check:**
1. Puppeteer MCP available? → use it
2. Playwright MCP available? → use it
3. `npx puppeteer` works? → use CLI
4. None available? → fall back to curl + HTML parsing, note degraded mode

**Screenshot workflow:**
1. Discover all UI URLs (config, env vars, routes in code)
2. For each URL:
   a. Open in headless browser
   b. Wait for dynamic content (2s default, 10s for WebSocket dashboards)
   c. Screenshot full page → `.claude/qa-screenshots/{name}-{timestamp}.png`
   d. Screenshot at 375px width (mobile) if responsive design detected
3. Claude examines each screenshot (multimodal):
   - Numbers make sense?
   - All panels populated?
   - Colors match meaning? (green = positive, red = negative)
   - Layout intact?
   - Loading states resolved?
4. Compare API values to displayed values (per-field)
5. If previous screenshots exist: visual regression check

**Fallback mode (no browser):**
```
curl -s $URL > /tmp/page.html
# Extract text content
# Compare extracted values to API
# Note: "Visual testing in degraded mode — no browser available"
```

---

## Orchestrator Prompt (Core Logic)

The main command prompt (`commands/qa-monkey.md`) contains the orchestration logic:

```markdown
# QA Monkey — Orchestrator

You are the coordinator of a QA investigation team. You do NOT investigate 
directly — you dispatch specialist agents and synthesize their findings.

## Your Process

### 1. Read State
- .claude/qa-findings.md → what's been verified, what's open
- .claude/qa-known-issues.md → accepted risks (don't re-report)
- .claude/qa-exceptions.md → patterns to ignore
- CLAUDE.md / README → project context

### 2. Select Agents
Deploy only what's needed:
- First run → all agents
- Subsequent → only unverified heuristics + re-verify fixed CRITICALs
- --focus flag → only matching agents
- --visual flag → force Visual Auditor
- No tests → skip test-gap-finder, add WARNING
- No UI → skip visual-auditor

### 3. Dispatch (Parallel)
Launch agents via the Agent tool. Each gets:
- Project description (from CLAUDE.md)
- Their specific focus area
- List of already-verified checks (from findings)
- Known issues to suppress

Independent agents run in parallel. Dependent agents run sequentially.

### 4. Collect & Filter
Gather all findings. For each:
- Confidence ≥ 80? → include
- Confidence 70-79? → run multi-hypothesis testing to upgrade/downgrade
- Confidence < 70? → suppress
- In known-issues? → suppress
- Duplicate of another finding? → merge, keep highest confidence

### 5. Skepticism Check
If iteration ≤ 2 AND total findings = 0:
  "You found nothing. That's suspicious. Pick the least-explored 
   heuristic and investigate it manually. Show your work."

### 6. Update Findings
Append to qa-findings.md with:
- Confidence and criticality scores
- Evidence (exact commands, expected vs actual)
- Hypotheses tested (if multi-hypothesis was used)
- Status (OPEN / FIXED / ACCEPTED)

### 7. Summary
Print a brief summary for the user:
"Iteration 3: Deployed 3 agents. Found 1 WARNING (85 confidence). 
 14/18 heuristics verified. Remaining: visual regression, flaky test check."
```

## State Management

### Loop State (`.claude/qa-monkey.local.md`)
```yaml
---
active: true
iteration: 3
max_iterations: 0
completion_promise: null
fix_mode: false
visual_mode: true
ci_mode: false
focus: null
confidence_threshold: 80
started_at: "2026-04-06T16:00:00Z"
stale_count: 0
---

Investigate this project for bugs and silent failures.
You are a suspicious QA engineer coordinating 6 specialist agents.
Read .claude/qa-findings.md before each iteration.
```

### Stale Detection
The stop hook tracks consecutive iterations with 0 new findings:
- 0 new findings → increment `stale_count`
- Any new finding → reset `stale_count` to 0
- `stale_count >= 3` → system is clean, stop loop

### Git Integration
- All investigation happens on current branch (read-only)
- `--fix` mode: creates `qa-monkey/fix-{n}` branch per fix
- Findings file: `.claude/qa-findings.md` (gitignored by default)
- Screenshots: `.claude/qa-screenshots/` (gitignored)
- User can `git add .claude/qa-findings.md` to track QA history

## Comparison With Existing Tools

| Aspect | QA Monkey | pr-review-toolkit | Ralph Loop | Test Suite |
|--------|-----------|-------------------|------------|-----------|
| When | Anytime | On PR | Dev task | CI |
| Scope | Entire system | Changed files | One task | Defined tests |
| Finds | Silent failures | Code quality | Nothing (builds) | Regression |
| Mode | Investigation | Review | Development | Verification |
| Agents | 6 specialists | 6 specialists | 1 general | 0 |
| Visual | Screenshots | No | No | Maybe (Playwright) |
| Loop | Continuous | One-shot | Continuous | One-shot |
| Output | Findings report | PR comments | Code changes | Pass/fail |

## Distribution

### Open Source (GitHub)
- MIT license
- Published as Claude Code plugin
- README with examples and demo GIF
- Contributing guide for custom agents/heuristics

### Plugin Marketplace
- Listed in Claude Code plugin marketplace
- Free tier: 4 agents, 10 iterations, read-only
- Pro tier: 6 agents (incl. Visual Auditor), unlimited iterations, --fix mode

### Enterprise
- Self-hosted findings dashboard
- Cross-project memory (learn from all QA runs)
- Custom agent marketplace
- Team coordination (multiple monkeys, shared learnings)
- SOC2/HIPAA compliance agents
