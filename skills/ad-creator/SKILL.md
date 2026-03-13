---
name: generate
description: >
  Generate images using Google's Nano Banana (Gemini) image generators. Use when the user
  asks to generate, create, or make an image, photo, illustration, or visual using Nano Banana,
  Gemini, or AI image generation. Also triggers on "generate an image of", "create a picture of",
  "make me an image", or any request to produce visual content with Gemini/Nano Banana.
---

# Nano Banana Image Generator

Generate images using Google's Nano Banana (Gemini) image generation API by crafting
optimized prompts and running the bundled generation script.

## Prerequisites

The user needs:
- `google-genai` Python package (`pip install google-genai`)
- `GEMINI_API_KEY` environment variable set (get one at https://aistudio.google.com/apikey)

If either is missing, tell the user what to install/configure before proceeding.

## Workflow

### Step 1: Understand What the User Wants

Ask targeted questions to fill gaps in the user's description. Focus on the most important
missing dimensions first — don't ask everything at once. Ask 2-3 questions max per round.

| Dimension | What to ask |
|-----------|------------|
| **Subject** | Who or what is the main focus? |
| **Setting** | Where does this take place? |
| **Mood** | What feeling should it evoke? |
| **Style** | Photorealistic, watercolor, cinematic, editorial, anime? |
| **Composition** | Close-up, wide shot, bird's eye? |
| **Lighting** | Golden hour, dramatic side-light, soft diffused, neon? |
| **Purpose** | Social media, website hero, print, presentation? |
| **Text** | Any text to render in the image? |

If the user gives a clear, detailed description, skip the questions and go straight to prompt building.

### Step 2: Craft the Prompt

Write a natural-language prompt as if briefing a human artist. Key principles:

- **Natural language, not keyword lists.** "A golden retriever bounding through a sun-dappled park at golden hour" NOT "dog, park, sunset, 4k, realistic"
- **Be specific about materials and textures.** "weathered leather," "brushed steel," "soft velvet"
- **Use camera language.** "shallow depth of field," "wide establishing shot," "Dutch angle"
- **Specify lighting.** "Rembrandt lighting," "backlit with rim light," "soft window light from the left"
- **Include purpose context.** "for a premium coffee brand's Instagram feed" helps the model infer style

### Step 3: Generate the Image

Run the generation script. The script path is relative to this skill's plugin directory:

```bash
python3 ~/.claude/skills/ad-creator/scripts/generate.py \
  --prompt "THE CRAFTED PROMPT" \
  --output "./generated-image.png"
```

Available flags:
- `--prompt` / `-p`: The image prompt (required)
- `--output` / `-o`: Output file path (default: output.png)
- `--model` / `-m`: Gemini model (default: gemini-2.5-flash-image)
- `--ref` / `-r`: Reference image path (can repeat up to 14 times)

### Step 4: Present Results

After generation, tell the user:
1. Where the image was saved
2. The prompt that was used
3. Offer to refine: "Would you like to adjust anything? I can tweak the style, lighting, composition, or any other element and regenerate."

### Iteration

If the user wants changes, modify the prompt based on their feedback and regenerate.
Prefer targeted edits over starting from scratch.

## Ad Templates

For DTC product advertising, read `~/.claude/skills/ad-creator/references/ad-templates.md`. It contains
40 proven ad templates covering social proof, comparison, UGC, editorial, and more — each with
detailed prompt structures and placeholders. When the user wants to generate ad creatives:

1. Ask about their goal (social proof, comparison, offer, UGC, etc.)
2. Suggest the most appropriate template(s) from the library
3. Fill in all bracketed placeholders with their brand/product details
4. Generate the image using the completed prompt

## Anti-Patterns to Avoid

- **Keyword lists** — rewrite as natural sentences
- **Vague subjects** — "a person" needs specific details
- **Missing mood/lighting** — always include these
- **Over-prompting** — contradictory details confuse the model

## Example Prompts

**Product photography:**
> A flat lay of artisanal coffee beans spilling from a matte black ceramic cup onto a weathered oak table, soft directional window light from the upper left, warm earth tones with deep shadows, shot from directly above, styled for a premium coffee brand's Instagram feed.

**Portrait:**
> A cinematic medium close-up portrait of a jazz musician mid-performance, eyes closed, sweat glistening under warm amber stage lighting, shallow depth of field with bokeh from string lights in the background, shot on what looks like 35mm film with natural grain.

**Fantasy illustration:**
> A lush watercolor illustration of a hidden forest library, towering bookshelves made from living trees with glowing mushrooms as reading lamps, a cozy armchair draped in moss-green velvet, shafts of golden sunlight filtering through the canopy above, whimsical and enchanting atmosphere.
