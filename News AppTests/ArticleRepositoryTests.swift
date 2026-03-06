import Testing
@testable import News_App

@Suite("ArticleRepository")
@MainActor
struct ArticleRepositoryTests {

    // MARK: - fetchArticles

    @Test("fetchArticles maps DTOs to domain models")
    func fetchArticlesMapesDTOs() async throws {
        let dataSource = MockArticleDataSource()
        dataSource.stubbedArticles = [.fixture]
        let sut = ArticleRepository(dataSource: dataSource)

        let articles = try await sut.fetchArticles()

        #expect(articles.count == 1)
        #expect(articles[0].id == ArticleDTO.fixture.id)
        #expect(articles[0].category == .technology)
    }

    @Test("fetchArticles returns empty array when data source is empty")
    func fetchArticlesReturnsEmpty() async throws {
        let dataSource = MockArticleDataSource()
        let sut = ArticleRepository(dataSource: dataSource)

        let articles = try await sut.fetchArticles()

        #expect(articles.isEmpty)
    }

    @Test("fetchArticles propagates data source error")
    func fetchArticlesPropagatesError() async throws {
        let dataSource = MockArticleDataSource()
        dataSource.stubbedError = DomainError.dataUnavailable
        let sut = ArticleRepository(dataSource: dataSource)

        await #expect(throws: DomainError.dataUnavailable) {
            try await sut.fetchArticles()
        }
    }

    // MARK: - fetchArticle(byId:)

    @Test("fetchArticle(byId:) returns mapped domain model")
    func fetchArticleByIdReturnsMappedModel() async throws {
        let dataSource = MockArticleDataSource()
        dataSource.stubbedArticles = [.fixture]
        let sut = ArticleRepository(dataSource: dataSource)

        let article = try await sut.fetchArticle(byId: ArticleDTO.fixture.id)

        #expect(article.id == ArticleDTO.fixture.id)
        #expect(article.title == ArticleDTO.fixture.title)
    }

    @Test("fetchArticle(byId:) throws articleNotFound for unknown id")
    func fetchArticleByIdThrowsNotFound() async throws {
        let dataSource = MockArticleDataSource()
        let sut = ArticleRepository(dataSource: dataSource)

        await #expect(throws: DomainError.articleNotFound) {
            try await sut.fetchArticle(byId: "unknown-id")
        }
    }
}
