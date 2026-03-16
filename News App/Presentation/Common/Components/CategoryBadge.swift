import SwiftUI

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
