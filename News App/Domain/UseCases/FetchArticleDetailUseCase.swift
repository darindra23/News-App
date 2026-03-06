import Foundation

protocol FetchArticleDetailUseCaseProtocol {
    func execute(articleId: String) async throws -> Article
}

final class FetchArticleDetailUseCase: FetchArticleDetailUseCaseProtocol {
    private let repository: ArticleRepositoryProtocol

    init(repository: ArticleRepositoryProtocol) {
        self.repository = repository
    }

    func execute(articleId: String) async throws -> Article {
        try await repository.fetchArticle(byId: articleId)
    }
}
