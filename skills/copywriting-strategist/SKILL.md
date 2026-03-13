---
name: copywriting-strategist
description: Generates strategic and execution angles for copywriting campaigns using the Angle Generation Machine methodology. Use this skill whenever someone needs ad angles, campaign ideas, hook brainstorms, headline variations, strategic positioning for ads, or creative direction for any marketing campaign. Trigger this whenever the user says things like "give me angles," "brainstorm hooks," "campaign ideas," "what angles should we test," "headline variations," "ad concepts," or asks for creative direction on any paid or organic marketing initiative. This is Step 1 of the copywriting pipeline — use it BEFORE copywriting-formatter, and always pair it with the relevant brand skill (e.g., vitalfuel-brand) for product context.
---

# Copywriting Strategist Skill

This skill generates the raw strategic and creative material that feeds the rest of the copywriting pipeline. It uses the Angle Generation Machine methodology to brainstorm campaign-level positioning ideas and headline-level execution angles by synthesizing brand knowledge, customer psychology, and the principles of the 10 copywriting masters.

## Where This Sits in the Pipeline

```
[Brand Skill] → STRATEGIST → [Formatter] → [Optimizer] → [Ad Validator]
                  ▲ YOU ARE HERE
```

**Input:** A brand skill (e.g., `vitalfuel-brand`) that provides product details, customer avatars, competitive landscape, and voice guidelines.

**Output:** 3-5 strategic angles AND 10-20 execution angles (headlines/hooks) per strategic angle.

**Next step:** Hand the best execution angles to `copywriting-formatter` to apply a proven format and produce finished copy.

## Core Principles from the Masters

The angle generation process is grounded in the timeless principles of the 10 copywriting greats:

- **Eugene Schwartz & Robert Collier:** Mass desire and customer psychology are the foundation of the Angle Generation Matrix. Enter the conversation already happening in the reader's mind.
- **John Caples & David Ogilvy:** The headline and the "Big Idea" guide execution angle generation. The headline is 80% of the work.
- **Gary Halbert & Claude Hopkins:** Specificity and "reason-why" ensure angles are backed by substance, not fluff.
- **Dan Kennedy & Gary Bencivenga:** Honesty and proof-stacking validate angle strength. Damaging admissions build trust.
- **Joe Sugarman & Drayton Bird:** Emotional triggers and one-to-one communication are woven into every creative direction.

## Workflow

### Phase 1: Generate Strategic Angles

**Goal:** Identify 3-5 campaign-level positioning ideas that each represent a distinct entry point into the customer's world.

**Process:**
1. Read the relevant brand skill to understand customer personas, product details, competitive landscape, and voice.
2. Read `references/angle-generation-matrix.md` to populate the matrix — crossing customer desires/fears with product mechanisms and proof points.
3. Read `references/emotional-triggers-library.md` to identify which core human drivers apply to each persona.
4. Read `references/schwartz-on-desire.md` to ensure angles channel existing desire rather than trying to create new demand.
5. Output the top 3-5 strategic angles, each with a clear thesis, target persona, awareness level, and emotional driver.

**A strong strategic angle:**
- Targets a specific persona and awareness level
- Channels an existing desire or fear (Schwartz)
- Has a clear emotional driver (not just a product feature)
- Can generate dozens of distinct headlines underneath it
- Differentiates from competitor messaging

### Phase 2: Generate Execution Angles

**Goal:** Generate 10-20 headline/hook variations for each strategic angle.

**Process:**
1. Take one strategic angle as input.
2. Read `references/headline-bank.md` for proven headline formulas and patterns.
3. Read the relevant Schwartz technique files in `references/schwartz-techniques/` to apply the appropriate technique for the awareness level:
   - Unaware → `07-camouflage.md` (hide the sell)
   - Problem-Aware → `01-intensification.md` (amplify the pain)
   - Solution-Aware → `04-redefinition.md` or `05-mechanization.md` (new mechanism)
   - Product-Aware → `03-gradualization.md` (build belief incrementally)
   - Most-Aware → `06-concentration.md` (lead with offer/proof)
4. Generate 10-20 specific headlines and hooks that express the strategic angle, varying by format (question, statement, story lead, provocative claim, social proof, etc.).
5. Flag which headlines are strongest for paid social (thumb-stop potential) vs. email (curiosity gap) vs. advertorial (editorial tone).

## Bundled Resources

| File | What It Contains | When to Read |
|------|-----------------|--------------|
| `references/angle-generation-matrix.md` | Framework and examples for crossing desires with mechanisms | Phase 1 — generating strategic angles |
| `references/emotional-triggers-library.md` | Catalog of core human drivers and emotional triggers | Phase 1 — identifying emotional entry points |
| `references/schwartz-on-desire.md` | Key insights from Schwartz on channeling mass desire | Phase 1 — grounding angles in existing demand |
| `references/headline-bank.md` | 100+ proven headline formulas categorized by type | Phase 2 — generating execution angles |
| `references/schwartz-techniques/` | Detailed breakdowns of Schwartz's 7 core techniques | Phase 2 — applying the right technique for the awareness level |

### Schwartz Techniques Reference

| # | Technique | Best For | File |
|---|-----------|----------|------|
| 1 | Intensification | Amplifying desire/pain for Problem-Aware audiences | `01-intensification.md` |
| 2 | Identification | Building "people like me" connection | `02-identification.md` |
| 3 | Gradualization | Incremental belief-building for skeptical audiences | `03-gradualization.md` |
| 4 | Redefinition | Reframing the product/category for Solution-Aware | `04-redefinition.md` |
| 5 | Mechanization | Naming and explaining the unique mechanism | `05-mechanization.md` |
| 6 | Concentration | Distilling to the single most powerful claim | `06-concentration.md` |
| 7 | Camouflage | Hiding the sell for Unaware audiences | `07-camouflage.md` |
