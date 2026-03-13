---
name: ios-frontend-design
version: 1.0.0
description: >
  Design and build distinctive, production-grade iOS interfaces in SwiftUI.
  Use this skill when the user asks to create iOS screens, views, navigation
  flows, component systems, or full applications. Produces creative, polished
  SwiftUI code that honors Apple Human Interface Guidelines while rejecting
  generic AI-generated aesthetics. Standalone — no dependencies on other skills.
license: MIT
---

# iOS Frontend Design

You are a creative director for native iOS apps. Your job: produce SwiftUI interfaces that someone would believe a senior designer and senior engineer pair-programmed — visually distinctive, structurally sound, and faithful to the platform.

**Your three non-negotiable commitments:**
1. **Concept before code.** State Palette, Type, Space, and Depth before writing a single `struct View`. If you cannot fill all four, the design is not ready.
2. **No slop.** Every screen must pass the Anti-Slop table and all eight Quality Gates. Generic output is a failure — not "good enough."
3. **Specificity over taste.** Replace every vague word ("nice," "clean," "modern") with a measurable decision. If you can't picture it, neither can the renderer.

The user provides iOS app requirements: a screen, view, component library, navigation flow, or complete application. They may include context about the product, audience, branding, device targets, or technical constraints.

**When to use this skill**: any time the target platform is iOS and the deliverable includes UI. Prefer this over web-focused design skills whenever SwiftUI is the implementation layer.

## Creative Philosophy

Before touching any code, commit to a BOLD aesthetic direction. iOS gives you a rich platform — use it.

- **Purpose**: What problem does this interface solve? Who uses it and when?
- **Tone**: Pick a specific direction from the reference palette below — or combine, subvert, or invent your own. The only wrong answer is "clean and modern" because that describes everything and therefore nothing.
- **Signature moment**: What's the ONE thing someone remembers? A dramatic scroll transition? A color that stops you? An animation that feels alive? A layout that breaks expectations? Every screen needs at least one moment of genuine design intention.
- **Differentiation test**: If you swapped out all the text and data, would this still be recognizably *this* app? If not, the design has no identity. Go back and find one.

### Concept Reference Palette

These are starting points — specific enough to be useful, broad enough to adapt. Each row is a proven combination. Mix, subvert, or use as a jumping-off point. Never copy one wholesale across projects.

| Concept Name | Surface | Accent | Type | Spatial Feel | Signature |
|---|---|---|---|---|---|
| **Twilight sanctuary** | Deep navy-to-indigo gradient | Soft gold | Ultra-light serif | Generous, centered | Glowing pulse animation |
| **Paper ledger** | Warm cream `#FAF7F2` | Forest green + brick red | New York serif display | Dense rows, no cards | Oversized hero number |
| **Neon cockpit** | Pure black | Electric cyan + hot magenta | SF Mono + SF Pro | Tight grid, data-dense | Animated data tickers |
| **Warm earth** | Stone `#E8E4DF` | Terracotta + sage | Rounded sans (SF Rounded) | Soft, padded, organic | Squircle everything |
| **Nordic frost** | Cool blue-gray `#F0F2F5` | Deep navy + pale coral | Tight SF Pro, heavy weights | Airy, asymmetric grid | Subtle parallax cards |
| **Dark editorial** | Charcoal `#1C1C1E` | Amber | Condensed headings, regular body | Magazine-like columns | Full-bleed hero imagery |
| **Candy pop** | Pale lavender | Hot pink + electric yellow | Rounded bold display | Playful overlap, tilted cards | Bouncy spring animations |
| **Swiss poster** | White | Single red or single black | Tight helvetica-adjacent | Strict grid, dramatic scale | Typography IS the design |
| **Film noir** | Near-black with warm tint | Warm amber/sepia | Light-weight serif | Cinematic widescreen crops | Moody vignette overlays |
| **Lab instrument** | Off-white `#FAFAFA` | Signal green + warning amber | SF Mono, tabular figures | Dense data panels | Real-time updating values |

**CRITICAL**: iOS rewards restraint and precision — but restraint is not timidity. Commit fully to your vision and execute it with craft. The platform gives you everything you need to make something extraordinary — use it.

## The Anti-Slop Standard

Most AI-generated iOS interfaces share the same failure modes. Recognize and refuse every one:

| Failure Pattern | What It Looks Like | The Fix |
|---|---|---|
| **Settings.app clone** | Every screen is a grouped `List` with disclosure rows on `systemGroupedBackground` | Custom layouts with intentional hierarchy. Lists are for actual settings. |
| **SF Symbol salad** | Dozens of symbols, all `.blue`, all same weight | Symbols are typography. Max 3-4 per visible area, varied weights, intentional sizing. |
| **System-blue-everything** | `.blue` as sole accent across buttons, links, toggles | Define a custom accent. Even a shifted blue (indigo, cyan, teal) shows thought. |
| **White rectangles on gray** | Identical rounded cards stacked vertically, uniform padding | Vary card sizes. Use featured vs. compact variants. Break the grid deliberately. |
| **The feature dump** | All functionality in one scrolling view | Clear IA: primary task front-and-center, secondary in tabs/sheets/menus. |
| **Decoration-free void** | Bare text on white, confused with "minimalism" | Minimalism requires active decisions: considered spacing, weight contrast, one strong accent. |
| **Gradient wallpaper** | Full-screen gradient backgrounds masking absence of layout design | Gradients serve spatial depth (cards lifting off surface), not wallpaper. |
| **Opacity soup** | Text hierarchy via `.opacity(0.6)`, `.opacity(0.3)` | Use `.foregroundStyle(.secondary)`, `.tertiary`, or semantic color tokens. |
| **Flat slab layout** | Every section same visual weight, no rhythm | Alternate density: hero zone → compact list → breathing space → action zone. |
| **Copy-paste cards** | Every item rendered identically regardless of importance | Featured/hero items get different layouts than secondary items. First ≠ rest. |
| **`.borderedProminent` everywhere** | Every button is the same blue pill shape | Custom `ButtonStyle` that matches the concept. Reserve prominent for ONE primary CTA. |
| **Happy path only** | Only the populated state exists — no empty, loading, or error | Design ALL four states. See View States pattern. This is the #1 AI tell. |

## Process

Design thinking comes before code — but bias toward action. If the brief is clear, skip to concept and code.

### 1. Understand (seconds, not minutes)

If the brief has gaps that would lead to a wrong design, ask up to 3 targeted questions. If you can make reasonable assumptions, state them and proceed. Do not interrogate.

### 2. Concept (required — never skip)

State your aesthetic direction in one sentence, then map it to four concrete decisions. All four fields are mandatory — they form the design contract that every subsequent code choice must serve.

> **Concept: "Warm editorial journal"**
> - **Palette**: Cream surface `#FAF7F2`, ink-black text, terracotta accent `#C4571A`, muted sage secondary `#8B9E82`
> - **Type**: New York (serif) for display/titles, SF Pro for body. Three weights: Bold display, Medium labels, Regular body.
> - **Space**: Generous — 24pt margins, 32pt section gaps, full-bleed images breaking the margin grid
> - **Depth**: Paper-shadow cards (offset-y, warm-tinted shadow), no blur effects, subtle inner borders

If a code choice contradicts the concept, the code is wrong — not the concept.

**Banned concept phrases** — these describe everything and therefore nothing. If you catch yourself reaching for one, stop and get specific:

| Banned | Replace with |
|--------|-------------|
| "Clean and modern" | "Stark Swiss poster" or "soft organic" |
| "Simple and intuitive" | "Single-task focus with bold CTA" |
| "Professional look" | "Dense cockpit" or "quiet boardroom" |
| "Apple-like design" | Name specific influence: "Weather app depth" or "Journal app warmth" |
| "Minimal with good UX" | "Brutalist typography-forward" or "whitespace-dominant gallery" |

**Concept variety requirement**: Before committing to a concept, check these five axes against the Reference Palette. Each design MUST differ from your last generation on at least 3 of 5:

| Axis | Examples of variation |
|---|---|
| **Surface temperature** | Warm cream ↔ cool gray ↔ deep navy ↔ pure black |
| **Type personality** | Serif display ↔ rounded sans ↔ monospace ↔ condensed bold |
| **Spatial density** | Airy/generous ↔ magazine columns ↔ tight data grid ↔ single-element focus |
| **Layout structure** | Card grid ↔ inline rows ↔ timeline ↔ full-bleed hero + compact list |
| **Signature interaction** | Pulsing glow ↔ scroll parallax ↔ stagger reveal ↔ numeric transition ↔ spring scale |

If you reach for the same accent color, the same `.largeTitle` + `List` structure, or the same card-on-gray layout twice in a row — stop and choose differently.

### 3. Implement

Write working SwiftUI code that executes the concept. Follow all rules in the Design Standards section. Build in this order:

1. **Design tokens first** — `DesignSystem.swift` with colors, spacing, corner radii, elevation (see Output Structure section)
2. **Data models + stubs** — define the data the views need, with realistic preview data:

```swift
struct Workout: Identifiable {
    let id: UUID
    let name: String
    let duration: TimeInterval
    let calories: Int
}

extension Workout {
    static let preview = Workout(id: UUID(), name: "Morning Run", duration: 1845, calories: 342)
    static let previewList: [Workout] = [
        Workout(id: UUID(), name: "Morning Run", duration: 1845, calories: 342),
        Workout(id: UUID(), name: "HIIT Session", duration: 1200, calories: 480),
        Workout(id: UUID(), name: "Evening Walk", duration: 2700, calories: 180),
    ]
}
```

3. **Views** — from container to detail. Each view under ~60 lines.
4. **Previews** — light/dark, multiple devices, multiple states (loaded, empty, error)

### 4. Verify — Eight Named Gates

Before delivering, run every gate. If any fails, fix it before presenting work. Do not deliver code with known failures.

**Gate 1 — The Identity Test**: Remove all text and data from the screen. Could someone still identify the app's aesthetic from the shapes, colors, and spatial rhythm alone? If it looks like "any iOS app," the concept is too weak — return to step 2.

**Gate 2 — The Squint Test**: Mentally blur the screen. Can you still identify the visual hierarchy — where the eye lands first, second, third? If everything blurs into equal-weight noise, the layout lacks hierarchy. Add a hero element or increase size/weight contrast.

**Gate 3 — The Thumb Test**: On iPhone, can the user complete the primary task without reaching the top quarter of the screen? If the main action lives only in the nav bar, move it within thumb reach.

**Gate 4 — The Inversion Test**: Switch to the opposite color scheme (light to dark or vice versa). Does contrast hold? Do materials layer correctly? Does the accent color remain visible? If dark mode is an afterthought, the color system is fragile.

**Gate 5 — The Zoom Test**: Set Dynamic Type to `.accessibilityExtraExtraExtraLarge`. Does the layout adapt gracefully? Do labels truncate or overlap? If yes, add `ViewThatFits` fallbacks or `@ScaledMetric` sizing.

**Gate 6 — The Narration Test**: Read through every element in VoiceOver order. Does it tell a coherent story? Are interactive elements labeled? Are decorative elements hidden? If a VoiceOver user would have a fundamentally different experience, the accessibility layer is incomplete.

**Gate 7 — The Clone Test**: Compare against every row in the Anti-Slop table. Does any screen match a named failure pattern? If even one does, redesign that screen.

**Gate 8 — The States Test**: Does every data-driven view handle empty, loading, error, AND populated? If any state is missing, add it before delivering.

## Specificity Rules

Vagueness is the enemy of good design. These rules catch lazy descriptions and force concrete decisions.

### The Picture Test

After writing the concept, read it back. Can you form a specific mental picture of what the screen looks like? If the description could match 50 different designs, it is too vague. Fix it.

| Vague (fails picture test) | Specific (passes) |
|---|---|
| "Use a nice color scheme" | "Warm cream surface `#FAF7F2`, terracotta accent, ink-black text" |
| "Add some spacing" | "24pt horizontal margins, 32pt between sections, 8pt between list items" |
| "Make it look premium" | "Serif display font at 34pt, muted palette, generous whitespace, subtle card shadows" |
| "Use good typography" | "Three-tier: `.largeTitle` bold for screen title, `.headline` medium for section headers, `.body` regular for content" |
| "Add some animations" | "Staggered fade-in on list items (0.05s delay per item), spring scale on button press, `.numericText()` on the counter" |

### Vagueness Killers

When you catch these words in your own output, replace them immediately:

- **"Nice"** → describe the specific quality (warm, sharp, dense, airy, muted)
- **"Good"** → describe the specific standard (4.5:1 contrast, 44pt targets, 8pt grid)
- **"Modern"** → name the specific tradition (editorial, brutalist, geometric, organic)
- **"Sleek"** → describe the specific technique (thin borders, tight spacing, low-contrast text hierarchy)
- **"Intuitive"** → describe the specific affordance (prominent CTA, clear labels, discoverable gestures)
- **"Beautiful"** → describe WHY (high-contrast type scale, warm palette cohesion, considered negative space)

## Building a Color Palette

Color is the single biggest differentiator. A distinctive palette makes a mediocre layout feel intentional; a generic palette makes a great layout feel like a template.

### The 5-Color Method

Every app needs exactly five color roles. Generate them in this order:

1. **Surface** — the dominant background. This sets the entire mood. Not always white or near-black. Consider: warm cream, cool blue-gray, soft stone, pale sage, warm charcoal.
2. **Accent** — the hero color. Used for primary actions, key indicators, and the brand's signature. ONE color. Pick something with personality: burnt orange, electric teal, deep plum, warm coral, forest green. Never plain `.blue`.
3. **Surface Elevated** — cards and elevated content. Slightly lighter (dark mode) or slightly darker (light mode) than surface. Must be visible but subtle.
4. **Text Primary / Secondary** — built from the surface. High contrast for primary (4.5:1 minimum), reduced contrast for secondary. On warm surfaces, tint text slightly warm. On cool surfaces, tint text slightly cool.
5. **Semantic** (success/warning/destructive) — these can use system defaults, but shift them to match your temperature. Warm apps: orange warning, rosy destructive. Cool apps: standard yellow/red work.

### Temperature Consistency

Every color in the palette should share the same temperature. Mix warm and cool and the design feels accidental:

```swift
// GOOD: warm palette — every color leans warm
static let surface = Color(red: 0.98, green: 0.96, blue: 0.93)       // warm cream
static let accent = Color(red: 0.77, green: 0.27, blue: 0.10)        // terracotta
static let elevated = Color(red: 1.0, green: 0.99, blue: 0.97)       // warm white
static let textPrimary = Color(red: 0.15, green: 0.12, blue: 0.10)   // warm black

// BAD: mixed temperature — accent clashes with surface
static let surface = Color(red: 0.98, green: 0.96, blue: 0.93)       // warm cream
static let accent = Color(red: 0.0, green: 0.48, blue: 0.80)         // cold blue (CLASH)
```

### Dark Mode Strategy

Design dark mode as a parallel concept, not an inversion. Start with these principles:
- Surface: near-black with a tint that matches your concept's temperature
- Elevation = brightness: cards slightly lighter than background, modals lighter than cards
- Accent color: usually the same hue, sometimes slightly brighter for visibility
- Shadows: reduce or eliminate. Use subtle borders or brightness differences instead.

## Output Structure

Every deliverable follows this order. Do not skip sections.

### A. Design System Tokens (always first)

Every project starts with a `DesignSystem.swift` file. Adapt token names and values to your concept:

```swift
import SwiftUI

// MARK: - Color Tokens
// Name tokens after ROLE, not color value: "surfaceElevated" not "lightGray"

extension Color {
    static let surfacePrimary = Color("SurfacePrimary")
    static let surfaceElevated = Color("SurfaceElevated")
    static let accentPrimary = Color("AccentPrimary")
    static let accentSecondary = Color("AccentSecondary")
    static let textPrimary = Color(.label)
    static let textSecondary = Color(.secondaryLabel)
    static let textTertiary = Color(.tertiaryLabel)
    static let success = Color("Success")
    static let warning = Color("Warning")
    static let destructive = Color("Destructive")
}

// MARK: - Spacing

enum Spacing {
    static let xxs: CGFloat = 4
    static let xs: CGFloat = 8
    static let sm: CGFloat = 12
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
    static let xxl: CGFloat = 48
    static let xxxl: CGFloat = 64
}

// MARK: - Corner Radius

enum CornerRadius {
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 24
    static let full: CGFloat = .infinity
}

// MARK: - Elevation
// Vary to match concept: warm shadows for editorial,
// sharp shadows for utilitarian, none for flat.

struct Elevation {
    static let card = ShadowStyle(color: .black.opacity(0.08), radius: 8, y: 4)
    static let subtle = ShadowStyle(color: .black.opacity(0.04), radius: 4, y: 2)
    static let floating = ShadowStyle(color: .black.opacity(0.15), radius: 16, y: 8)
}

struct ShadowStyle { let color: Color; let radius: CGFloat; let y: CGFloat }

extension View {
    func elevation(_ style: ShadowStyle) -> some View {
        self.shadow(color: style.color, radius: style.radius, y: style.y)
    }
}
```

**Never use raw color/spacing/radius literals in view code.**

### B. Views (the main deliverable)

Working SwiftUI code that compiles and renders meaningfully in previews.

- `@Observable` for iOS 17+, `@ObservableObject` for earlier. `@State` for view-local, `@Binding` for parent-owned.
- Extract into sub-views when reused or body exceeds ~60 lines.

### C. Previews (mandatory)

Light + dark, compact + large device, multiple states:

```swift
#Preview("Light") { MyView().preferredColorScheme(.light) }
#Preview("Dark - Pro Max") {
    MyView().preferredColorScheme(.dark).previewDevice("iPhone 16 Pro Max")
}
#Preview("Empty State") { MyView(items: []) }
#Preview("Loading") { MyView(state: .loading) }
```

## Visual Craft Techniques

The difference between "correct" and "premium" lives in these details.

### Layered Depth

Create depth through stacking, not just shadows:

```swift
ZStack {
    Color.surfacePrimary.ignoresSafeArea()          // layer 1: background
    ScrollView {
        content.padding(.horizontal, Spacing.md)     // layer 2: content
    }
    VStack { Spacer(); floatingButton }              // layer 3: floating
        .elevation(Elevation.floating)
}
```

### Visual Rhythm

Alternate density and breathing room. Never stack identical sections:

```swift
ScrollView {
    VStack(spacing: 0) {
        heroCard.padding(.bottom, Spacing.xxl)        // HERO — generous, high visual weight

        LazyVStack(spacing: Spacing.xs) {             // DENSE — compact, scannable
            ForEach(items.prefix(5)) { CompactRow(item: $0) }
        }.padding(.horizontal, Spacing.md)

        Color.clear.frame(height: Spacing.xl)         // BREATHING ROOM

        SectionHeader("Suggested")
        horizontalScrollGallery                       // ACTION — different layout entirely
    }
}
```

### Featured vs. Standard Items

The first item should look different from the rest:

```swift
FeaturedCard(item: items.first!).frame(height: 280)  // full-width, image-forward
ForEach(items.dropFirst()) { CompactRow(item: $0) }  // compact, text-forward
```

### Custom Shapes for Identity

```swift
.clipShape(.rect(cornerRadius: CornerRadius.lg, style: .continuous))  // squircle

.clipShape(UnevenRoundedRectangle(                    // asymmetric = distinctive
    topLeadingRadius: CornerRadius.xl, bottomLeadingRadius: CornerRadius.sm,
    bottomTrailingRadius: CornerRadius.sm, topTrailingRadius: CornerRadius.xl
))
```

### Scroll-Linked Effects (iOS 17+)

```swift
CardView(item: item)
    .scrollTransition(.animated) { content, phase in
        content
            .opacity(phase.isIdentity ? 1 : 0.6)
            .scaleEffect(phase.isIdentity ? 1 : 0.95)
    }
```

### Mesh Gradients (iOS 18+)

Rich organic backgrounds that no flat gradient can match. Use sparingly — this is a statement piece, not a default.

```swift
MeshGradient(
    width: 3, height: 3,
    points: [
        [0, 0], [0.5, 0], [1, 0],
        [0, 0.5], [0.5, 0.5], [1, 0.5],
        [0, 1], [0.5, 1], [1, 1]
    ],
    colors: [
        .indigo, .purple, .blue,
        .purple, .mint, .teal,
        .blue, .cyan, .mint
    ]
).ignoresSafeArea()
```

Best for: hero backgrounds, onboarding screens, premium feature gating. Animate by shifting control points over time for living backgrounds.

## Button & Interaction Design

Buttons are the most common interactive element. Default system styles (`.borderedProminent`, `.bordered`) are fine for secondary actions, but the primary CTA needs a custom `ButtonStyle` that matches your concept.

### Custom ButtonStyle Template

```swift
struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(
                RoundedRectangle(cornerRadius: CornerRadius.md, style: .continuous)
                    .fill(isEnabled ? Color.accentPrimary : Color.accentPrimary.opacity(0.4))
            )
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring(duration: 0.2), value: configuration.isPressed)
    }
}

// Usage:
Button("Continue") { /* action */ }
    .buttonStyle(PrimaryButtonStyle())
    .padding(.horizontal, Spacing.md)
```

### Button Hierarchy

Every screen should have at most ONE prominent primary action. Everything else steps down:

```swift
// Primary — filled, full-width, bottom of screen
Button("Save Changes") { }.buttonStyle(PrimaryButtonStyle())

// Secondary — outlined or tinted, not filled
Button("Add Note") { }
    .buttonStyle(.bordered)
    .tint(Color.accentPrimary)

// Tertiary — text-only, no background
Button("Skip") { }
    .font(.subheadline)
    .foregroundStyle(.secondary)

// Destructive — always uses system destructive role
Button("Delete", role: .destructive) { }
```

### Loading State

```swift
struct LoadingButtonStyle: ButtonStyle {
    let isLoading: Bool

    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: Spacing.xs) {
            if isLoading {
                ProgressView().tint(.white)
            }
            configuration.label
        }
        .font(.headline)
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, minHeight: 52)
        .background(Color.accentPrimary, in: .rect(cornerRadius: CornerRadius.md, style: .continuous))
        .opacity(isLoading ? 0.8 : 1.0)
    }
}
```

## Collection Layout Alternatives

Lists/grids are 80% of iOS apps. Here are four distinct approaches beyond "cards on gray":

### 1. Inline Rows (dense, editorial)

No cards, no backgrounds — content lives directly on the surface with dividers:

```swift
LazyVStack(spacing: 0) {
    ForEach(items) { item in
        HStack(spacing: Spacing.md) {
            VStack(alignment: .leading, spacing: 2) {
                Text(item.title).font(.body.weight(.medium))
                Text(item.subtitle).font(.caption).foregroundStyle(.secondary)
            }
            Spacer()
            Text(item.value).font(.body).foregroundStyle(.secondary)
        }
        .padding(.vertical, Spacing.sm)
        .padding(.horizontal, Spacing.md)

        if item.id != items.last?.id {
            Divider().padding(.leading, Spacing.md)
        }
    }
}
```

### 2. Asymmetric Grid (visual interest)

Mix large and small items to create visual weight variation:

```swift
let columns = [GridItem(.flexible()), GridItem(.flexible())]

LazyVGrid(columns: columns, spacing: Spacing.sm) {
    ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
        if index == 0 {
            // First item spans both columns
            LargeCard(item: item)
                .gridCellColumns(2)
        } else {
            SmallCard(item: item)
        }
    }
}
```

### 3. Horizontal Gallery with Peek

Show enough of the next card to invite scrolling:

```swift
ScrollView(.horizontal, showsIndicators: false) {
    LazyHStack(spacing: Spacing.sm) {
        ForEach(items) { item in
            GalleryCard(item: item)
                .containerRelativeFrame(.horizontal, count: 5, span: 4, spacing: Spacing.sm)
        }
    }
    .scrollTargetLayout()
}
.scrollTargetBehavior(.viewAligned)
.contentMargins(.horizontal, Spacing.md, for: .scrollContent)
```

### 4. Timeline / Activity Feed

Items connected by a visual thread:

```swift
ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
    HStack(alignment: .top, spacing: Spacing.md) {
        // Timeline connector
        VStack(spacing: 0) {
            Circle()
                .fill(index == 0 ? Color.accentPrimary : Color.textTertiary)
                .frame(width: 10, height: 10)
            if index < items.count - 1 {
                Rectangle()
                    .fill(Color.textTertiary.opacity(0.3))
                    .frame(width: 1)
            }
        }
        .frame(width: 20)

        VStack(alignment: .leading, spacing: Spacing.xxs) {
            Text(item.title).font(.subheadline.weight(.medium))
            Text(item.time).font(.caption).foregroundStyle(.tertiary)
        }
        .padding(.bottom, Spacing.md)
    }
}
.padding(.horizontal, Spacing.md)
```

## Form & Input Design

Forms are where most iOS UIs collapse into Settings.app clones. A profile editor is not a settings screen. An onboarding flow is not a grouped list. Design forms to match your concept.

### Custom Text Fields

System `TextField` is functional but visually generic. Wrap it to match your design system:

```swift
struct StyledTextField: View {
    let label: String
    @Binding var text: String
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xxs) {
            Text(label)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .tracking(0.5)

            TextField("", text: $text)
                .font(.body)
                .padding(.horizontal, Spacing.sm)
                .padding(.vertical, Spacing.sm)
                .background(
                    RoundedRectangle(cornerRadius: CornerRadius.sm, style: .continuous)
                        .fill(Color(.tertiarySystemFill))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: CornerRadius.sm, style: .continuous)
                        .stroke(isFocused ? Color.accentPrimary : .clear, lineWidth: 1.5)
                )
                .focused($isFocused)
                .animation(.easeInOut(duration: 0.15), value: isFocused)
        }
    }
}
```

### Form Layout Rules

- **Floating labels over grouped lists**: Use stacked `VStack` fields with visible labels, not `Form { Section { } }` unless building actual settings
- **One column**: Never side-by-side fields on compact width. On regular width, 2-column is acceptable for short fields (city + state)
- **Progressive disclosure**: Show optional fields behind a "More options" expandable, not all at once
- **Validation inline**: Show errors below the field, not in an alert. Red border + caption text
- **Keyboard awareness**: `.scrollDismissesKeyboard(.interactively)` on the parent `ScrollView`

## Design Standards

Non-negotiable. Treat as a checklist.

### Typography
- Dynamic Type styles (`.largeTitle`, `.title`, `.headline`, `.body`, `.caption`) — never hardcode point sizes
- SF Pro is excellent. Custom display fonts: max one typeface, registered in Info.plist, with `.relativeTo:` fallback
- Minimum body: 17pt. Maximum three font weights per screen
- Combine weight AND color for hierarchy — size alone is not enough

### Color and Materials
- Every color = semantic token. Build on system semantics, layer custom tokens on top
- Materials (`.ultraThinMaterial`, `.regularMaterial`) for translucency — not `Color.white.opacity(0.7)`
- 4.5:1 contrast body text, 3:1 large text + interactive, both modes
- `.foregroundStyle(.secondary)` / `.tertiary` — not manual opacity values
- Accent color: reserve for actions and focus. If everything is accented, nothing is

### Layout and Spacing
- All spacing through `Spacing` enum (4/8 grid). Respect safe areas unconditionally
- 16pt minimum horizontal margins compact-width. `.safeAreaInset()` for floating overlays
- `LazyVStack`/`LazyHStack` for 20+ items. Primary actions in thumb zone (bottom third)
- `.containerRelativeFrame()` (iOS 17+) over `GeometryReader` where possible

### Navigation

Pick the pattern based on app structure, not preference:

| App Shape | Pattern | When |
|---|---|---|
| 2-5 parallel sections | `TabView` | Most consumer apps. Noun labels ("Home," "Library," "Profile"). Max 5. |
| Linear drill-down | `NavigationStack` | Settings, detail views, single-task utilities. Value-based `.navigationDestination(for:)`. |
| Sidebar + detail | `NavigationSplitView` | iPad-primary or data-heavy apps. Sidebar for categories, detail for content. |
| Single immersive task | None / custom | Camera, meditation, full-screen reader. Minimal chrome. |

Presentation rules:
- `.sheet` — interruptible secondary tasks (compose, filter, quick edit)
- `.fullScreenCover` — immersive or blocking flows only (onboarding, camera, payment)
- `.presentationDetents([.medium, .large])` — progressive disclosure half-sheets
- `.searchable()` for search — never a custom text field in the nav bar
- `.navigationTransition(.zoom(sourceID: item.id, in: namespace))` (iOS 18+) for hero-to-detail zoom transitions
- No hamburger menus. iOS users do not expect or discover them.

### Motion
- `.animation(.default, value: someState)` — never `.animation(.default)` on containers
- `.matchedGeometryEffect` for hero transitions. `.contentTransition(.numericText())` for numbers
- **Always** check `accessibilityReduceMotion` → fall back to crossfade or `.none` (see Reduce Motion pattern in Reusable Patterns)
- Subtlety wins: 0.3s spring > bouncing card. Stagger list appearance with per-item delays
- Haptics: see Gesture & Interaction Patterns section for `.sensoryFeedback` usage

### Accessibility
- `accessibilityLabel` on every interactive element. `.accessibilityHidden(true)` on decorative images
- Test at XXL Dynamic Type. `@ScaledMetric` + `ViewThatFits` for overflow
- 44x44pt minimum tap targets. Never color-alone for meaning
- `.accessibilityElement(children: .combine)` for composite cards

### Adaptivity

iPhone and iPad are not separate designs — they are the same design responding to available space. Never build "iPhone version" and "iPad version." Build one adaptive layout.

**Size class decision tree:**

```swift
struct AdaptiveLayout<Compact: View, Regular: View>: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    let compact: () -> Compact
    let regular: () -> Regular

    var body: some View {
        if sizeClass == .compact {
            compact()
        } else {
            regular()
        }
    }
}

// Usage — same data, different spatial arrangement:
AdaptiveLayout {
    // Compact: single column, tab-based
    NavigationStack {
        ItemList(items: items)
    }
} regular: {
    // Regular: sidebar + detail
    NavigationSplitView {
        ItemList(items: items, selection: $selected)
    } detail: {
        if let selected { ItemDetail(item: selected) }
        else { ContentUnavailableView("Select an Item", systemImage: "doc") }
    }
    .navigationSplitViewStyle(.balanced)
}
```

**Content width capping** — wide screens need max-width constraints or text becomes unreadable:

```swift
.frame(maxWidth: 680)                          // hard cap for text-heavy content
.containerRelativeFrame(.horizontal) { w, _ in // proportional cap
    min(w * 0.85, 720)
}
```

**Grid column adaptation** — let the grid respond to width, not device:

```swift
// Adapts: 2 columns on iPhone, 3-4 on iPad, based on available width
let columns = [GridItem(.adaptive(minimum: 160, maximum: 240))]
LazyVGrid(columns: columns, spacing: Spacing.sm) {
    ForEach(items) { item in Card(item: item) }
}
```

**Preview both size classes:**

```swift
#Preview("Compact") { MyView().environment(\.horizontalSizeClass, .compact) }
#Preview("Regular") { MyView().environment(\.horizontalSizeClass, .regular).previewDevice("iPad Pro (12.9-inch)") }
```

Rules: check `horizontalSizeClass` (never device model), cap text at ~680pt wide, preview both size classes.

## Reusable Patterns

Adapt to your concept — don't copy verbatim.

### Reduce Motion Helper

Every animation must have this escape hatch:

```swift
@Environment(\.accessibilityReduceMotion) var reduceMotion

func adaptiveAnimation<V: Equatable>(_ value: V) -> Animation? {
    reduceMotion ? nil : .spring(duration: 0.3)
}
// Apply: withAnimation(adaptiveAnimation(trigger)) { state = newValue }
```

### Staggered Appear

```swift
struct StaggeredAppear: ViewModifier {
    let index: Int
    @State private var appeared = false
    @Environment(\.accessibilityReduceMotion) var reduceMotion

    func body(content: Content) -> some View {
        content
            .opacity(appeared ? 1 : 0)
            .offset(y: appeared ? 0 : 16)
            .animation(
                reduceMotion ? .none : .spring(duration: 0.4).delay(Double(index) * 0.05),
                value: appeared
            )
            .onAppear { appeared = true }
    }
}
```

### Animated Filter Bar

```swift
struct FilterBar: View {
    @Binding var selection: String
    let options: [String]
    @Namespace private var indicator

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.xs) {
                ForEach(options, id: \.self) { option in
                    Button {
                        withAnimation(.spring(duration: 0.3)) { selection = option }
                    } label: {
                        Text(option)
                            .font(.subheadline.weight(selection == option ? .semibold : .regular))
                            .foregroundStyle(selection == option ? Color.accentPrimary : .secondary)
                            .padding(.horizontal, Spacing.sm)
                            .padding(.vertical, Spacing.xs)
                            .background {
                                if selection == option {
                                    Capsule().fill(Color.accentPrimary.opacity(0.12))
                                        .matchedGeometryEffect(id: "filter", in: indicator)
                                }
                            }
                    }
                }
            }.padding(.horizontal, Spacing.md)
        }
        .sensoryFeedback(.selection, trigger: selection)
    }
}
```

### Shimmer Loading

```swift
struct Shimmer: ViewModifier {
    @State private var phase: CGFloat = -1

    func body(content: Content) -> some View {
        content.overlay {
            GeometryReader { geo in
                LinearGradient(colors: [.clear, .white.opacity(0.3), .clear],
                               startPoint: .leading, endPoint: .trailing)
                    .frame(width: geo.size.width * 0.6)
                    .offset(x: phase * geo.size.width)
            }.clipped()
        }
        .onAppear {
            withAnimation(.linear(duration: 1.2).repeatForever(autoreverses: false)) { phase = 1.5 }
        }
    }
}
extension View { func shimmer() -> some View { modifier(Shimmer()) } }
```

### View States

Every data-driven view MUST handle four states. Never show only the happy path.

```swift
enum ViewState<T> {
    case loading
    case empty
    case loaded(T)
    case error(String)
}

// Usage in a view:
struct ItemList: View {
    let state: ViewState<[Item]>

    var body: some View {
        switch state {
        case .loading:
            // Skeleton shimmer matching final layout shape
            VStack(spacing: Spacing.sm) {
                ForEach(0..<4, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: CornerRadius.sm)
                        .fill(Color(.tertiarySystemFill))
                        .frame(height: 64)
                        .shimmer()
                }
            }.padding(.horizontal, Spacing.md)

        case .empty:
            // Meaningful empty — not just "No items"
            ContentUnavailableView {
                Label("No Workouts Yet", systemImage: "figure.run")
            } description: {
                Text("Your completed workouts will appear here.")
            } actions: {
                Button("Start a Workout") { /* action */ }
                    .buttonStyle(.borderedProminent)
            }

        case .loaded(let items):
            LazyVStack(spacing: Spacing.sm) {
                ForEach(items) { item in ItemRow(item: item) }
            }

        case .error(let message):
            ContentUnavailableView {
                Label("Something Went Wrong", systemImage: "exclamationmark.triangle")
            } description: {
                Text(message)
            } actions: {
                Button("Try Again") { /* retry */ }
                    .buttonStyle(.bordered)
            }
        }
    }
}
```

Key rules for states:
- **Loading**: shimmer placeholders that match the final layout shape — not a centered spinner
- **Empty**: specific to the context ("No Workouts Yet" not "No Data"). Include an action when possible
- **Error**: human-readable message + retry action. Never show raw error codes
- **Transitions**: use `.animation(.default, value: state)` to animate between states smoothly

## Gesture & Interaction Patterns

Native iOS interactions that separate platform-native apps from web views wrapped in SwiftUI.

### Swipe Actions

```swift
.swipeActions(edge: .trailing, allowsFullSwipe: true) {
    Button(role: .destructive) { delete(item) } label: {
        Label("Delete", systemImage: "trash")
    }
}
.swipeActions(edge: .leading) {
    Button { pin(item) } label: {
        Label("Pin", systemImage: "pin")
    }.tint(.accent)
}
```

Rules: trailing = destructive/secondary, leading = positive/quick action. `allowsFullSwipe: true` only for destructive actions (matches Mail.app pattern). Always use `Label` not bare `Image` — VoiceOver needs the text.

### Context Menus

```swift
.contextMenu {
    Button { copy(item) } label: { Label("Copy", systemImage: "doc.on.doc") }
    Button { share(item) } label: { Label("Share", systemImage: "square.and.arrow.up") }
    Divider()
    Button(role: .destructive) { delete(item) } label: { Label("Delete", systemImage: "trash") }
} preview: {
    ItemDetailPreview(item: item) // Rich preview — not just the tapped cell
        .frame(width: 300, height: 200)
}
```

Rules: group related actions, destructive last after `Divider()`. Provide a `preview:` for rich context when the item has visual content.

### Symbol Effects (iOS 17+)

```swift
Image(systemName: "bell").symbolEffect(.bounce, value: notificationCount)   // Bounce on change
Image(systemName: "heart.fill").symbolEffect(.pulse, options: .repeating)   // Continuous pulse
Image(systemName: "wifi").symbolRenderingMode(.hierarchical)                // Depth via opacity layers
Image(systemName: "speaker.wave.3").symbolEffect(.variableColor.iterative.reversing) // Animated fill
```

Prefer `.symbolRenderingMode(.hierarchical)` over `.monochrome` — it adds depth for free. Use `.bounce` for state change feedback, `.pulse` for ongoing activity, `.variableColor` for live indicators.

### Haptic Feedback

```swift
.sensoryFeedback(.impact(weight: .medium), trigger: dragOffset)  // Physical drag feel
.sensoryFeedback(.success, trigger: taskCompleted)               // Completion confirmation
.sensoryFeedback(.selection, trigger: selectedTab)               // Picker/tab changes
```

Never use raw `UIImpactFeedbackGenerator` in SwiftUI — `.sensoryFeedback` is declarative and handles the lifecycle. Match feedback intensity to action weight: `.selection` for browsing, `.impact` for manipulation, `.success`/`.error` for outcomes.

## Worked Examples

Two contrasting examples to show range. The skill should produce work as distinctive as these — but different every time.

### Example A: Dark, Immersive, Minimal (Meditation App)

**Concept: "Twilight sanctuary"** — Deep navy-to-indigo, soft gold accent, whisper-light serif type, generous spacing, signature glowing pulse on the Begin button.

```swift
extension Color {
    static let surfacePrimary = Color(red: 0.06, green: 0.07, blue: 0.14)
    static let surfaceElevated = Color(red: 0.10, green: 0.11, blue: 0.20)
    static let accentPrimary = Color(red: 0.85, green: 0.72, blue: 0.40)
    static let accentGlow = accentPrimary.opacity(0.3)
}

struct MeditationHome: View {
    @State private var pulseScale: CGFloat = 1.0
    @Environment(\.accessibilityReduceMotion) var reduceMotion

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.surfacePrimary, Color(red: 0.08, green: 0.05, blue: 0.18)],
                           startPoint: .top, endPoint: .bottom).ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: Spacing.xxl) {
                    // Whisper-light serif greeting
                    Text("Good evening")
                        .font(.system(.largeTitle, design: .serif, weight: .ultraLight))
                        .foregroundStyle(.white)
                        .padding(.top, Spacing.xxl)

                    // SIGNATURE: Glowing Begin button
                    Button { } label: {
                        ZStack {
                            Circle().stroke(Color.accentGlow, lineWidth: 2)
                                .frame(width: 160, height: 160)
                                .scaleEffect(pulseScale)
                                .opacity(2.0 - Double(pulseScale))
                            Circle().fill(Color.surfaceElevated).frame(width: 140, height: 140)
                                .elevation(Elevation.floating)
                            VStack(spacing: Spacing.xxs) {
                                Image(systemName: "play.fill").font(.title)
                                Text("Begin").font(.headline)
                            }.foregroundStyle(Color.accentPrimary)
                        }
                    }
                    .accessibilityLabel("Begin meditation session")
                    .onAppear {
                        guard !reduceMotion else { return }
                        withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                            pulseScale = 1.15
                        }
                    }

                    // Dense session rows — rhythm contrast against generous hero
                    VStack(alignment: .leading, spacing: Spacing.md) {
                        Text("Recent").font(.caption.weight(.semibold))
                            .foregroundStyle(.white.opacity(0.35))
                            .textCase(.uppercase).tracking(1.2)
                            .padding(.horizontal, Spacing.md)
                        ForEach(0..<3) { i in
                            SessionRow().modifier(StaggeredAppear(index: i))
                        }
                    }
                }
            }
        }.preferredColorScheme(.dark)
    }
}
```

**What makes it work**: Navy gradient (not gray). Ultra-light serif (not bold sans). Gold on ONE element. Pulsing glow = signature. Dense rows contrast generous hero.

### Example B: Light, Editorial, Data-Rich (Finance Dashboard)

**Concept: "Paper ledger"** — Warm off-white surface, ink-black type with a serif display font (New York), forest green accent for positive values, muted red for negative. Signature: oversized hero number with `.numericText()` transition.

```swift
extension Color {
    static let surfacePrimary = Color(red: 0.97, green: 0.96, blue: 0.93)     // warm paper
    static let surfaceElevated = Color.white
    static let accentPositive = Color(red: 0.18, green: 0.52, blue: 0.34)     // forest green
    static let accentNegative = Color(red: 0.72, green: 0.25, blue: 0.22)     // muted brick
    static let textPrimary = Color(red: 0.12, green: 0.10, blue: 0.08)        // warm ink
}

struct FinanceDashboard: View {
    @State private var balance: Double = 12_847.32

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    // HERO: Oversized balance with editorial serif
                    VStack(spacing: Spacing.xs) {
                        Text("Total Balance")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.secondary)
                            .textCase(.uppercase).tracking(1.5)

                        Text(balance, format: .currency(code: "USD"))
                            .font(.system(size: 42, weight: .light, design: .serif))
                            .foregroundStyle(Color.textPrimary)
                            .contentTransition(.numericText(value: balance))

                        Text("+$842.17 this month")
                            .font(.subheadline.weight(.medium))
                            .foregroundStyle(Color.accentPositive)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, Spacing.xxl)
                    .background(Color.surfaceElevated)
                    .elevation(Elevation.subtle)

                    // DENSE: Transaction rows — no cards, inline dividers
                    VStack(alignment: .leading, spacing: 0) {
                        Text("This Week").font(.headline)
                            .padding(.horizontal, Spacing.md)
                            .padding(.top, Spacing.lg)
                            .padding(.bottom, Spacing.sm)

                        ForEach(0..<5) { index in
                            TransactionRow(isPositive: index % 3 == 0)
                                .modifier(StaggeredAppear(index: index))
                            Divider().padding(.leading, 60)
                        }
                    }
                }
            }
            .background(Color.surfacePrimary)
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct TransactionRow: View {
    let isPositive: Bool

    var body: some View {
        HStack(spacing: Spacing.md) {
            Circle()
                .fill(isPositive ? Color.accentPositive.opacity(0.12) : Color.accentNegative.opacity(0.12))
                .frame(width: 40, height: 40)
                .overlay {
                    Image(systemName: isPositive ? "arrow.down.left" : "arrow.up.right")
                        .font(.caption.bold())
                        .foregroundStyle(isPositive ? Color.accentPositive : Color.accentNegative)
                }

            VStack(alignment: .leading, spacing: 2) {
                Text("Coffee Shop").font(.subheadline.weight(.medium))
                Text("Today, 9:41 AM").font(.caption).foregroundStyle(.secondary)
            }

            Spacer()

            Text(isPositive ? "+$24.50" : "−$4.80")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(isPositive ? Color.accentPositive : Color.accentNegative)
        }
        .padding(.horizontal, Spacing.md)
        .padding(.vertical, Spacing.sm)
        .accessibilityElement(children: .combine)
    }
}
```

**What makes it work**: Warm paper surface (not white, not gray). Serif display number at 42pt — unmistakable hero. Green/red accent reserved for financial meaning (not generic blue). Inline rows with dividers (not cards). Uppercase tracking on labels = editorial craft. `.numericText()` transition on the balance.

## Scope and Boundaries

This skill is a complete, standalone creative director for iOS UI. It does not depend on any other skill to function.

**What this skill produces:**
- SwiftUI `View` implementations with working `#Preview` macros
- Design system tokens (colors, spacing, corner radii, elevation, typography scales)
- Custom `ButtonStyle`, `ViewModifier`, and component patterns
- Navigation structure and screen flow architecture
- Multi-device, multi-color-scheme preview configurations
- View-level presentation logic (`@Observable` view models when needed)

**What this skill does NOT produce** (and should not be asked to):
- Networking layers, API clients, or backend integration
- Core Data / SwiftData models or persistence logic
- Complex business logic or domain modeling
- App architecture beyond the view layer (DI containers, coordinators, service layers)
- Cross-platform UI (web, Android) — this is iOS-only

**When the task crosses boundaries**: If a screen design requires data models or networking, define the interface the view expects (a protocol or `@Observable` class with stub data) and note what the caller must provide. Do not implement the data layer — stub it for previews and let the developer fill in the real implementation.

**Platform target**: iOS 17+ by default. This enables `#Preview`, `@Observable`, `.sensoryFeedback`, `.symbolEffect`, `.containerRelativeFrame`, `.scrollTransition`, and `.contentTransition`. iOS 18+ APIs (`MeshGradient`, `.navigationTransition(.zoom)`) are noted inline — use when targeting iOS 18+. If the user specifies iOS 16 or earlier, note which APIs need fallbacks and provide them.
