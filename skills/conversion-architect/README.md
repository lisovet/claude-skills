<h1 align="center">
  <img src="https://img.shields.io/badge/-Strategy-F59E0B?style=for-the-badge" alt="Strategy" />
  <br/>
  conversion-architect
</h1>

<p align="center">
  <strong>20 mental models for auditing, architecting, and optimizing DTC landing pages.</strong><br/>
  The strategic foundation layer for the entire copywriting pipeline.
</p>

---

## Why This Exists

Most landing pages fail for structural reasons, not copy reasons. A page can have sharp headlines and specific proof — and still not convert because it skips three beliefs in the customer's decision chain, or puts social proof where nobody scrolls, or addresses objections the reader hasn't thought of yet.

This skill gives Claude the diagnostic framework to identify *why* a page isn't working and the architectural playbooks to build one that does.

## The 20 Mental Models

Organized into 5 categories:

### A — Awareness & Intent

| # | Model | The Question It Answers |
|---|---|---|
| 1 | **Conversion Diagnostic** | Does the traffic match the page? (MECLABS: Motivation 4x, Value 3x, Incentive 2x, Anxiety -2x) |
| 2 | **Belief Chain** | What must be true before purchase, and does the page install each belief in sequence? |
| 3 | **Curiosity Gap** | Does each section create enough pull to drag the reader into the next one? |
| 4 | **Unique Mechanism** | Can the reader explain WHY this product works differently? |

### P — Persuasion Architecture

| # | Model | The Question It Answers |
|---|---|---|
| 5 | **Persuasion Engine** | Can you name the persuasion function of every page section? |
| 6 | **Emotional Sequencing** | What emotion does the reader feel at each scroll-depth? |
| 7 | **Narrative Transport** | Is the format (story vs. argument vs. list) matched to traffic temperature? |
| 8 | **The One Reader** | Would one specific person feel this was written for them? |

### C — Proof & Credibility

| # | Model | The Question It Answers |
|---|---|---|
| 9 | **Specificity Trigger** | Can vague claims be replaced with numbers, names, or examples? |
| 10 | **Strategic Honesty** | Does the page make a calibrated admission that builds trust? |
| 11 | **Social Proof Architecture** | Is proof placed next to the claim it validates? |
| 12 | **Voice-of-Customer** | Does the copy use language customers actually use? |

### O — Offer & Commitment

| # | Model | The Question It Answers |
|---|---|---|
| 13 | **Value Stack** | Does perceived value obviously exceed the price? |
| 14 | **Objection Map** | Have the top 5 objections been addressed? |
| 15 | **Risk Reversal** | Has every purchase risk been eliminated or reversed? |
| 16 | **Micro-Commitment Ladder** | Is the first commitment small enough to feel effortless? |

### U — Urgency & Action

| # | Model | The Question It Answers |
|---|---|---|
| 17 | **Urgency-Scarcity Calibration** | Is there a credible reason to act today? |
| 18 | **Contrast Framing** | Does the reader's current reality feel unacceptable vs. life with product? |
| 19 | **Pattern Interrupt** | Is there at least one scroll-stopping moment? |
| 20 | **Intensification Loop** | Is there a system to bring non-converters back? |

## Two Workflows

### Workflow 1: Audit an Existing Page

"Why isn't this converting?" → Run the Conversion Diagnostic → Map the Belief Chain → Check the Emotional Arc → Score all 20 models → Prioritize fixes by MECLABS weight.

### Workflow 2: Architect a New Page

"Build me a landing page" → Define the One Reader → Determine traffic temperature → Choose page format (advertorial / listicle / quiz / hero LP) → Map Belief Chain → Design Emotional Arc → Select models per section → Build and validate.

## Page Format Decision Tree

```
Cold traffic + belief chain 4+ steps?
  → Advertorial

Warm traffic + 5+ objections?
  → Listicle Lander

Personal/complex product?
  → Quiz Funnel

Warm-to-hot + straightforward product?
  → Hero Landing Page

None of the above?
  → Default to Listicle Lander
```

## Key Benchmarks

- Median LP conversion: **6.6%** (Unbounce, 464M visitors)
- Quiz start-to-lead: **37.6%** ecommerce avg
- Message-match (ad → headline): **has never lost an A/B test**
- Mobile share of LP traffic: **82.9%** (desktop converts ~2x higher)
- Load time penalty: **-7% conversion per additional second**
- Only **~6% of DTC brands** send paid traffic to dedicated LPs

## Installation

```bash
git clone https://github.com/lisovet/claude-skills.git /tmp/claude-skills
cp -r /tmp/claude-skills/skills/conversion-architect ~/.claude/skills/
```

> **Important:** This skill has 6 reference files with the detailed model breakdowns. You need the whole folder — not just SKILL.md.

## Usage

```
"Audit this landing page and tell me why it's not converting"
"What page type should I build for cold Meta traffic?"
"Score my page against the 20-model checklist"
"Architect a listicle lander for my supplement brand"
```

## File Structure

```
conversion-architect/
  SKILL.md                                    # Core methodology + workflows
  references/
    01-awareness-and-intent.md                # Models 1-4 deep dive
    02-persuasion-architecture.md             # Models 5-8 deep dive
    03-proof-and-credibility.md               # Models 9-12 deep dive
    04-offer-and-commitment.md                # Models 13-16 deep dive
    05-urgency-and-action.md                  # Models 17-20 deep dive
    06-page-type-playbooks.md                 # Format decision tree + section architecture
```

## Works With

| Skill | Relationship |
|---|---|
| **copywriting-strategist** | Use Architect first to diagnose/plan, then Strategist to generate angles |
| **Brand skills** | Always pair with a brand skill for product context |

## License

MIT
