<p align="center">
  <img src="https://img.shields.io/badge/Claude_Code-Skills-7C3AED?style=for-the-badge&logo=data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cGF0aCBkPSJNMTIgMkw0IDdWMTdMMTIgMjJMMjAgMTdWN0wxMiAyWiIgZmlsbD0id2hpdGUiLz48L3N2Zz4=&logoColor=white" alt="Claude Code Skills" />
  <img src="https://img.shields.io/github/license/lisovet/claude-skills?style=for-the-badge&color=22c55e" alt="MIT License" />
  <img src="https://img.shields.io/badge/skills-4-blue?style=for-the-badge" alt="4 Skills" />
</p>

<h1 align="center">Claude Skills</h1>

<p align="center">
  <strong>Drop-in skills for Claude Code that turn it into a specialist.</strong><br/>
  iOS design &bull; AI image generation &bull; DTC copywriting &bull; Landing page architecture
</p>

---

## What Are Skills?

Skills are markdown instruction files that give Claude Code deep domain expertise. Install one and Claude gains an opinionated, battle-tested workflow for that domain — not just knowledge, but *judgment*.

Each skill is a `SKILL.md` file (with optional reference docs) that you drop into `~/.claude/skills/`. Claude Code loads them automatically.

---

## Skills

### Design & Development

| | Skill | What It Does |
|---|---|---|
| <img src="https://img.shields.io/badge/-SwiftUI-007AFF?style=flat-square&logo=swift&logoColor=white" /> | **[ios-frontend-design](skills/ios-frontend-design/)** | An opinionated creative director for iOS apps. Produces distinctive SwiftUI interfaces that honor HIG while rejecting the generic "AI-generated app" look. Includes anti-slop patterns, color palette methodology, adaptive layout system, and worked examples. |

### AI Image Generation

| | Skill | What It Does |
|---|---|---|
| <img src="https://img.shields.io/badge/-Gemini-4285F4?style=flat-square&logo=google&logoColor=white" /> | **[ad-creator](skills/ad-creator/)** | Generates ad images using Google's Nano Banana (Gemini) API. Comes with a Python generation script, 40 proven DTC ad templates (social proof, comparison, UGC, editorial, and more), and an interactive prompt-crafting workflow. |

### DTC Copywriting & Conversion

| | Skill | What It Does |
|---|---|---|
| <img src="https://img.shields.io/badge/-Strategy-F59E0B?style=flat-square" /> | **[conversion-architect](skills/conversion-architect/)** | 20 mental models for auditing and architecting DTC landing pages. Covers MECLABS diagnostics, belief chains, emotional sequencing, objection mapping, and more. The strategic foundation layer for all copywriting skills. |
| <img src="https://img.shields.io/badge/-Copy-EF4444?style=flat-square" /> | **[copywriting-strategist](skills/copywriting-strategist/)** | Generates campaign angles using the Angle Generation Machine methodology. Includes Schwartz's 7 techniques, 100+ headline formulas, emotional triggers library, and a systematic process for turning brand knowledge into high-converting hooks. |

<details>
<summary><strong>How the copywriting skills work together</strong></summary>

```
┌─────────────────────────┐
│   conversion-architect  │  Audit existing pages or
│   (20 Mental Models)    │  architect new ones
└──────────┬──────────────┘
           │
           ▼
┌─────────────────────────┐
│  copywriting-strategist │  Generate strategic angles
│  (Angle Generation)     │  and headline variations
└──────────┬──────────────┘
           │
           ▼
     [ Your copy ]
```

Start with **conversion-architect** to diagnose what's wrong or plan what to build.
Then use **copywriting-strategist** to generate the angles and headlines.

</details>

---

## Installation

### One command (recommended)

```bash
/install-skill lisovet/claude-skills/skills/<skill-name>
```

Available skill names: `ios-frontend-design`, `ad-creator`, `conversion-architect`, `copywriting-strategist`

### Manual install

```bash
# Clone and copy the skill you want
git clone https://github.com/lisovet/claude-skills.git /tmp/claude-skills
cp -r /tmp/claude-skills/skills/<skill-name> ~/.claude/skills/
```

Or grab a single skill with curl:

```bash
mkdir -p ~/.claude/skills/<skill-name>
curl -sL https://raw.githubusercontent.com/lisovet/claude-skills/main/skills/<skill-name>/SKILL.md \
  -o ~/.claude/skills/<skill-name>/SKILL.md
```

> **Note:** Skills with `references/` directories (conversion-architect, copywriting-strategist, ad-creator) need the entire folder, not just the SKILL.md. Use the clone or `/install-skill` method for those.

### Verify

After installing, the skill appears in Claude Code automatically. Invoke it with `/<skill-name>` or let it activate based on context.

---

## Adding Your Own Skills

```
skills/
  your-skill/
    SKILL.md              # Required — YAML frontmatter + instructions
    references/           # Optional — supporting docs loaded on demand
    scripts/              # Optional — automation scripts
```

A minimal `SKILL.md`:

```yaml
---
name: your-skill
description: >
  What this skill does and when Claude should activate it.
---

# Your Skill Name

Instructions go here.
```

---

## License

MIT
