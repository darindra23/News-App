import SwiftUI

struct ArticleDetailView: View {
    @State
    var viewModel: ArticleDetailViewModel

    var body: some View {
        Group {
            switch viewModel.state {
            case .idle,
                 .loading:
                ArticleDetailLoadingView()
            case let .success(article):
                ArticleDetailContentView(article: article, viewModel: viewModel)
            case let .failure(message):
                ErrorStateView(message: message) { await viewModel.retry() }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task { await viewModel.loadArticle() }
    }
}

#Preview("ArticleDetailView - Success") {
    NavigationStack {
        ArticleDetailView(viewModel: .mock)
    }
}

#Preview("ArticleDetailView - Loading") {
    NavigationStack {
        ArticleDetailLoadingView()
            .navigationBarTitleDisplayMode(.inline)
    }
}
