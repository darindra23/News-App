import SwiftUI

struct CategoryFilterBarView: View {
    let viewModel: NewsListViewModel

    private enum ChipID: Hashable {
        case all
        case category(ArticleCategory)
    }

    var body: some View {
        ScrollViewReader { proxy in
            GlassEffectContainer {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: Spacing.sm) {
                        Button {
                            viewModel.clearCategoryFilter()
                        } label: {
                            HStack(spacing: Spacing.xs) {
                                Image(systemName: "newspaper")
                                    .font(.caption2)
                                Text("All")
                                    .font(.caption)
                                    .fontWeight(viewModel.selectedCategory == nil ? .semibold : .regular)
                            }
                            .padding(.horizontal, Spacing.md)
                            .padding(.vertical, Spacing.sm)
                            .foregroundStyle(viewModel.selectedCategory == nil ? Color.accentColor : .secondary)
                            .glassEffect(in: .capsule)
                        }
                        .buttonStyle(.plain)
                        .id(ChipID.all)

                        ForEach(ArticleCategory.allCases) { category in
                            CategoryChipView(
                                category: category,
                                isSelected: viewModel.selectedCategory == category
                            ) {
                                viewModel.selectCategory(category)
                            }
                            .id(ChipID.category(category))
                        }
                    }
                    .padding(.vertical, Spacing.sm)
                }
                .contentMargins(.horizontal, Spacing.lg, for: .scrollContent)
            }
            .onChange(of: viewModel.selectedCategory) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    if let selected = viewModel.selectedCategory {
                        proxy.scrollTo(ChipID.category(selected), anchor: .leading)
                    } else {
                        proxy.scrollTo(ChipID.all, anchor: .leading)
                    }
                }
            }
        }
    }
}

#Preview("CategoryFilterBarView") {
    @Previewable @State var viewModel = AppDependencies.shared.makeNewsListViewModel()
    VStack {
        CategoryFilterBarView(viewModel: viewModel)
        Text(viewModel.selectedCategory?.rawValue ?? "All")
            .font(.caption)
            .foregroundStyle(.secondary)
    }
    .padding(.vertical)
}
