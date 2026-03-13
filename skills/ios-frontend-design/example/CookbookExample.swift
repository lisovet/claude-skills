import SwiftUI
import PlaygroundSupport

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// Concept: "Paper Ledger" — warm cream surface, forest green accent,
// New York serif display, dense editorial rows, oversized hero numbers.
// Signature: animated numeric transitions + full-bleed hero card.
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// MARK: - Design Tokens

extension Color {
    static let surface = Color(red: 0.97, green: 0.96, blue: 0.93)         // warm paper
    static let surfaceElevated = Color.white
    static let ink = Color(red: 0.12, green: 0.10, blue: 0.08)             // warm black
    static let inkSecondary = Color(red: 0.12, green: 0.10, blue: 0.08).opacity(0.5)
    static let inkTertiary = Color(red: 0.12, green: 0.10, blue: 0.08).opacity(0.3)
    static let accentGreen = Color(red: 0.18, green: 0.52, blue: 0.34)     // forest
    static let accentRed = Color(red: 0.72, green: 0.25, blue: 0.22)       // muted brick
    static let accentAmber = Color(red: 0.82, green: 0.63, blue: 0.21)     // warm gold
}

enum S {
    static let xxs: CGFloat = 4
    static let xs: CGFloat = 8
    static let sm: CGFloat = 12
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
    static let xxl: CGFloat = 48
}

enum R {
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 24
}

// MARK: - Models

struct Recipe: Identifiable {
    let id: UUID
    let title: String
    let author: String
    let time: Int // minutes
    let rating: Double
    let category: Category
    let isFeatured: Bool

    enum Category: String, CaseIterable {
        case seasonal = "Seasonal"
        case quick = "Quick"
        case baking = "Baking"
        case fermented = "Fermented"

        var icon: String {
            switch self {
            case .seasonal: return "leaf"
            case .quick: return "bolt"
            case .baking: return "flame"
            case .fermented: return "bubbles.and.sparkles"
            }
        }

        var tint: Color {
            switch self {
            case .seasonal: return .accentGreen
            case .quick: return .accentAmber
            case .baking: return .accentRed
            case .fermented: return Color(red: 0.45, green: 0.36, blue: 0.58)
            }
        }
    }
}

extension Recipe {
    static let sample: [Recipe] = [
        Recipe(id: UUID(), title: "Spring Pea Risotto\nwith Lemon Zest", author: "Clara Bates",
               time: 35, rating: 4.8, category: .seasonal, isFeatured: true),
        Recipe(id: UUID(), title: "Miso Caramel Brownies", author: "Kenji Mori",
               time: 45, rating: 4.9, category: .baking, isFeatured: false),
        Recipe(id: UUID(), title: "15-Min Kimchi Fried Rice", author: "Soo-Jin Park",
               time: 15, rating: 4.7, category: .quick, isFeatured: false),
        Recipe(id: UUID(), title: "Sourdough Focaccia", author: "Luca De Rossi",
               time: 180, rating: 4.6, category: .fermented, isFeatured: false),
        Recipe(id: UUID(), title: "Charred Broccoli Salad", author: "Amara Johnson",
               time: 20, rating: 4.5, category: .seasonal, isFeatured: false),
        Recipe(id: UUID(), title: "Tahini Chocolate Chip Cookies", author: "Noa Friedman",
               time: 30, rating: 4.8, category: .baking, isFeatured: false),
    ]
}

// MARK: - Filter Bar (Matched Geometry)

struct FilterBar: View {
    @Binding var selection: String
    let options: [String]
    @Namespace private var indicator

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: S.xs) {
                ForEach(options, id: \.self) { option in
                    Button {
                        withAnimation(.spring(duration: 0.3)) { selection = option }
                    } label: {
                        Text(option)
                            .font(.caption.weight(selection == option ? .semibold : .regular))
                            .foregroundStyle(selection == option ? Color.accentGreen : .inkSecondary)
                            .padding(.horizontal, S.xs + 2)
                            .padding(.vertical, S.xs)
                            .background {
                                if selection == option {
                                    Capsule().fill(Color.accentGreen.opacity(0.1))
                                        .matchedGeometryEffect(id: "filter", in: indicator)
                                }
                            }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, S.md)
        }
    }
}

// MARK: - Featured Card (Full-Bleed Hero)

struct FeaturedCard: View {
    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: S.md) {
            // Faux image — warm gradient with pattern
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: R.lg, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [Color.accentGreen.opacity(0.15), Color.accentAmber.opacity(0.1)],
                            startPoint: .topLeading, endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 220)
                    .overlay(alignment: .center) {
                        Image(systemName: "fork.knife")
                            .font(.system(size: 64, weight: .ultraLight))
                            .foregroundStyle(Color.accentGreen.opacity(0.2))
                    }

                // Category badge
                HStack(spacing: S.xxs) {
                    Image(systemName: recipe.category.icon)
                        .font(.caption2.bold())
                    Text(recipe.category.rawValue)
                        .font(.caption2.weight(.semibold))
                }
                .foregroundStyle(.white)
                .padding(.horizontal, S.sm)
                .padding(.vertical, S.xxs + 2)
                .background(Capsule().fill(recipe.category.tint))
                .padding(S.sm)
            }

            VStack(alignment: .leading, spacing: S.xxs) {
                Text(recipe.title)
                    .font(.system(.title2, design: .serif, weight: .semibold))
                    .foregroundStyle(Color.ink)
                    .lineLimit(2)

                HStack(spacing: S.md) {
                    Label(recipe.author, systemImage: "person")
                    Label("\(recipe.time) min", systemImage: "clock")
                    Label(String(format: "%.1f", recipe.rating), systemImage: "star.fill")
                        .foregroundStyle(Color.accentAmber)
                }
                .font(.caption)
                .foregroundStyle(Color.inkSecondary)
            }
        }
        .padding(S.md)
        .background(
            RoundedRectangle(cornerRadius: R.xl, style: .continuous)
                .fill(Color.surfaceElevated)
                .shadow(color: .black.opacity(0.06), radius: 12, y: 6)
        )
    }
}

// MARK: - Compact Row (Editorial Inline)

struct CompactRow: View {
    let recipe: Recipe
    let index: Int

    var body: some View {
        HStack(spacing: S.md) {
            // Oversized index number — editorial signature
            Text("\(index)")
                .font(.system(size: 32, weight: .light, design: .serif))
                .foregroundStyle(Color.inkTertiary)
                .frame(width: 36, alignment: .trailing)

            // Category dot
            Circle()
                .fill(recipe.category.tint)
                .frame(width: 8, height: 8)

            VStack(alignment: .leading, spacing: 2) {
                Text(recipe.title.replacingOccurrences(of: "\n", with: " "))
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(Color.ink)
                    .lineLimit(1)

                HStack(spacing: S.sm) {
                    Text(recipe.author)
                    Text("·")
                    Text("\(recipe.time) min")
                }
                .font(.caption)
                .foregroundStyle(Color.inkSecondary)
            }

            Spacer()

            Text(String(format: "%.1f", recipe.rating))
                .font(.system(.caption, design: .serif, weight: .semibold))
                .foregroundStyle(Color.accentGreen)
                .padding(.horizontal, S.xs)
                .padding(.vertical, S.xxs)
                .background(
                    RoundedRectangle(cornerRadius: R.sm, style: .continuous)
                        .fill(Color.accentGreen.opacity(0.08))
                )
        }
        .padding(.horizontal, S.md)
        .padding(.vertical, S.sm)
    }
}

// MARK: - Stat Pill

struct StatPill: View {
    let value: String
    let label: String
    let icon: String

    var body: some View {
        VStack(spacing: S.xxs) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundStyle(Color.accentGreen)
            Text(value)
                .font(.system(.title3, design: .serif, weight: .semibold))
                .foregroundStyle(Color.ink)
                .contentTransition(.numericText())
            Text(label)
                .font(.caption2)
                .foregroundStyle(Color.inkSecondary)
                .textCase(.uppercase)
                .tracking(0.5)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, S.sm)
        .background(
            RoundedRectangle(cornerRadius: R.md, style: .continuous)
                .fill(Color.surfaceElevated)
                .shadow(color: .black.opacity(0.03), radius: 4, y: 2)
        )
    }
}

// MARK: - Main View

struct CookbookHome: View {
    @State private var selectedFilter = "All"
    @State private var recipesCooked = 47
    let filters = ["All", "Seasonal", "Quick", "Baking", "Fermented"]
    let recipes = Recipe.sample

    var featured: Recipe { recipes.first(where: { $0.isFeatured })! }
    var rest: [Recipe] { recipes.filter { !$0.isFeatured } }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {

                // ── Header ──
                HStack(alignment: .firstTextBaseline) {
                    VStack(alignment: .leading, spacing: S.xxs) {
                        Text("Good morning")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(Color.inkSecondary)
                            .textCase(.uppercase)
                            .tracking(1.5)
                        Text("Cookbook")
                            .font(.system(size: 34, weight: .bold, design: .serif))
                            .foregroundStyle(Color.ink)
                    }
                    Spacer()
                    // Avatar placeholder
                    Circle()
                        .fill(Color.accentGreen.opacity(0.12))
                        .frame(width: 40, height: 40)
                        .overlay {
                            Text("CB")
                                .font(.caption.bold())
                                .foregroundStyle(Color.accentGreen)
                        }
                }
                .padding(.horizontal, S.md)
                .padding(.top, S.xl)
                .padding(.bottom, S.lg)

                // ── Stats Row ──
                HStack(spacing: S.xs) {
                    StatPill(value: "\(recipesCooked)", label: "Cooked", icon: "checkmark.circle")
                    StatPill(value: "12", label: "Saved", icon: "bookmark")
                    StatPill(value: "4.7", label: "Avg Rating", icon: "star")
                }
                .padding(.horizontal, S.md)
                .padding(.bottom, S.lg)

                // ── Filter Bar ──
                FilterBar(selection: $selectedFilter, options: filters)
                    .padding(.bottom, S.lg)

                // ── Featured Hero ──
                FeaturedCard(recipe: featured)
                    .padding(.horizontal, S.md)
                    .padding(.bottom, S.xl)

                // ── Section Header ──
                HStack {
                    Text("Trending This Week")
                        .font(.system(.headline, design: .serif))
                        .foregroundStyle(Color.ink)
                    Spacer()
                    Button("See All") {}
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Color.accentGreen)
                }
                .padding(.horizontal, S.md)
                .padding(.bottom, S.xs)

                // ── Compact Editorial Rows ──
                VStack(spacing: 0) {
                    ForEach(Array(rest.enumerated()), id: \.element.id) { index, recipe in
                        CompactRow(recipe: recipe, index: index + 2)

                        if index < rest.count - 1 {
                            Divider()
                                .padding(.leading, 72)
                        }
                    }
                }
                .padding(.bottom, S.xxl)
            }
        }
        .background(Color.surface.ignoresSafeArea())
    }
}

// MARK: - Recipe Detail

struct RecipeDetail: View {
    let recipe: Recipe

    let steps = [
        "Toast arborio rice in olive oil until translucent, about 2 minutes.",
        "Add wine and stir. Begin ladling warm stock, one scoop at a time.",
        "Blanch peas 90 seconds. Shock in ice bath to lock color.",
        "At al dente, fold in peas, mascarpone, and parmesan.",
        "Finish with lemon zest, pepper, and olive oil."
    ]

    let ingredients = [
        ("Arborio rice", "1.5 cups"),
        ("Fresh peas", "2 cups"),
        ("Vegetable stock", "4 cups"),
        ("Mascarpone", "3 tbsp"),
        ("Parmesan", "1/2 cup"),
        ("Lemon", "1 whole"),
    ]

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {

                // ── Hero image zone ──
                ZStack(alignment: .bottomLeading) {
                    LinearGradient(
                        colors: [Color.accentGreen.opacity(0.12), Color.accentAmber.opacity(0.08)],
                        startPoint: .topLeading, endPoint: .bottomTrailing
                    )
                    .frame(height: 200)
                    .overlay {
                        Image(systemName: "fork.knife")
                            .font(.system(size: 64, weight: .ultraLight))
                            .foregroundStyle(Color.accentGreen.opacity(0.15))
                    }

                    // Back button + save
                    HStack {
                        Circle()
                            .fill(.ultraThinMaterial)
                            .frame(width: 36, height: 36)
                            .overlay {
                                Image(systemName: "chevron.left")
                                    .font(.caption.bold())
                                    .foregroundStyle(Color.ink)
                            }
                        Spacer()
                        Circle()
                            .fill(.ultraThinMaterial)
                            .frame(width: 36, height: 36)
                            .overlay {
                                Image(systemName: "bookmark")
                                    .font(.caption.bold())
                                    .foregroundStyle(Color.ink)
                            }
                    }
                    .padding(.horizontal, S.md)
                    .padding(.top, S.xxl)
                    .frame(maxHeight: .infinity, alignment: .top)
                }

                // ── Title block ──
                VStack(alignment: .leading, spacing: S.sm) {
                    HStack(spacing: S.xxs) {
                        Image(systemName: recipe.category.icon)
                            .font(.caption2.bold())
                        Text(recipe.category.rawValue)
                            .font(.caption2.weight(.semibold))
                    }
                    .foregroundStyle(recipe.category.tint)

                    Text(recipe.title.replacingOccurrences(of: "\n", with: " "))
                        .font(.system(.title, design: .serif, weight: .bold))
                        .foregroundStyle(Color.ink)

                    HStack(spacing: S.lg) {
                        Label(recipe.author, systemImage: "person")
                        Label("\(recipe.time) min", systemImage: "clock")
                        HStack(spacing: S.xxs) {
                            Image(systemName: "star.fill")
                                .foregroundStyle(Color.accentAmber)
                            Text(String(format: "%.1f", recipe.rating))
                        }
                    }
                    .font(.caption)
                    .foregroundStyle(Color.inkSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(S.md)
                .padding(.top, S.sm)

                // ── Quick stats bar ──
                HStack(spacing: 0) {
                    StatBlock(value: "\(recipe.time)", unit: "min", label: "PREP + COOK")
                    Divider().frame(height: 32)
                    StatBlock(value: "4", unit: "", label: "SERVINGS")
                    Divider().frame(height: 32)
                    StatBlock(value: "320", unit: "cal", label: "PER SERVING")
                }
                .padding(.vertical, S.sm)
                .background(Color.surfaceElevated)
                .clipShape(RoundedRectangle(cornerRadius: R.md, style: .continuous))
                .shadow(color: .black.opacity(0.04), radius: 4, y: 2)
                .padding(.horizontal, S.md)
                .padding(.bottom, S.lg)

                // ── Ingredients ──
                VStack(alignment: .leading, spacing: S.sm) {
                    Text("Ingredients")
                        .font(.system(.headline, design: .serif))
                        .foregroundStyle(Color.ink)

                    ForEach(Array(ingredients.enumerated()), id: \.offset) { _, item in
                        HStack {
                            Text(item.0)
                                .font(.subheadline)
                                .foregroundStyle(Color.ink)
                            Spacer()
                            Text(item.1)
                                .font(.subheadline)
                                .foregroundStyle(Color.inkSecondary)
                        }
                        .padding(.vertical, S.xxs)
                    }
                }
                .padding(.horizontal, S.md)
                .padding(.bottom, S.lg)

                Divider().padding(.horizontal, S.md)

                // ── Steps ──
                VStack(alignment: .leading, spacing: S.md) {
                    Text("Method")
                        .font(.system(.headline, design: .serif))
                        .foregroundStyle(Color.ink)
                        .padding(.top, S.lg)

                    ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
                        HStack(alignment: .top, spacing: S.md) {
                            // Step number with timeline
                            VStack(spacing: 0) {
                                Circle()
                                    .fill(index == 0 ? Color.accentGreen : Color.inkTertiary)
                                    .frame(width: 24, height: 24)
                                    .overlay {
                                        Text("\(index + 1)")
                                            .font(.caption2.bold())
                                            .foregroundStyle(index == 0 ? .white : Color.ink)
                                    }
                                if index < steps.count - 1 {
                                    Rectangle()
                                        .fill(Color.inkTertiary.opacity(0.3))
                                        .frame(width: 1)
                                        .frame(maxHeight: .infinity)
                                }
                            }
                            .frame(width: 24)

                            Text(step)
                                .font(.subheadline)
                                .foregroundStyle(Color.ink.opacity(0.85))
                                .lineSpacing(4)
                                .padding(.bottom, S.md)
                        }
                    }
                }
                .padding(.horizontal, S.md)
                .padding(.bottom, S.lg)

                // ── CTA ──
                Button {} label: {
                    Text("Start Cooking")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(
                            RoundedRectangle(cornerRadius: R.md, style: .continuous)
                                .fill(Color.accentGreen)
                        )
                }
                .buttonStyle(.plain)
                .padding(.horizontal, S.md)
                .padding(.bottom, S.xxl)
            }
        }
        .background(Color.surface.ignoresSafeArea())
    }
}

struct StatBlock: View {
    let value: String
    let unit: String
    let label: String

    var body: some View {
        VStack(spacing: S.xxs) {
            HStack(spacing: 2) {
                Text(value)
                    .font(.system(.title3, design: .serif, weight: .semibold))
                    .foregroundStyle(Color.ink)
                if !unit.isEmpty {
                    Text(unit)
                        .font(.caption)
                        .foregroundStyle(Color.inkSecondary)
                }
            }
            Text(label)
                .font(.system(size: 9, weight: .semibold))
                .foregroundStyle(Color.inkTertiary)
                .tracking(0.5)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Live View

PlaygroundPage.current.setLiveView(
    HStack(spacing: 20) {
        CookbookHome()
            .frame(width: 393, height: 852)
            .clipShape(RoundedRectangle(cornerRadius: 40, style: .continuous))
            .shadow(color: .black.opacity(0.2), radius: 20, y: 10)

        RecipeDetail(recipe: Recipe.sample[0])
            .frame(width: 393, height: 852)
            .clipShape(RoundedRectangle(cornerRadius: 40, style: .continuous))
            .shadow(color: .black.opacity(0.2), radius: 20, y: 10)
    }
    .padding(40)
    .background(Color(white: 0.95))
)
