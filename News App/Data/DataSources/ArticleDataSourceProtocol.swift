import Foundation

protocol ArticleDataSourceProtocol {
    func fetchAll() async throws -> [ArticleDTO]
    func fetch(byId id: String) async throws -> ArticleDTO
}
