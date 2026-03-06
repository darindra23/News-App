import Testing
@testable import News_App

@Suite("ArticleDetailViewModel")
@MainActor
struct ArticleDetailViewModelTests {

    // MARK: - loadArticle

    @Test("loadArticle transitions to success state")
    func loadArticleSuccess() async {
        let useCase = MockFetchArticleDetailUseCase()
        useCase.stubbedArticle = .fixture
        let sut = ArticleDetailViewModel(
            articleId: Article.fixture.id,
            fetchArticleDetailUseCase: useCase
        )

        await sut.loadArticle()

        guard case .success(let article) = sut.state else {
            Issue.record("Expected .success state")
            return
        }
        #expect(article.id == Article.fixture.id)
    }

    @Test("loadArticle transitions to failure state on error")
    func loadArticleFailure() async {
        let useCase = MockFetchArticleDetailUseCase()
        useCase.stubbedError = DomainError.articleNotFound
        let sut = ArticleDetailViewModel(
            articleId: "missing-id",
            fetchArticleDetailUseCase: useCase
        )

        await sut.loadArticle()

        guard case .failure(let message) = sut.state else {
            Issue.record("Expected .failure state")
            return
        }
        #expect(!message.isEmpty)
    }

    @Test("retry refetches and updates state")
    func retryRefetchesArticle() async {
        let useCase = MockFetchArticleDetailUseCase()
        useCase.stubbedError = DomainError.articleNotFound
        let sut = ArticleDetailViewModel(
            articleId: Article.fixture.id,
            fetchArticleDetailUseCase: useCase
        )

        await sut.loadArticle()

        useCase.stubbedError = nil
        useCase.stubbedArticle = .fixture
        await sut.retry()

        guard case .success(let article) = sut.state else {
            Issue.record("Expected .success state after retry")
            return
        }
        #expect(article.id == Article.fixture.id)
    }

    // MARK: - Bookmark

    @Test("toggleBookmark flips isBookmarked to true")
    func toggleBookmarkToTrue() {
        let sut = ArticleDetailViewModel(
            articleId: Article.fixture.id,
            fetchArticleDetailUseCase: MockFetchArticleDetailUseCase()
        )

        sut.toggleBookmark()

        #expect(sut.isBookmarked == true)
    }

    @Test("toggleBookmark flips isBookmarked back to false")
    func toggleBookmarkToFalse() {
        let sut = ArticleDetailViewModel(
            articleId: Article.fixture.id,
            fetchArticleDetailUseCase: MockFetchArticleDetailUseCase()
        )

        sut.toggleBookmark()
        sut.toggleBookmark()

        #expect(sut.isBookmarked == false)
    }

    // MARK: - Derived State

    @Test("article returns nil before loading")
    func articleIsNilBeforeLoad() {
        let sut = ArticleDetailViewModel(
            articleId: Article.fixture.id,
            fetchArticleDetailUseCase: MockFetchArticleDetailUseCase()
        )

        #expect(sut.article == nil)
    }

    @Test("article returns loaded article after success")
    func articleIsAvailableAfterLoad() async {
        let useCase = MockFetchArticleDetailUseCase()
        useCase.stubbedArticle = .fixture
        let sut = ArticleDetailViewModel(
            articleId: Article.fixture.id,
            fetchArticleDetailUseCase: useCase
        )

        await sut.loadArticle()

        #expect(sut.article?.id == Article.fixture.id)
    }

    @Test("readTimeText returns empty string before loading")
    func readTimeTextEmptyBeforeLoad() {
        let sut = ArticleDetailViewModel(
            articleId: Article.fixture.id,
            fetchArticleDetailUseCase: MockFetchArticleDetailUseCase()
        )

        #expect(sut.readTimeText == "")
    }

    @Test("readTimeText returns formatted string after loading")
    func readTimeTextFormattedAfterLoad() async {
        let useCase = MockFetchArticleDetailUseCase()
        useCase.stubbedArticle = .fixture
        let sut = ArticleDetailViewModel(
            articleId: Article.fixture.id,
            fetchArticleDetailUseCase: useCase
        )

        await sut.loadArticle()

        #expect(sut.readTimeText == "\(Article.fixture.readTimeMinutes) min read")
    }
}
