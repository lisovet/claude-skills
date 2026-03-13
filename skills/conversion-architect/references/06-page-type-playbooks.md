# Page Type Playbooks

Format-specific blueprints for the most common DTC page types. Each playbook includes the section order, which mental models are critical, and real brand examples. Read the relevant playbook AFTER choosing a format in Step 4 of the Architecting workflow.

---

## Playbook 1: The Advertorial

**Best for:** Cold traffic (Unaware/Problem-Aware), complex mechanisms requiring education, high-price or high-commitment products, new-to-market brands, categories with heavy skepticism.

**Performance benchmarks:** Hint Water achieved ~15% CTR from advertorial to landing page with 60–70% LP conversion (Nik Sharma). MUD\WTR runs 3-tier advertorial systems matched to Schwartz awareness levels.

**Critical models:** 1 (Conversion Diagnostic), 2 (Belief Chain), 3 (Curiosity Gap), 4 (Unique Mechanism), 7 (Narrative Transport)

**Supporting models:** 6 (Emotional Sequencing), 9 (Specificity), 10 (Strategic Honesty), 18 (Contrast Framing)

### Section Blueprint

```
1. EDITORIAL HEADLINE
   → Must pass the "would a magazine run this?" test
   → Curiosity gap (Model 3): reveal enough to intrigue, withhold enough to pull in
   → NO product mention. NO brand name. NO "ad" signals.
   → Example: "The Natural Compound Targeting the Same Pathway as Ozempic"

2. EDITORIAL LEAD (First 30% — NO product mention)
   → Narrative transport (Model 7): enter the story
   → Recognition + Agitation from emotional arc (Model 6)
   → Frame: discovery narrative, investigative narrative, or customer story
   → Install beliefs #1–2 from the belief chain (Model 2)

3. PROBLEM EXPANSION
   → Contrast framing (Model 18): make the current reality feel unacceptable
   → Villain positioning: name the category practice that's failing people
   → Install beliefs #2–3 (why existing approaches fail)
   → The unique problem mechanism (Model 4): WHY previous solutions don't work

4. THE MECHANISM / DISCOVERY (Middle 40%)
   → Unique solution mechanism (Model 4): reveal the new approach
   → Specificity (Model 9): concrete data, named compounds, study references
   → This is where the product is introduced — as part of the discovery, not a pitch
   → Install beliefs #3–5

5. PROOF STACKING
   → Social proof architecture (Model 11): testimonials matched to specific claims
   → Strategic honesty (Model 10): at least one damaging admission
   → Authority signals: expert quotes, clinical references, certifications

6. THE OFFER (Final 30%)
   → Value stack (Model 13): decompose the offer
   → Risk reversal (Model 15): guarantee prominent
   → Urgency if real (Model 17)
   → CTA that feels like a natural next step within the narrative

7. FAQ
   → Top 3–5 objections from the objection map (Model 14)
   → First FAQ open by default
```

### Voice Rules
- Write in third person or first person — never in brand voice
- Maintain the editorial frame throughout. No "BUY NOW!" urgency breaks
- Schwartz rule: don't mention the product in the first third
- CTAs woven through the second half, not just at the end

### Reference Brands
- **MUD\WTR:** Three advertorial tiers matching awareness levels — competitive exposé, mechanism education, differentiation
- **Adapt Naturals:** Scientific journal-style headlines, research charts, review sections
- **Spacegoods:** Dedicated advertorial page, continuously A/B tested

### Defer to `advertorial-writer` for Full Details
This playbook provides the architectural overview. For the full 10-masters methodology, multi-advertorial strategies, and advanced techniques, read the `advertorial-writer` skill and its reference files.

---

## Playbook 2: The Listicle Lander

**Best for:** Warm traffic (Solution-Aware/Problem-Aware), products with multiple distinct benefits, competitive positioning, "switching" narratives.

**Performance benchmarks:** Listicle-format pages create 34+ extra seconds of engagement (Frictionless Commerce). Aplós "3 Reasons" page is the gold standard for minimalist execution.

**Critical models:** 2 (Belief Chain), 9 (Specificity), 11 (Social Proof Architecture), 14 (Objection Map), 18 (Contrast Framing)

**Supporting models:** 6 (Emotional Sequencing), 10 (Strategic Honesty), 13 (Value Stack), 17 (Urgency)

### Section Blueprint

```
1. URGENCY BAR — Persistent top bar with specific, time-limited offer
2. HERO HEADLINE — "[Number] Reasons [Audience] Are [Switching Action] For [Product]"
3. AUTHOR BYLINE + CREDIBILITY BADGES
4. COMPARISON TABLE — 3 columns, 5–7 rows, your column highlighted
5. TLDR BRIDGE — One bold line bridging table to reasons
6. THE NUMBERED REASONS (8–10) — Each = one belief or one objection
7. CTA BLOCKS (3 placements) — After table, mid-page, end
8. SOCIAL PROOF / TRIBE BLOCK
9. FAQ (3–5 questions)
10. FOOTER TRUST
```

### Defer to `reasons-listicle-lander` for Full Details
This playbook provides the architectural overview. For detailed tone selection, reason archetypes, CTA psychology, image briefing, and gold-standard copy examples, read the full `reasons-listicle-lander` skill.

### Reference Brands
- **Aplós:** All navigation removed, educational surface, conversion-focused underneath
- **Jones Road Beauty:** Demographic-targeted listicle landers
- **Dr. Squatch:** Villain-positioning listicle with visual comparison sections

---

## Playbook 3: The Quiz Funnel

**Best for:** Personal/complex products, multiple SKUs, categories where "which one is right for me?" is a primary objection.

**Performance benchmarks:** 37.6% start-to-lead, 20% purchase rate (Jones Road), 2x LTV and 2.5x AOV (Bambu Earth), 80% quiz-to-purchase (Function of Beauty).

**Critical models:** 2 (Belief Chain), 6 (Emotional Sequencing), 8 (The One Reader), 16 (Micro-Commitment Ladder)

**Supporting models:** 9 (Specificity), 13 (Value Stack), 15 (Risk Reversal)

### Architecture Blueprint

```
PRE-QUIZ PAGE
  → Headline: "Find Your [Personalized Result] in [Time]"
  → Social proof: "[X] people have taken this quiz"
  → Single CTA: "Take the Quiz"
  → NO navigation, NO product browsing

THE QUIZ (3–5 questions)
  → Q1: Visual choice grid (lowest cognitive load)
  → Q2–3: Identity and situation questions
  → Optional mid-quiz value delivery
  → Progress bar throughout (mandatory)

EMAIL GATE (after value delivery)
  → "Where should we send your personalized results?"
  → Frame as service, not toll booth

RESULTS PAGE (the conversion page)
  → Personalized headline referencing their answers
  → 2–3 personalized insights
  → Product recommendation (3–4 options max)
  → Price shown here — after the journey
  → Matched testimonials + guarantee + CTA

POST-QUIZ EMAIL SEQUENCE (Model 20)
  → Immediate: Full results + recommendation
  → Day 2: Deeper insight on their concern
  → Day 5: Testimonial from similar quiz profile
  → Day 7: Offer with urgency
```

### Key Design Decisions
- Image-based answers > text-only
- Conditional logic for genuine personalization
- Email gate AFTER value, not before
- Results page IS the sales page — don't link to a separate PDP
- Limit recommendations to 3–4 products

### Reference Brands
- **Jones Road Beauty:** 20% quiz conversion rate, shade-matching + skin type
- **Bambu Earth:** 2x LTV for quiz purchasers, skin concern → trial kit → regimen
- **Prose:** Deep quiz with "why" pop-ups per question
- **Function of Beauty:** 80% quiz-to-purchase, hair profile → custom formula
- **Beardbrand:** Personality quiz, 150K leads, quiz as content

---

## Playbook 4: The Hero Landing Page

**Best for:** Retargeting traffic, single-product focus, warm audiences, Meta prospecting with Product-Aware targeting.

**Performance benchmarks:** Long-form hero pages generate 220% more leads (MarketingExperiments). Snow Teeth Whitening: +25% ROAS vs. homepage/PDP traffic.

**Critical models:** 1 (Conversion Diagnostic), 5 (Persuasion Engine), 9 (Specificity), 11 (Social Proof Architecture), 15 (Risk Reversal)

**Supporting models:** 13 (Value Stack), 14 (Objection Map), 17 (Urgency)

### Section Blueprint (Nik Sharma's Landing Page Cookbook)

```
1. HERO — Bold headline matching ad + subhead + product image + proof stat + CTA
2. BRAG BAR — Customer quotes, media logos, or hero stats
3. BENEFITS — 3–5 outcome-focused (not feature-focused)
4. HOW IT WORKS — 3-step mechanism explanation
5. COMPARISON — Us vs. old way / alternatives
6. TESTIMONIALS / UGC — 3–5 matched to specific benefits/objections
7. FAQ — Top 5 objections, first FAQ open by default
8. OFFER — Value stack + subscription option + bundle options
9. GUARANTEE — Named, specific, next to final CTA
10. STICKY CTA — Fixed button scrolling with user
```

### Long-Form vs. Short-Form Decision

**Long-form when:** Product requires trust-building, price is high, traffic is mixed awareness, mechanism is complex.

**Short-form when:** Traffic is retargeting/Most Aware, product is simple/low-cost, email traffic (19.3% conversion — already motivated).

**The answer:** Same section ORDER, different section DEPTH. Extend or compress based on traffic and complexity.

### Reference Brands
- **Snow Teeth Whitening:** Hero + advertorial hybrid, +25% ROAS
- **Caraway:** Repeated "$100 Off" + 4.9/5 rating throughout
- **HexClad:** "$300 Off + Free Shipping" with single focused CTA

---

## Playbook 5: The Homepage

**Best for:** Brand traffic, multi-product brands, visitors from PR/social/direct.

**Critical models:** 1 (Conversion Diagnostic), 4 (Unique Mechanism), 5 (Persuasion Engine), 8 (The One Reader), 18 (Contrast Framing)

### Key Differences from Landing Pages
- Navigation STAYS (unlike LPs where it's removed)
- Serves MULTIPLE visitor intents simultaneously
- Must communicate unique mechanism in one glance (5-second test)
- Routes visitors to the right next step (quiz, PDP, collection) — doesn't close the sale directly
- Social proof above the fold carries even more weight (visitors often have zero context)

---

## Playbook 6: The PDP (Product Detail Page)

**Best for:** Product-Aware visitors, comparison shoppers, email click-throughs, visitors pre-educated by advertorial or listicle.

**Critical models:** 9 (Specificity), 11 (Social Proof Architecture), 13 (Value Stack), 14 (Objection Map), 15 (Risk Reversal)

### PDP Optimization Priorities (in order)
1. Product images — multiple angles, lifestyle context, mobile-first
2. Star rating + review count — visible in first viewport
3. Headline with mechanism — not just the product name
4. Benefit bullets — 3–5, outcome-focused, customer language (Model 12)
5. Price + subscription option — clear, with savings calculation
6. CTA button — high contrast, offer-focused text
7. Guarantee badge — next to CTA, not in footer
8. Below-the-fold: Mechanism, comparison, testimonials, FAQ

### The PDP Belief Chain Assumption
The PDP assumes beliefs #1–3 are already installed. Cold traffic sent directly to a PDP = broken belief chain. Use an advertorial or listicle as the bridge page.

---

## Playbook 7: The Quiz Results Page

**Best for:** Visitors who completed a quiz funnel. Highest-intent page in the funnel.

**Critical models:** 2 (Belief Chain), 6 (Emotional Sequencing), 8 (The One Reader), 13 (Value Stack), 16 (Micro-Commitment Ladder)

### Section Blueprint

```
1. PERSONALIZED HEADLINE — References their quiz answers
2. PERSONALIZED INSIGHTS (2–3) — Connect their answers to product benefits
3. PRODUCT RECOMMENDATION — 1–3 products with explanation
4. MATCHED SOCIAL PROOF — Testimonials from similar quiz profiles
5. VALUE STACK + OFFER — Price with subscription savings
6. CTA — Personalized: "Get My [Product]" + guarantee below
7. FAQ (2–3) — Tailored to common objections for their profile
```

### The Emotional Transition
The page must feel like a continuation of the quiz experience — personalized, helpful, insightful — not an abrupt shift to a sales page. Maintain the advisory tone. Reference their answers. Make the recommendation feel like a service, not a pitch.
