<h1 align="center">
  <img src="https://img.shields.io/badge/-Copy-EF4444?style=for-the-badge" alt="Copy" />
  <br/>
  copywriting-strategist
</h1>

<p align="center">
  <strong>Generate strategic and execution angles for copywriting campaigns.</strong><br/>
  Uses the Angle Generation Machine methodology, Schwartz's 7 techniques, and 100+ headline formulas.
</p>

---

## Why This Exists

Most AI-generated ad copy sounds the same because it starts from the product, not the customer. This skill flips the process: start with mass desire (Schwartz), cross it with emotional triggers, and generate dozens of distinct angles — each targeting a different entry point into the customer's world.

## What It Does

Two-phase angle generation:

### Phase 1: Strategic Angles (3-5 per campaign)

Campaign-level positioning ideas. Each one represents a distinct way into the customer's mind.

**A strong strategic angle:**
- Targets a specific persona and awareness level
- Channels an existing desire or fear (not a product feature)
- Has a clear emotional driver
- Can generate dozens of distinct headlines underneath it
- Differentiates from competitor messaging

### Phase 2: Execution Angles (10-20 per strategic angle)

Headline and hook variations that express the strategic angle across formats — questions, statements, story leads, provocative claims, social proof. Flagged by channel: paid social (thumb-stop), email (curiosity gap), or advertorial (editorial tone).

## Schwartz's 7 Techniques

Each technique is matched to an awareness level:

| # | Technique | Best For | Awareness Level |
|---|---|---|---|
| 1 | **Intensification** | Amplifying desire/pain | Problem-Aware |
| 2 | **Identification** | "People like me" connection | Any |
| 3 | **Gradualization** | Incremental belief-building | Product-Aware (skeptical) |
| 4 | **Redefinition** | Reframing the category | Solution-Aware |
| 5 | **Mechanization** | Naming the unique mechanism | Solution-Aware |
| 6 | **Concentration** | Single most powerful claim | Most Aware |
| 7 | **Camouflage** | Hiding the sell entirely | Unaware |

## The Masters Behind the Method

The angle generation process synthesizes principles from 10 copywriting legends:

- **Schwartz & Collier** — Mass desire + entering the existing conversation
- **Caples & Ogilvy** — Headline craft + the Big Idea
- **Halbert & Hopkins** — Specificity + reason-why advertising
- **Kennedy & Bencivenga** — Honesty + proof-stacking
- **Sugarman & Bird** — Emotional triggers + one-to-one communication

## Installation

```bash
git clone https://github.com/lisovet/claude-skills.git /tmp/claude-skills
cp -r /tmp/claude-skills/skills/copywriting-strategist ~/.claude/skills/
```

> **Important:** This skill has 12 reference files including the headline bank and all 7 Schwartz technique breakdowns. You need the whole folder — not just SKILL.md.

## Usage

```
"Give me 5 strategic angles for my energy gel brand"
"Brainstorm hooks for a cold Meta campaign targeting runners"
"What angles should we test for this supplement launch?"
"Generate headline variations for the 'hidden cause' angle"
```

## File Structure

```
copywriting-strategist/
  SKILL.md                                          # Core methodology + workflow
  references/
    angle-generation-matrix.md                      # Framework for crossing desires with mechanisms
    emotional-triggers-library.md                   # Catalog of core human drivers
    schwartz-on-desire.md                           # Key insights on channeling mass desire
    headline-bank.md                                # 100+ proven headline formulas by type
    schwartz-techniques/
      01-intensification.md                         # Amplifying desire/pain
      02-identification.md                          # Building "people like me"
      03-gradualization.md                          # Incremental belief-building
      04-redefinition.md                            # Reframing the category
      05-mechanization.md                           # Naming the unique mechanism
      06-concentration.md                           # Distilling to single claim
      07-camouflage.md                              # Hiding the sell
```

## Pipeline Position

```
[Brand Skill] → STRATEGIST → [Formatter] → [Optimizer] → [Ad Validator]
                  ▲ THIS SKILL
```

**Input:** A brand skill for product context (customer avatars, competitive landscape, voice).

**Output:** 3-5 strategic angles + 10-20 execution angles per strategic angle.

**Next step:** Hand the best execution angles to a formatter to produce finished copy.

## Works With

| Skill | Relationship |
|---|---|
| **conversion-architect** | Use Architect first to diagnose page issues, then Strategist for angles |
| **Brand skills** | Always pair with a brand skill for product/audience context |

## License

MIT
