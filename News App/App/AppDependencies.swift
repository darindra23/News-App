import Foundation

/// Lightweight factory providing concrete implementations for the MVVM layer.
/// Each call returns a new instance — no shared mutable state.
final class AppDependencies {
    static let shared = AppDependencies()
    private init() {}

    func makeNewsListViewModel() -> NewsListViewModel {
        NewsListViewModel(
            fetchArticlesUseCase: FetchArticlesUseCase(
                repository: makeArticleRepository()
            )
        )
    }

    func makeArticleDetailViewModel(articleId: String) -> ArticleDetailViewModel {
        ArticleDetailViewModel(
            articleId: articleId,
            fetchArticleDetailUseCase: FetchArticleDetailUseCase(
                repository: makeArticleRepository()
            )
        )
    }

    private func makeArticleRepository() -> ArticleRepositoryProtocol {
        ArticleRepository(dataSource: LocalArticleDataSource())
    }
}
