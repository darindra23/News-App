import Testing
@testable import News_App

@Suite("FetchArticlesUseCase")
@MainActor
struct FetchArticlesUseCaseTests {

    @Test("execute returns articles from repository")
    func executeReturnsArticles() async throws {
        let repository = MockArticleRepository()
        repository.stubbedArticles = [.fixture, .fixture2]
        let sut = FetchArticlesUseCase(repository: repository)

        let articles = try await sut.execute()

        #expect(articles.count == 2)
        #expect(articles[0].id == Article.fixture.id)
    }

    @Test("execute propagates repository error")
    func executePropagatesError() async throws {
        let repository = MockArticleRepository()
        repository.stubbedError = DomainError.dataUnavailable
        let sut = FetchArticlesUseCase(repository: repository)

        await #expect(throws: DomainError.dataUnavailable) {
            try await sut.execute()
        }
    }
}

@Suite("FetchArticleDetailUseCase")
@MainActor
struct FetchArticleDetailUseCaseTests {

    @Test("execute returns article from repository")
    func executeReturnsArticle() async throws {
        let repository = MockArticleRepository()
        repository.stubbedArticles = [.fixture]
        let sut = FetchArticleDetailUseCase(repository: repository)

        let article = try await sut.execute(articleId: Article.fixture.id)

        #expect(article.id == Article.fixture.id)
        #expect(article.title == Article.fixture.title)
    }

    @Test("execute throws articleNotFound for unknown id")
    func executeThrowsNotFound() async throws {
        let repository = MockArticleRepository()
        let sut = FetchArticleDetailUseCase(repository: repository)

        await #expect(throws: DomainError.articleNotFound) {
            try await sut.execute(articleId: "unknown-id")
        }
    }

    @Test("execute propagates repository error")
    func executePropagatesError() async throws {
        let repository = MockArticleRepository()
        repository.stubbedError = DomainError.dataUnavailable
        let sut = FetchArticleDetailUseCase(repository: repository)

        await #expect(throws: DomainError.dataUnavailable) {
            try await sut.execute(articleId: Article.fixture.id)
        }
    }
}
