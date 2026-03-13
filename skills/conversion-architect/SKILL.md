---
name: conversion-architect
description: >
  The design intelligence layer for DTC landing pages and funnels. Audit
  underperforming pages, architect new structures, choose the right format
  for a traffic source, or diagnose why a funnel isn't converting. Contains
  20 mental models across 5 categories. Trigger on any request to review,
  audit, wireframe, structure, or optimize a landing page, PDP, homepage,
  quiz results page, advertorial, or funnel. Also trigger on "what's wrong
  with this page," "why isn't this converting," "what page type should I
  use," or references to model names (belief chain, value stack, unique
  mechanism, MECLABS, emotional sequencing, contrast framing, etc.).
  Foundational reference layer informing copywriting-strategist, formatter,
  advertorial-writer, and reasons-listicle-lander. Always pair with the
  relevant brand skill.
---

# Conversion Architect

This skill provides the mental models Claude uses to **audit, architect, and optimize any DTC landing page or funnel.** It doesn't produce a specific deliverable — that's what the formatter, listicle lander, and advertorial writer do. This skill provides the *judgment* those skills rely on.

Think of it as the difference between knowing how to swing a hammer (the other skills) and knowing which wall to hit first (this skill).

## Where This Sits in the Pipeline

```
                    ┌──────────────────────────┐
                    │   CONVERSION ARCHITECT    │  ← Consult for strategy,
                    │   (20 Mental Models)      │     audits, wireframes,
                    └─────────┬────────────────┘     page-format decisions
                              │
              ┌───────────────┼───────────────┐
              ▼               ▼               ▼
       [Strategist]    [Listicle Lander]  [Advertorial]
              │          [Formatter]        Writer
              ▼               │               │
       [Ad Validator] ◄──────┴───────────────┘
```

**Not a pipeline step.** A reference layer any skill can draw from, or that stands alone for audits and architecture tasks.

**Input:** A page URL, wireframe, copy draft, or a "build me a page" request — plus a brand skill for product context.

**Output:** A diagnostic score, a page architecture, a format recommendation, or specific model-level fixes — depending on the task.

## The 20 Models — Quick Reference

| # | Model | Audit Question | Cat |
|---|-------|---------------|-----|
| 1 | **Conversion Diagnostic** | Does the traffic match the page? Is motivation → value → incentive → anxiety addressed in weight order? | A |
| 2 | **Belief Chain** | What beliefs must be true before purchase, and does the page install them in sequence? | A |
| 3 | **Curiosity Gap** | Does each section create enough pull to drag the reader into the next one? | A |
| 4 | **Unique Mechanism** | Can the reader explain WHY this product works differently — not just WHAT it does? | A |
| 5 | **Persuasion Engine** | Can I name the persuasion function of every page section, and do they flow logically? | P |
| 6 | **Emotional Sequencing** | What emotion does the reader feel at each scroll-depth, and does the arc build toward action? | P |
| 7 | **Narrative Transport** | Is the page format (story vs. argument vs. list) matched to traffic temp and belief complexity? | P |
| 8 | **The One Reader** | Would one specific person from the target audience feel this was written for them personally? | P |
| 9 | **Specificity Trigger** | Can any vague claim be replaced with a number, name, date, or concrete example? | C |
| 10 | **Strategic Honesty** | Does the page make at least one calibrated admission that builds trust for claims that follow? | C |
| 11 | **Social Proof Architecture** | Is every proof element placed next to the specific claim it validates — not dumped in one section? | C |
| 12 | **Voice-of-Customer** | Does the copy use language the customer actually uses, or does it sound like a marketer wrote it? | C |
| 13 | **Value Stack** | Does the offer section make total perceived value obviously greater than the price? | O |
| 14 | **Objection Map** | Have the top 5 objections been identified, and can I point to where each is addressed? | O |
| 15 | **Risk Reversal** | What does the customer risk by buying, and has the page eliminated or reversed every risk? | O |
| 16 | **Micro-Commitment Ladder** | What's the smallest first commitment, and does each subsequent ask feel like a natural next step? | O |
| 17 | **Urgency-Scarcity Calibration** | Is there a credible, specific reason to act today instead of tomorrow? | U |
| 18 | **Contrast Framing** | Has the page made the reader's current reality feel unacceptable compared to life with this product? | U |
| 19 | **Pattern Interrupt** | Is there at least one moment where the reader is forced to stop scrolling and actually read? | U |
| 20 | **Intensification Loop** | If the visitor doesn't convert today, is there a system that brings them back with higher intent? | U |

Categories: **A** = Awareness & Intent, **P** = Persuasion Architecture, **C** = Proof & Credibility, **O** = Offer & Commitment, **U** = Urgency & Action

## Workflow 1: Auditing an Existing Page

Use when someone says "review my page," "why isn't this converting," or "what's wrong with this funnel."

### Step 1: Run the Conversion Diagnostic (Model 1)

Read `references/01-awareness-and-intent.md` → Model 1.

Score each MECLABS variable 1–5:

- **Motivation (4x weight):** Is the traffic source sending motivated people? Does the page open with the same promise the ad made?
- **Value Proposition (3x weight):** Can a visitor articulate in 5 seconds why they should buy HERE vs. alternatives?
- **Incentive minus Friction (2x weight):** Does the offer outweigh the effort? How many steps/fields/clicks to convert?
- **Anxiety (−2x weight):** What fears remain unaddressed? Missing guarantee? No proof? Unclear pricing?

**The variable with the lowest score is where you focus.** Don't optimize copy (Value) when the traffic is wrong (Motivation). Don't add urgency (Incentive) when the guarantee is missing (Anxiety).

### Step 2: Map the Belief Chain (Model 2)

Read `references/01-awareness-and-intent.md` → Model 2.

List every belief that must be true before purchase. For a DTC supplement, that chain typically looks like:

1. My struggle isn't my fault (reframe the blame)
2. It's caused by [specific mechanism] (educate on root cause)
3. [Mechanism] can be targeted naturally (category credibility)
4. This specific product targets it effectively (product credibility)
5. It's safe and proven (trust layer)
6. The offer is good and the risk is low (commercial close)

Walk through the page: does it install each belief in sequence? Is any link missing or out of order? **A broken chain is the #1 reason "well-written pages don't convert."**

### Step 3: Check the Emotional Arc (Model 6)

Read `references/02-persuasion-architecture.md` → Model 6.

The optimal DTC emotional sequence:
```
Curiosity → Recognition → Agitation → Hope → Trust → Desire → Confidence → Action
```

Map each page section to the emotion it triggers. Common failures:
- Opening with urgency before establishing empathy
- Stacking negative emotions without relief
- Placing social proof before the reader cares
- Asking for the sale before building confidence (no risk reversal)

### Step 4: Run the 20-Question Audit

Score each question in the Quick Reference table 1–5. The three lowest scores are the priority fixes.

### Step 5: Prioritize Fixes by MECLABS Weight

1. Motivation/traffic match issues (4x) — wrong format, wrong audience
2. Value proposition issues (3x) — unclear differentiation, missing mechanism
3. Incentive/friction issues (2x) — weak offer, too many steps
4. Anxiety issues (−2x) — missing proof, no guarantee, unaddressed objections

## Workflow 2: Architecting a New Page

Use when someone says "build me a landing page," "wireframe this funnel," or "what page should I build."

### Step 1: Define the One Reader (Model 8)

One persona. One page. Name, situation, primary pain, primary desire, awareness level. If the product serves multiple personas → multiple pages.

### Step 2: Determine Traffic Temperature

- **Cold (Meta prospecting, display, content):** Problem-Aware or Unaware. Needs education first.
- **Warm (retargeting, email, organic search):** Solution-Aware or Product-Aware. Can lead with product.
- **Hot (branded search, repeat visitors, cart abandoners):** Most Aware. Get to the offer fast.

### Step 3: Choose the Page Format

Read `references/06-page-type-playbooks.md` for format-specific guidance.

```
Cold traffic AND belief chain 4+ steps?
  → Advertorial (use advertorial-writer skill)

Warm traffic AND 5+ distinct objections to address?
  → Listicle Lander (use reasons-listicle-lander skill)

Product is personal/complex AND benefits from personalization?
  → Quiz Funnel (micro-commitment ladder, Model 16)

Warm-to-hot traffic AND straightforward product?
  → Hero Landing Page (product-focused)

None of the above?
  → Default to Listicle Lander — most versatile format.
```

**Performance benchmarks:**
- **Advertorials:** 15% CTR to LP, 60–70% LP conversion (Hint Water/Sharma)
- **Quiz funnels:** 37.6% start-to-lead, 20% quiz-to-purchase (Jones Road), 2x LTV (Bambu Earth)
- **Listicle landers:** 34+ sec extra engagement vs. standard pages
- **Hero LPs:** Long-form generates 220% more leads for complex products
- **Median LP conversion rate:** 6.6% across all industries

### Step 4: Map the Belief Chain (Model 2)

What must be true before they buy? Write out every prerequisite belief. This determines content order.

### Step 5: Design the Emotional Arc (Model 6)

Assign an emotion to each planned section. Verify the arc builds toward action.

### Step 6: Select Models per Section

| Section | Primary Models |
|---------|---------------|
| Hero | Curiosity Gap (3), One Reader (8), Specificity (9) |
| Problem | Contrast Framing (18), Voice-of-Customer (12) |
| Mechanism | Unique Mechanism (4), Belief Chain step (2) |
| Proof | Social Proof Architecture (11), Strategic Honesty (10) |
| Offer | Value Stack (13), Risk Reversal (15) |
| CTA | Urgency Calibration (17), Micro-Commitment (16) |

### Step 7: Build and Validate

Hand off to the appropriate skill with the architecture defined. After the draft, run Workflow 1 (Audit) as a QA pass. Then send through ad-validator.

## Model Selection by Page Type

| Page Type | Critical Models | Supporting |
|-----------|----------------|------------|
| **Homepage** | 1, 5, 8, 18 | 3, 9, 11 |
| **PDP** | 9, 11, 13, 14, 15 | 4, 6, 17 |
| **Quiz Results** | 2, 6, 8, 16 | 9, 13, 15 |
| **Advertorial** | 1, 2, 3, 4, 7 | 6, 9, 10, 18 |
| **Listicle Lander** | 2, 9, 11, 14, 18 | 6, 10, 13, 17 |
| **VSL Page** | 3, 5, 6, 7 | 2, 13, 17 |
| **Post-Purchase Upsell** | 13, 15, 16, 17 | 9, 11 |
| **Email Sequence** | 3, 16, 17, 20 | 4, 9, 18 |

## Quick Audit Checklist

Score each 1–5 against any page:

- [ ] (1) Headline matches the traffic source's promise
- [ ] (2) Prerequisite beliefs installed in order before asking for the sale
- [ ] (3) Each section pulls reader into the next — no safe stopping points
- [ ] (4) Reader can explain the product's unique mechanism in one sentence
- [ ] (5) Every section has a named persuasion function feeding the next
- [ ] (6) Emotional arc builds: recognition → agitation → hope → proof → action
- [ ] (7) Page format matched to traffic temperature
- [ ] (8) One person from target audience would feel this was written for them
- [ ] (9) At least 3 vague claims replaced with specific numbers or examples
- [ ] (10) Page includes at least one honest concession building credibility
- [ ] (11) Social proof placed next to the claims it validates
- [ ] (12) Copy uses customer language (from reviews, tickets, forums)
- [ ] (13) Offer section makes total value obviously exceed the price
- [ ] (14) Top 5 objections addressed — can point to where on page
- [ ] (15) Guarantee stated next to the CTA, not buried in footer
- [ ] (16) First commitment is small enough to feel effortless
- [ ] (17) Credible, specific reason to act today
- [ ] (18) Current reality made to feel unacceptable vs. life with product
- [ ] (19) At least one scroll-stopping moment breaking the visual rhythm
- [ ] (20) System in place to bring non-converters back with higher intent

## Anti-Patterns

**The Beautiful-But-Empty Page:** Gorgeous design, no belief chain. Assumes the visitor already understands and trusts. Common with designer-led pages that prioritize aesthetics over persuasion architecture.

**The Everything Page:** Speaks to cold, warm, and hot traffic simultaneously. Too long for hot, too salesy for cold. One page per reader, one page per awareness level.

**The Copy-Perfect Misfire:** Headlines are sharp, copy is specific, CTAs are strong — but the page skips the first 3 beliefs in the chain for cold traffic. Excellent writing, wrong structure. **The #1 reason well-written pages fail.**

**The Proof Desert:** Long brand claims with no evidence. All social proof in one section at the bottom. Reader bounced before reaching it.

**The Fake Urgency Trap:** Timers that reset. "Limited stock!" on evergreen products. "Ends tonight!" posted weekly. DTC consumers in health/wellness detect and punish this.

**The Objection Ignorer:** Enthusiastic about benefits, silent on price, shipping, side effects, and "will it work for me?" Unanswered objections become reasons not to buy.

## Pipeline Integration

| Skill | How This Feeds It |
|-------|-------------------|
| **Brand skills** | Brand = product context. Architect = structural strategy. |
| **Strategist** | Evaluate angles: right awareness level (1)? Leverages mechanism (4)? Creates curiosity gap (3)? |
| **Formatter** | Ensures chosen template serves the right persuasion function for page position. |
| **Advertorial writer** | Models 2, 3, 4, 6, 7, 10 are core to advertorial architecture. Design belief chain + emotional arc before handing off. |
| **Listicle lander** | Models 2, 9, 11, 14, 18 map to listicle structure. Each reason should be a belief chain step or objection. |
| **Ad validator** | Provides the 20-question structural criteria to stress-test against. |
| **Optimizer** | Testing hypotheses should target weakest model-scores from audit. Don't A/B test headlines when the belief chain is broken. |

## Bundled Reference Files

| File | Contents | When to Read |
|------|----------|-------------|
| `references/01-awareness-and-intent.md` | Models 1–4: Conversion Diagnostic (MECLABS), Belief Chain, Curiosity Gap, Unique Mechanism. | **Read for audits** (always start here) and when architecting a page's opening/positioning. |
| `references/02-persuasion-architecture.md` | Models 5–8: Persuasion Engine, Emotional Sequencing, Narrative Transport, The One Reader. | Read when designing page flow, choosing story vs. argument, or diagnosing why a page "feels off." |
| `references/03-proof-and-credibility.md` | Models 9–12: Specificity Trigger, Strategic Honesty, Social Proof Architecture, Voice-of-Customer. | Read when strengthening proof, selecting/placing testimonials, or rewriting copy in customer language. |
| `references/04-offer-and-commitment.md` | Models 13–16: Value Stack, Objection Map, Risk Reversal, Micro-Commitment Ladder. | Read when designing offer sections, quiz funnels, or handling objections. |
| `references/05-urgency-and-action.md` | Models 17–20: Urgency Calibration, Contrast Framing, Pattern Interrupt, Intensification Loop. | Read when adding urgency, designing retargeting, or creating villain positioning. |
| `references/06-page-type-playbooks.md` | Format decision tree + section-by-section architecture for: Advertorial, Listicle, Quiz Funnel, Hero LP. | **Read for new page builds** — detailed format guidance. |

## Key DTC Benchmarks

- **Median LP conversion:** 6.6% (Unbounce, 464M visitors)
- **Food & Beverage DTC:** 3.7–6.2% · **Supplements:** 1.8–4.2% · **Beauty:** 1.8–2.3%
- **Quiz start-to-lead:** 37.6% ecommerce avg · **Email traffic LP conversion:** 19.3%
- **Mobile share of LP traffic:** 82.9% (desktop converts ~2x higher)
- **Load time penalty:** −7% conversion per additional second
- **Reviews impact:** 5+ reviews = +270% purchase likelihood · Optimal rating: 4.75–4.99
- **Message-match (ad → headline):** Has never lost an A/B test (Oli Gardner)
- **Only ~6% of DTC brands** send paid traffic to dedicated LPs — those that do cut CAC 30–40%
