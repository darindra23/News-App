import SwiftUI

struct ArticleDetailView: View {
    @State
    var viewModel: ArticleDetailViewModel

    @AppStorage("isDarkMode")
    private var isDarkMode = false

    @Environment(\.dismiss)
    private var dismiss

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
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                }
            }

            ToolbarItem(placement: .principal) {
                OigetitLogoView(subtitle: "Your Daily Fact-checked News")
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isDarkMode.toggle()
                } label: {
                    Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                        .font(.system(size: 14))
                        .foregroundStyle(.white)
                }
            }
        }
        .toolbarBackground(OigetitTheme.primaryBlue, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
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
