import Foundation

final class ArticleRepository: ArticleRepositoryProtocol {
    private let dataSource: ArticleDataSourceProtocol

    init(dataSource: ArticleDataSourceProtocol) {
        self.dataSource = dataSource
    }

    func fetchArticles() async throws -> [Article] {
        let dtos = try await dataSource.fetchAll()
        return dtos.map { $0.toDomain() }
    }

    func fetchArticle(byId id: String) async throws -> Article {
        let dto = try await dataSource.fetch(byId: id)
        return dto.toDomain()
    }
}
