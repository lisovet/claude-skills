<h1 align="center">
  <img src="https://img.shields.io/badge/-Gemini-4285F4?style=for-the-badge&logo=google&logoColor=white" alt="Gemini" />
  <br/>
  ad-creator
</h1>

<p align="center">
  <strong>Generate ad images using Google's Nano Banana (Gemini) API.</strong><br/>
  Comes with a Python generation script, 40 DTC ad templates, and an interactive prompt-crafting workflow.
</p>

---

## Why This Exists

Generating good ad creatives with AI image models requires more than a vague description. You need specific prompt structures optimized for each ad format — social proof layouts, comparison shots, UGC-style testimonials, editorial cards. This skill bundles 40 proven templates so Claude can generate on-brand ad images without guesswork.

## What It Does

When you ask Claude to generate an image or create ad creatives, this skill:

1. **Understands your vision** — asks targeted questions about subject, mood, style, lighting, purpose
2. **Crafts an optimized prompt** — natural language, not keyword soup
3. **Generates the image** — runs the bundled Python script against the Gemini API
4. **Iterates** — refines based on your feedback

For ad creatives specifically, it pulls from a library of 40 templates and fills in your brand details.

## The 40 Ad Templates

Organized by conversion mechanism:

| Category | Templates | Examples |
|---|---|---|
| **Core Offer** | Headline, Offer/Promotion | Text rendering, promotional split |
| **Social Proof** | Testimonial, Social Proof, Pull-Quote, Verified Review, Comment Screenshot | Trust stacks, review cards, faux social |
| **Comparison** | Us vs Them, Before & After, Comparison Grid, Color Split | Side-by-side, transformation, meme-style |
| **Educational** | Features Point-Out, Bullet-Points, Feature Arrow Callout, Benefit Checklist | Diagram-style, split composition, annotated |
| **Editorial** | Press/Editorial, Advertorial Card, Faux Press Screenshot | Authority play, native content |
| **UGC-Style** | UGC Story, UGC Text Bubble, UGC + Review Split | Instagram-native, organic feel |
| **Lifestyle** | Lifestyle Action, Stat Surround, Flavor Story | Product in context, data radial |
| **Bold/Creative** | Bold Statement, Long-Form Manifesto, Curiosity Gap | Brand energy, copy-dominant, scroll-stopper |
| **Offer Variants** | Bundle Showcase, Hero + Stat Bar, Hero + Promo Burst | System sell, promotional |
| **Native/Organic** | iPhone Notes Screenshot, Post-It Note, Whiteboard | Platform-native, ugly ad aesthetic |

Each template includes a complete prompt structure with `[BRACKETED PLACEHOLDERS]` for your brand details.

## Prerequisites

```bash
pip install google-genai
export GEMINI_API_KEY="your-key-here"  # Get one at https://aistudio.google.com/apikey
```

## Installation

```bash
git clone https://github.com/lisovet/claude-skills.git /tmp/claude-skills
cp -r /tmp/claude-skills/skills/ad-creator ~/.claude/skills/
```

> **Important:** This skill has reference files and a script. You need the whole folder — a single `curl` of SKILL.md won't include the templates or generation script.

## Usage

```
"Generate a social proof ad for my protein bar brand"
"Create a before/after UGC-style image for my skincare product"
"Make me a testimonial ad with a kitchen setting"
```

Or invoke directly: `/ad-creator`

## File Structure

```
ad-creator/
  SKILL.md                          # Workflow + prompt-crafting methodology
  scripts/
    generate.py                     # Python script — calls Gemini API
  references/
    ad-templates.md                 # 40 ad templates with placeholders
```

## Generation Script Flags

```bash
python3 ~/.claude/skills/ad-creator/scripts/generate.py \
  --prompt "Your prompt here" \
  --output "./my-ad.png" \
  --model "gemini-2.5-flash-image" \
  --ref product-photo.jpg \
  --ref brand-guide.png
```

| Flag | Description | Default |
|---|---|---|
| `--prompt` / `-p` | Image prompt (required) | — |
| `--output` / `-o` | Output file path | `output.png` |
| `--model` / `-m` | Gemini model | `gemini-2.5-flash-image` |
| `--ref` / `-r` | Reference image (repeatable, up to 14) | — |

## License

MIT
