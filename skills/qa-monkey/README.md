# QA Monkey

A Claude Code plugin that acts as a suspicious, curious QA engineer. It continuously probes your project for bugs, silent failures, and visual inconsistencies using 6 specialist agents.

## Quick Start

```
/qa-monkey
```

That's it. QA Monkey reads your project, figures out what to check, and starts investigating.

## Commands

### Investigation
| Command | Description |
|---------|-------------|
| `/qa-monkey` | Start investigating (loops until clean or cancelled) |
| `/qa-monkey "check the API"` | Focus on a specific area |
| `/qa-monkey --visual` | Include Puppeteer UI/screenshot testing |
| `/qa-monkey --fix` | Investigate, then auto-chain into remediation |
| `/qa-monkey --ci` | Single pass, exit code for CI pipelines |
| `/qa-findings` | Show current findings report |
| `/cancel-qa` | Stop the investigation loop |

### Remediation
| Command | Description |
|---------|-------------|
| `/qa-fix` | Fix all CRITICAL + WARNING findings via TDD |
| `/qa-fix --critical-only` | Only fix CRITICAL findings |
| `/qa-fix --finding CRITICAL-001` | Fix a specific finding |
| `/qa-fix --dry-run` | Generate PRDs only, don't implement |
| `/qa-fix --batch` | All fixes in one PR (default: one PR per fix) |
| `/qa-fix --prd full` | Full PRD with user journey (for UX fixes) |

## Investigation Options

| Flag | Default | Description |
|------|---------|-------------|
| `--max-iterations N` | unlimited | Stop after N iterations |
| `--fix` | off | Auto-chain into remediation after investigation |
| `--visual` | off | Include Puppeteer screenshot testing |
| `--ci` | off | Single pass, exit with code 0 (clean) or 1 (findings) |
| `--confidence N` | 80 | Minimum confidence to report (0-100) |
| `--focus AREA` | all | Focus on: api, ui, tests, config, data |
| `--completion-promise TEXT` | none | Stop when this text is output |

## Remediation Options

| Flag | Default | Description |
|------|---------|-------------|
| `--critical-only` | off | Only fix CRITICAL findings |
| `--finding ID` | all | Fix a specific finding by ID |
| `--dry-run` | off | Generate PRDs only, don't implement |
| `--prd full\|lightweight` | auto | Force PRD format |
| `--batch` | off | All fixes in one PR |
| `--auto-approve-low-risk` | off | Skip approval for low-risk fixes |
| `--merge` | off | Offer to merge PR (still confirms) |
| `--max-loops N` | 3 | Max fix attempts before escalating |
| `--timeout N` | 15 | Per-fix timeout in minutes |

## Specialist Agents

| Agent | Focus |
|-------|-------|
| Invariant Checker | Domain rules and guardrails from CLAUDE.md |
| Silent Failure Hunter | Swallowed exceptions, empty catch blocks |
| Drift Detector | Config vs runtime divergence |
| Data Integrity Auditor | Counts, math, timestamps, consistency |
| Test Gap Finder | Coverage gaps, missing edge cases |
| Visual Auditor | Puppeteer screenshots, UI vs API matching |

## How It Works

### Investigation (`/qa-monkey`)
1. Orchestrator reads your project context and previous findings
2. Selects relevant specialist agents (skips what's already verified)
3. Agents investigate in parallel, produce evidence-backed findings
4. Findings scored by confidence (0-100) and criticality (1-10)
5. Only high-confidence findings (>=80) are reported
6. Loop continues until clean or max iterations reached
7. Optionally chains into remediation (with `--fix` or when asked)

### Remediation (`/qa-fix`)
1. Triages findings by severity, groups related issues
2. Generates remediation PRDs (lightweight for bugs, full for UX issues)
3. Reviews PRDs for scope creep and risk
4. Shows all plans for batch approval
5. Implements each fix via TDD (failing tests first, then minimal fix)
6. Runs quality gates (test, lint, typecheck)
7. Verifies the fix resolves the original finding
8. Pushes and creates PR (per-fix or batched)

## Findings

Findings are stored in `.claude/qa-findings.md` and persist across sessions.

Each finding includes:
- **Confidence score** (0-100) — how sure is the monkey?
- **Criticality** (1-10) — how bad is it?
- **Evidence** — "I ran X, expected Y, got Z"
- **Hypotheses tested** — what was ruled out

## Customization

### Known Issues
Create `.claude/qa-known-issues.md` to suppress accepted risks:
```markdown
## Pre-existing test failures
Accepted: 2026-04-06
Reason: Only fails on Python 3.9, prod uses 3.10
```

### Custom Heuristics
Create `.claude/qa-heuristics.md` to add project-specific checks:
```markdown
## User Count Consistency
Trigger: project has user_service.py
Method: Compare active users in /health vs /api/users?status=active
Expected: Same count within 5%
```

## License

MIT
