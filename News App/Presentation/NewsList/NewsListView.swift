import SwiftUI

struct NewsListView: View {
    @State
    var viewModel: NewsListViewModel

    var body: some View {
        Group {
            switch viewModel.state {
            case .idle,
                 .loading:
                NewsListLoadingView()
            case .success:
                NewsListContentView(viewModel: viewModel)
            case let .failure(message):
                ErrorStateView(message: message) {
                    await viewModel.retry()
                }
            }
        }
        .navigationTitle("Oigetit News")
        .navigationBarTitleDisplayMode(.large)
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search articles, sources..."
        )
        .task { await viewModel.loadArticles() }
    }
}

#Preview("NewsListView") {
    NavigationStack {
        NewsListView(viewModel: AppDependencies.shared.makeNewsListViewModel())
    }
    .environment(AppRouter())
}
