import SwiftUI

struct AppNavigationStack: View {
    @State
    private var router = AppRouter()
    private let appDependencies = AppDependencies.shared

    var body: some View {
        NavigationStack(path: $router.path) {
            NewsListView(viewModel: appDependencies.makeNewsListViewModel())
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case let .articleDetail(articleId):
                        ArticleDetailView(
                            viewModel: appDependencies.makeArticleDetailViewModel(articleId: articleId)
                        )
                    }
                }
        }
        .environment(router)
    }
}
