import SwiftUI

struct NewsListContentView: View {
    let viewModel: NewsListViewModel

    @Environment(AppRouter.self)
    private var router

    @State
    private var scrollPosition = ScrollPosition(edge: .top)

    var body: some View {
        ScrollView {
            if viewModel.filteredArticles.isEmpty {
                ContentUnavailableView.search(
                    text: viewModel.searchText.isEmpty
                        ? (viewModel.selectedCategory?.rawValue ?? "")
                        : viewModel.searchText
                )
                .padding(.top, Spacing.huge)
            } else {
                LazyVStack(spacing: Spacing.md) {
                    ForEach(viewModel.filteredArticles) { article in
                        Button {
                            router.push(.articleDetail(articleId: article.id))
                        } label: {
                            ArticleCardView(article: article)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, Spacing.lg)
            }
        }
        .scrollDismissesKeyboard(.interactively)
        .scrollPosition($scrollPosition)
        .background(Color(.systemGroupedBackground))
        .onChange(of: viewModel.selectedCategory) {
            scrollPosition.scrollTo(edge: .top)
        }
        .onChange(of: viewModel.searchText) {
            scrollPosition.scrollTo(edge: .top)
        }
    }
}
