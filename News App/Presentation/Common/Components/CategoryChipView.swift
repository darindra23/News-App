import SwiftUI

// MARK: - Category Tab (Oigetit style: vertical icon + text tile)

struct CategoryChipView: View {
    let category: ArticleCategory
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 5) {
                Image(systemName: category.iconName)
                    .font(.system(size: 24))
                    .foregroundStyle(isSelected ? Color.white : Color(.tertiaryLabel))

                Text(category.displayName)
                    .lineLimit(1)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(isSelected ? Color.white : Color(.label))
            }
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, 10)
            .frame(minWidth: 64)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(isSelected ? OigetitTheme.primaryBlue : Color(.systemBackground))
                    .shadow(
                        color: isSelected ? OigetitTheme.primaryBlue.opacity(0.35) : .black.opacity(0.06),
                        radius: isSelected ? 4 : 2,
                        x: 0,
                        y: 1
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(
                        isSelected ? Color.clear : Color(.systemGray4),
                        lineWidth: 0.5
                    )
            )
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}

#Preview("CategoryChipView") {
    HStack(spacing: Spacing.sm) {
        CategoryChipView(category: .technology, isSelected: true, onTap: {})
        CategoryChipView(category: .sports, isSelected: false, onTap: {})
        CategoryChipView(category: .entertainment, isSelected: false, onTap: {})
    }
    .padding()
}
