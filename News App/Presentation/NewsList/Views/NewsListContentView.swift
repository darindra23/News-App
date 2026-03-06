import SwiftUI

struct NewsListContentView: View {
    let viewModel: NewsListViewModel

    @Environment(AppRouter.self)
    private var router

    @State
    private var scrollPosition = ScrollPosition(edge: .top)

    var body: some View {
        ScrollView {
            LazyVStack(spacing: .zero, pinnedViews: .sectionHeaders) {
                if viewModel.selectedCategory == nil && viewModel.searchText.isEmpty {
                    trendingSection
                }

                Section {
                    articleListSection
                } header: {
                    CategoryFilterBarView(viewModel: viewModel)
                }
            }
        }
        .scrollPosition($scrollPosition)
        .background(Color(.systemGroupedBackground))
        .onChange(of: viewModel.selectedCategory) {
            scrollPosition.scrollTo(edge: .top)
        }
        .onChange(of: viewModel.searchText) {
            scrollPosition.scrollTo(edge: .top)
        }
    }

    // MARK: - Trending Section

    private var trendingSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack {
                Image(systemName: "flame.fill")
                    .foregroundStyle(.orange)
                Text("Trending")
                    .font(.headline)
                    .fontWeight(.bold)
            }
            .padding(.horizontal)
            .padding(.top, Spacing.lg)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Spacing.md) {
                    ForEach(viewModel.trendingArticles) { article in
                        Button {
                            router.push(.articleDetail(articleId: article.id))
                        } label: {
                            TrendingCardView(article: article)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, Spacing.lg)
            }
        }
    }

    // MARK: - Article List Section

    private var articleListSection: some View {
        Group {
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
                .padding(Spacing.lg)
            }
        }
    }
}
