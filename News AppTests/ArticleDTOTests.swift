import Testing
import Foundation
@testable import News_App

@Suite("ArticleDTO")
struct ArticleDTOTests {

    @Test("toDomain maps all fields correctly")
    func toDomainMapsAllFields() {
        let dto = ArticleDTO.fixture
        let article = dto.toDomain()

        #expect(article.id == dto.id)
        #expect(article.title == dto.title)
        #expect(article.source == dto.source)
        #expect(article.author == dto.author)
        #expect(article.publishedAt == dto.publishedAt)
        #expect(article.category == .technology)
        #expect(article.summary == dto.summary)
        #expect(article.content == dto.content)
        #expect(article.readTimeMinutes == dto.readTimeMinutes)
        #expect(article.reliabilityScore == dto.reliabilityScore)
    }

    @Test("toDomain falls back to .technology for unknown category")
    func toDomainFallsBackForUnknownCategory() {
        let dto = ArticleDTO(
            id: "x",
            title: "",
            source: "",
            author: "",
            publishedAt: .now,
            categoryRaw: "UnknownCategory",
            summary: "",
            content: "",
            readTimeMinutes: 0,
            reliabilityScore: 0
        )

        #expect(dto.toDomain().category == .technology)
    }

    @Test("toDomain maps each known category correctly", arguments: ArticleCategory.allCases)
    func toDomainMapsKnownCategories(category: ArticleCategory) {
        let dto = ArticleDTO(
            id: "x",
            title: "",
            source: "",
            author: "",
            publishedAt: .now,
            categoryRaw: category.rawValue,
            summary: "",
            content: "",
            readTimeMinutes: 0,
            reliabilityScore: 0
        )

        #expect(dto.toDomain().category == category)
    }
}
