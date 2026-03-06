import SwiftUI

struct TrendingCardView: View {
    let article: Article

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Gradient background
            LinearGradient(
                colors: [
                    article.category.color,
                    article.category.color.opacity(0.7)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            // Decorative icon
            Image(systemName: article.category.iconName)
                .font(.system(size: 80))
                .foregroundStyle(.white.opacity(0.12))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(Spacing.lg)

            // Content
            VStack(alignment: .leading, spacing: Spacing.xs) {
                CategoryBadge(category: article.category, style: .light)

                Text(article.title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .lineLimit(2)

                HStack(spacing: Spacing.xs) {
                    Image(systemName: "clock")
                        .font(.caption2)
                    Text("\(article.readTimeMinutes) min")
                        .font(.caption2)
                    Text("·")
                    Text(article.source)
                        .font(.caption2)
                        .fontWeight(.medium)
                }
                .foregroundStyle(.white.opacity(0.85))
            }
            .padding(Spacing.md)
        }
        .frame(width: 250, height: 160)
        .clipShape(RoundedRectangle(cornerRadius: Spacing.lg))
        .shadow(color: article.category.color.opacity(0.35), radius: Spacing.sm, x: 0, y: Spacing.xs)
    }
}

// MARK: - Category Badge

struct CategoryBadge: View {
    enum Style { case colored, light }

    let category: ArticleCategory
    var style: Style = .colored

    var body: some View {
        HStack(spacing: Spacing.xs) {
            Image(systemName: category.iconName)
                .font(.caption2)
            Text(category.rawValue)
                .font(.caption2)
                .fontWeight(.semibold)
        }
        .padding(.horizontal, Spacing.sm)
        .padding(.vertical, Spacing.xs)
        .background(badgeBackground)
        .foregroundStyle(badgeForeground)
        .clipShape(Capsule())
    }

    private var badgeBackground: Color {
        switch style {
        case .colored: return category.color
        case .light:   return .white.opacity(0.25)
        }
    }

    private var badgeForeground: Color { .white }
}

#Preview("TrendingCardView") {
    ScrollView(.horizontal) {
        HStack(spacing: Spacing.md) {
            TrendingCardView(article: .mock)
            TrendingCardView(article: .mockLowReliability)
        }
        .padding()
    }
}

#Preview("CategoryBadge") {
    HStack(spacing: Spacing.md) {
        CategoryBadge(category: .technology, style: .colored)
        CategoryBadge(category: .health, style: .light)
            .padding()
            .background(.black)
            .clipShape(Capsule())
    }
    .padding()
}
