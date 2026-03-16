import Foundation

@Observable
final class NewsListViewModel {
    private(set) var state: ViewState<[Article]> = .idle
    private(set) var selectedCategory: ArticleCategory?
    var searchText: String = ""

    private let fetchArticlesUseCase: FetchArticlesUseCaseProtocol

    init(fetchArticlesUseCase: FetchArticlesUseCaseProtocol) {
        self.fetchArticlesUseCase = fetchArticlesUseCase
    }

    // MARK: - Derived State

    var allArticles: [Article] {
        state.value ?? []
    }

    var filteredArticles: [Article] {
        var articles = allArticles
        if let category = selectedCategory {
            articles = articles.filter { $0.category == category }
        }

        if !searchText.isEmpty {
            articles = articles.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                    $0.source.localizedCaseInsensitiveContains(searchText) ||
                    $0.author.localizedCaseInsensitiveContains(searchText)
            }
        }

        return articles
    }

    // MARK: - Intent

    func loadArticles() async {
        guard case .idle = state else { return }
        await fetchArticles()
    }

    func selectCategory(_ category: ArticleCategory?) {
        selectedCategory = selectedCategory == category ? nil : category
    }

    func clearCategoryFilter() {
        selectedCategory = nil
    }

    func retry() async {
        await fetchArticles()
    }

    private func fetchArticles() async {
        state = .loading
        do {
            let articles = try await fetchArticlesUseCase.execute()
            state = .success(articles)
        } catch {
            state = .failure(error.localizedDescription)
        }
    }
}
