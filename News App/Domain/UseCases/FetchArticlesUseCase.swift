import Foundation

protocol FetchArticlesUseCaseProtocol {
    func execute() async throws -> [Article]
}

final class FetchArticlesUseCase: FetchArticlesUseCaseProtocol {
    private let repository: ArticleRepositoryProtocol

    init(repository: ArticleRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [Article] {
        try await repository.fetchArticles()
    }
}
