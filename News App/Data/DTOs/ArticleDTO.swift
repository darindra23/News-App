import Foundation

struct ArticleDTO {
    let id: String
    let title: String
    let source: String
    let author: String
    let publishedAt: Date
    let categoryRaw: String
    let summary: String
    let content: String
    let readTimeMinutes: Int
    let isTrending: Bool
    let reliabilityScore: Int

    func toDomain() -> Article {
        Article(
            id: id,
            title: title,
            source: source,
            author: author,
            publishedAt: publishedAt,
            category: ArticleCategory(rawValue: categoryRaw) ?? .technology,
            summary: summary,
            content: content,
            readTimeMinutes: readTimeMinutes,
            isTrending: isTrending,
            reliabilityScore: reliabilityScore
        )
    }
}
