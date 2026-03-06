import SwiftUI

struct CategoryChipView: View {
    let category: ArticleCategory
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: Spacing.xs) {
                Image(systemName: category.iconName)
                    .font(.caption2)
                Text(category.rawValue)
                    .font(.caption)
                    .fontWeight(isSelected ? .semibold : .regular)
            }
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, Spacing.sm)
            .foregroundStyle(isSelected ? category.color : .secondary)
            .glassEffect(in: .capsule)
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}

#Preview("CategoryChipView") {
    GlassEffectContainer {
        HStack(spacing: Spacing.sm) {
            CategoryChipView(category: .technology, isSelected: true, onTap: {})
            CategoryChipView(category: .sports, isSelected: false, onTap: {})
            CategoryChipView(category: .health, isSelected: false, onTap: {})
        }
        .padding()
    }
}
