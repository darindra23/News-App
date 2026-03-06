import Foundation

@Observable
final class ArticleDetailViewModel {
    private(set) var state: ViewState<Article> = .idle
    private(set) var isBookmarked: Bool = false

    private let articleId: String
    private let fetchArticleDetailUseCase: FetchArticleDetailUseCaseProtocol

    init(
        articleId: String,
        fetchArticleDetailUseCase: FetchArticleDetailUseCaseProtocol
    ) {
        self.articleId = articleId
        self.fetchArticleDetailUseCase = fetchArticleDetailUseCase
    }

    // MARK: - Derived State

    var article: Article? { state.value }

    var formattedDate: String {
        guard let article else { return "" }
        return article.publishedAt.formatted(date: .long, time: .shortened)
    }

    var relativeDate: String {
        guard let article else { return "" }
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: article.publishedAt, relativeTo: .now)
    }

    var readTimeText: String {
        guard let article else { return "" }
        return "\(article.readTimeMinutes) min read"
    }

    // MARK: - Intent

    func loadArticle() async {
        state = .loading
        do {
            let article = try await fetchArticleDetailUseCase.execute(articleId: articleId)
            state = .success(article)
        } catch {
            state = .failure(error.localizedDescription)
        }
    }

    func retry() async {
        await loadArticle()
    }

    func toggleBookmark() {
        isBookmarked.toggle()
    }
}
