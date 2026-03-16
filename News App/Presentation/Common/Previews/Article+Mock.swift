#if DEBUG
import Foundation

// MARK: - Mock Use Case

private struct MockFetchArticleDetailUseCase: FetchArticleDetailUseCaseProtocol {
    func execute(articleId: String) async throws -> Article { .mock }
}

// MARK: - Mock ViewModels

extension ArticleDetailViewModel {
    static let mock = ArticleDetailViewModel(
        articleId: Article.mock.id,
        fetchArticleDetailUseCase: MockFetchArticleDetailUseCase()
    )
}

// MARK: - Mock Articles

extension Article {
    static let mock = Article(
        id: "preview-1",
        title: "SwiftUI's New Features in iOS 26 Are Changing How We Build Apps",
        source: "TechCrunch",
        author: "Jane Doe",
        publishedAt: Date().addingTimeInterval(-3600),
        category: .technology,
        summary: "Apple's latest SwiftUI update introduces liquid glass effects, improved navigation APIs, and a revamped animation system that makes building beautiful apps easier than ever.",
        content: "SwiftUI continues to evolve rapidly.\n\nThe latest release introduces several groundbreaking APIs including native liquid glass materials, a more powerful NavigationStack, and Observable macro support.\n\nDevelopers are already praising the improvements.",
        readTimeMinutes: 4,
        reliabilityScore: 87
    )

    static let mockLowReliability = Article(
        id: "preview-2",
        title: "Controversial Study Claims Coffee Cures All Disease",
        source: "Daily Buzz",
        author: "Unknown",
        publishedAt: Date().addingTimeInterval(-7200),
        category: .health,
        summary: "A viral study making rounds on social media claims that drinking five cups of coffee a day eliminates all risk of chronic disease.",
        content: "Health experts are skeptical of the claims.\n\nThe study, published on an unverified blog, has not undergone peer review.",
        readTimeMinutes: 2,
        reliabilityScore: 21
    )
}
#endif
