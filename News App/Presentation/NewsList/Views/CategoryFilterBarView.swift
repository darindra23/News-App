import SwiftUI

// MARK: - Category Filter Bar

struct CategoryFilterBarView: View {
    let viewModel: NewsListViewModel

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Spacing.sm) {
                    BreakingTabView(isSelected: viewModel.selectedCategory == nil) {
                        viewModel.clearCategoryFilter()
                    }
                    .id("breaking")

                    ForEach(ArticleCategory.allCases) { category in
                        CategoryChipView(
                            category: category,
                            isSelected: viewModel.selectedCategory == category
                        ) {
                            viewModel.selectCategory(category)
                        }
                        .id(category.id)
                    }
                }
                .padding(.vertical, Spacing.sm)
            }
            .contentMargins(.horizontal, Spacing.lg, for: .scrollContent)
            .background(Color(.systemGroupedBackground))
            .onChange(of: viewModel.selectedCategory) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    if let selected = viewModel.selectedCategory {
                        proxy.scrollTo(selected.id, anchor: .leading)
                    } else {
                        proxy.scrollTo("breaking", anchor: .leading)
                    }
                }
            }
        }
    }
}

// MARK: - Breaking Tab

struct BreakingTabView: View {
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 5) {
                Image(systemName: "globe")
                    .font(.system(size: 24))
                    .foregroundStyle(isSelected ? Color.white : Color(.tertiaryLabel))

                Text("Breaking")
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

#Preview("CategoryFilterBarView") {
    @Previewable @State var viewModel = AppDependencies.shared.makeNewsListViewModel()
    VStack {
        CategoryFilterBarView(viewModel: viewModel)
        Text(viewModel.selectedCategory?.rawValue ?? "Breaking")
            .font(.caption)
            .foregroundStyle(.secondary)
    }
    .padding(.vertical)
}
