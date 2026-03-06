import Foundation

protocol ArticleRepositoryProtocol {
    func fetchArticles() async throws -> [Article]
    func fetchArticle(byId id: String) async throws -> Article
}
