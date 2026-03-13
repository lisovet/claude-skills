<h1 align="center">
  <img src="https://img.shields.io/badge/-SwiftUI-007AFF?style=for-the-badge&logo=swift&logoColor=white" alt="SwiftUI" />
  <br/>
  ios-frontend-design
</h1>

<p align="center">
  <strong>An opinionated creative director for iOS apps.</strong><br/>
  Produces distinctive SwiftUI interfaces that honor Apple HIG while rejecting the generic "AI-generated app" look.
</p>

---

## Why This Exists

Most AI-generated iOS UIs look identical: white cards on gray backgrounds, system blue everything, SF Symbol salad, grouped lists for every screen. This skill fixes that by giving Claude a strong creative opinion and the design vocabulary to back it up.

## What It Does

When you ask Claude to build an iOS screen, view, or app — this skill activates and enforces a 4-step process:

1. **Understand** the brief (seconds, not minutes)
2. **Concept** — commit to a bold aesthetic direction with four concrete decisions: Palette, Type, Space, and Depth
3. **Implement** — write working SwiftUI code that executes the concept
4. **Verify** — run 8 named quality gates before delivering

## Key Features

### Anti-Slop Standard

12 named failure patterns that Claude must recognize and refuse:

| Pattern | Example |
|---|---|
| Settings.app clone | Every screen is a grouped `List` |
| SF Symbol salad | Dozens of symbols, all `.blue`, all same weight |
| System-blue-everything | `.blue` as sole accent color |
| White rectangles on gray | Identical rounded cards stacked vertically |
| Happy path only | No empty, loading, or error states |
| ...and 7 more | |

### Concept Reference Palette

10 proven aesthetic directions (Twilight Sanctuary, Paper Ledger, Neon Cockpit, Warm Earth, Nordic Frost, Dark Editorial, Candy Pop, Swiss Poster, Film Noir, Lab Instrument) — each with specific surface colors, accents, type choices, spatial feel, and signature interactions.

### 8 Quality Gates

Every design must pass before delivery:

1. **Identity Test** — Remove text. Is the app still recognizable?
2. **Squint Test** — Blur the screen. Is hierarchy clear?
3. **Thumb Test** — Can the primary task be completed one-handed?
4. **Inversion Test** — Does dark mode actually work?
5. **Zoom Test** — Does Dynamic Type at max size still work?
6. **Narration Test** — Does VoiceOver tell a coherent story?
7. **Clone Test** — Does any screen match an anti-slop pattern?
8. **States Test** — Empty, loading, error, AND populated?

### Also Includes

- **Specificity Rules** — the "Picture Test" that catches vague design descriptions
- **Color Palette Methodology** — 6-slot system (surface, text, accent, secondary, success/warning/error, material)
- **Output Structure** — `DesignSystem.swift` tokens, data models, views, previews
- **Visual Craft Techniques** — mesh gradients, scroll transitions, symbol effects, animated counters
- **Button & Interaction Design** — custom `ButtonStyle`, haptic feedback patterns
- **Collection Layout Alternatives** — grids, carousels, featured+compact hybrids
- **Form & Input Design** — styled text fields, 5 layout rules
- **Adaptive Layout System** — compact/regular size classes, content width capping
- **Anti-Convergence Table** — forces variety across 5 axes so consecutive designs don't look alike
- **Worked Examples** — full concept-to-code walkthroughs

## Installation

```bash
git clone https://github.com/lisovet/claude-skills.git /tmp/claude-skills
cp -r /tmp/claude-skills/skills/ios-frontend-design ~/.claude/skills/
```

Or grab just the SKILL.md (this skill has no reference files):

```bash
mkdir -p ~/.claude/skills/ios-frontend-design
curl -sL https://raw.githubusercontent.com/lisovet/claude-skills/main/skills/ios-frontend-design/SKILL.md \
  -o ~/.claude/skills/ios-frontend-design/SKILL.md
```

## Usage

Just ask Claude to build iOS UI. The skill activates automatically. Or invoke directly:

```
/ios-frontend-design
```

**Example prompts:**
- "Design a fitness tracking app home screen"
- "Build a recipe detail view with ingredients and steps"
- "Create a meditation timer with a calming aesthetic"

## File Structure

```
ios-frontend-design/
  SKILL.md          # ~1,100 lines of design methodology + SwiftUI patterns
```

No external dependencies. No reference files to load. Everything is self-contained.

## Requirements

- iOS 17+ (uses `#Preview`, `.sensoryFeedback`, `containerRelativeFrame`, `.scrollTransition`)
- SwiftUI knowledge helpful but not required

## License

MIT
