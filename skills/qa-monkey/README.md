<p align="center">
  <img src="https://img.shields.io/badge/Claude_Code-Plugin-7C3AED?style=for-the-badge" alt="Claude Code Plugin" />
  <img src="https://img.shields.io/badge/Agents-6-EF4444?style=for-the-badge" alt="6 Agents" />
  <img src="https://img.shields.io/badge/Heuristics-14-F59E0B?style=for-the-badge" alt="14 Heuristics" />
  <img src="https://img.shields.io/badge/license-MIT-22c55e?style=for-the-badge" alt="MIT" />
</p>

<h1 align="center">QA Monkey</h1>

<p align="center">
  <strong>The paranoid QA engineer your codebase needs.</strong><br/>
  <em>6 specialist AI agents that continuously probe your project for bugs nobody else caught.</em>
</p>

---

## Why This Exists

CI passes. Deploys succeed. Health endpoints return 200. But underneath:

- A feature shipped but was never wired up
- Two systems do the same thing, neither fully working
- A cron job was set up but never actually ran
- The dashboard shows numbers that don't match the API
- An env var is set but the firewall blocks the URL — code falls back silently

These bugs don't crash the app. They silently corrupt data, waste resources, or make features useless. They're only found when a human gets suspicious and starts digging.

Tests check *expected* behavior. Linters check style. Neither checks whether your system *actually works*.

**QA Monkey automates the suspicion.**

---

## Works With Any Project

QA Monkey reads your codebase and adapts. No config required.

| Stack | What it checks |
|-------|---------------|
| **Python** (Django, Flask, FastAPI) | endpoints, env vars, test coverage, error handling |
| **Node/TypeScript** (Express, Next.js) | API routes, .env drift, empty catches, dead code |
| **Go** | config mismatches, unused imports, test gaps |
| Any project with a **health endpoint** | data consistency, response quality, staleness |
| Any project with a **UI** | screenshot comparison, API vs display, interactive probes |

---

## Quick Start

```
/qa-monkey
```

No args needed. It reads your project, figures out what to check, and starts investigating.

## Installation

```bash
git clone https://github.com/lisovet/claude-skills.git /tmp/claude-skills
cp -r /tmp/claude-skills/skills/qa-monkey ~/.claude/plugins/qa-monkey
```

Restart Claude Code, then run `/qa-monkey` in any project.

---

## Commands

| Command | Description |
|---------|-------------|
| `/qa-monkey` | Start investigating (loops until clean or cancelled) |
| `/qa-monkey "check the API"` | Focus on a specific area |
| `/qa-monkey --visual` | Include Puppeteer UI/screenshot testing |
| `/qa-monkey --fix` | Auto-fix critical issues (on a branch) |
| `/qa-monkey --ci` | Single pass, exit code for CI pipelines |
| `/qa-findings` | Show current findings report |
| `/cancel-qa` | Stop the investigation loop |

## Options

| Flag | Default | Description |
|------|---------|-------------|
| `--max-iterations N` | unlimited | Stop after N iterations |
| `--fix` | off | Allow auto-fixes on critical issues |
| `--visual` | off | Include Puppeteer screenshot testing |
| `--ci` | off | Single pass, exit with code 0 (clean) or 1 (findings) |
| `--confidence N` | 80 | Minimum confidence to report (0-100) |
| `--focus AREA` | all | Focus on: api, ui, tests, config, data |
| `--completion-promise TEXT` | none | Stop when this text is output |

---

## The 6 Agents

### Invariant Checker
Reads your `CLAUDE.md` and project rules, then verifies they're actually enforced in code.
> *"CLAUDE.md says max retries is 5. The code sets it but never checks the limit."*

### Silent Failure Hunter
Finds swallowed exceptions, empty catch blocks, and functions that fail silently.
> *"This function catches all exceptions and returns None. 47 callers assume it returns a dict."*

### Drift Detector
Compares config across layers: code defaults, `.env`, deployment vars, and runtime values.
> *"REDIS_URL is in .env.example but not set in production. Code silently uses localhost."*

### Data Integrity Auditor
Finds multiple sources of truth for the same data and compares them.
> *"Health endpoint says 3,706 active records. API says 9,802. Which is right?"*

### Test Gap Finder
Runs your test suite, analyzes coverage, and identifies critical untested code paths.
> *"The discount calculation has 0% test coverage. Different formula for percentage vs fixed type."*

### Visual Auditor *(opt-in with `--visual`)*
Takes Puppeteer screenshots, compares UI to API data, and tests interactive elements.
> *"Dashboard shows 0 active users. API returns 4,385. Data binding broken on first load."*

---

## How It Works

1. Orchestrator reads your project context and previous findings
2. Selects relevant specialist agents (skips what's already verified)
3. Agents investigate in parallel, produce evidence-backed findings
4. Findings scored by confidence (0-100) and criticality (1-10)
5. Only high-confidence findings (>=80) are reported
6. Loop continues until clean or max iterations reached

## Example Finding

```
### CRITICAL [confidence: 95, criticality: 9]
**Background job processor stuck — 3,855 jobs pending**
- Checked: completed count over 2 polls → 80 both times (flat)
- Expected: growing ~30/poll
- Found: worker pool missing job processor registration
- Hypotheses: [code broken ✗] [queue not draining ✓] [jobs not created ✗]
```

---

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

---

## What It's Not

| Tool | What it does | QA Monkey |
|------|-------------|-----------|
| **Test runner** | Checks expected behavior | Finds *unexpected* bugs nobody wrote tests for |
| **Linter** | Checks code style | Checks if the system *actually works* |
| **Chaos engineering** | Breaks things to test resilience | Finds things that are *already broken* |

## File Structure

```
skills/qa-monkey/
├── commands/         # slash command definitions
├── agents/           # 6 specialist agent prompts
├── hooks/            # stop hook for iteration loop
├── scripts/          # setup script
└── templates/        # findings & known issues templates
```

## License

MIT
