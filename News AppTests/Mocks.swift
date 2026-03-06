import Foundation
@testable import News_App

// MARK: - Article Fixtures

extension Article {
    static let fixture = Article(
        id: "fixture-1",
        title: "Test Article Title",
        source: "Test Source",
        author: "Test Author",
        publishedAt: Date(timeIntervalSince1970: 1_700_000_000),
        category: .technology,
        summary: "Test summary",
        content: "Paragraph one.\n\nParagraph two.",
        readTimeMinutes: 4,
        isTrending: true,
        reliabilityScore: 87
    )

    static let fixture2 = Article(
        id: "fixture-2",
        title: "Another Article",
        source: "Other Source",
        author: "Other Author",
        publishedAt: Date(timeIntervalSince1970: 1_700_001_000),
        category: .health,
        summary: "Another summary",
        content: "Some content.",
        readTimeMinutes: 2,
        isTrending: false,
        reliabilityScore: 45
    )
}

extension ArticleDTO {
    static let fixture = ArticleDTO(
        id: "fixture-1",
        title: "Test Article Title",
        source: "Test Source",
        author: "Test Author",
        publishedAt: Date(timeIntervalSince1970: 1_700_000_000),
        categoryRaw: "Technology",
        summary: "Test summary",
        content: "Paragraph one.\n\nParagraph two.",
        readTimeMinutes: 4,
        isTrending: true,
        reliabilityScore: 87
    )
}

// MARK: - Mock Data Source

final class MockArticleDataSource: ArticleDataSourceProtocol {
    var stubbedArticles: [ArticleDTO] = []
    var stubbedError: Error?

    func fetchAll() async throws -> [ArticleDTO] {
        if let error = stubbedError { throw error }
        return stubbedArticles
    }

    func fetch(byId id: String) async throws -> ArticleDTO {
        if let error = stubbedError { throw error }
        guard let dto = stubbedArticles.first(where: { $0.id == id }) else {
            throw DomainError.articleNotFound
        }
        return dto
    }
}

// MARK: - Mock Repository

final class MockArticleRepository: ArticleRepositoryProtocol {
    var stubbedArticles: [Article] = []
    var stubbedError: Error?

    func fetchArticles() async throws -> [Article] {
        if let error = stubbedError { throw error }
        return stubbedArticles
    }

    func fetchArticle(byId id: String) async throws -> Article {
        if let error = stubbedError { throw error }
        guard let article = stubbedArticles.first(where: { $0.id == id }) else {
            throw DomainError.articleNotFound
        }
        return article
    }
}

// MARK: - Mock Use Cases

final class MockFetchArticlesUseCase: FetchArticlesUseCaseProtocol {
    var stubbedArticles: [Article] = []
    var stubbedError: Error?

    func execute() async throws -> [Article] {
        if let error = stubbedError { throw error }
        return stubbedArticles
    }
}

final class MockFetchArticleDetailUseCase: FetchArticleDetailUseCaseProtocol {
    var stubbedArticle: Article?
    var stubbedError: Error?

    func execute(articleId: String) async throws -> Article {
        if let error = stubbedError { throw error }
        guard let article = stubbedArticle else { throw DomainError.articleNotFound }
        return article
    }
}
