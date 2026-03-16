import SwiftUI

struct NewsListView: View {
    @State
    var viewModel: NewsListViewModel

    @AppStorage("isDarkMode")
    private var isDarkMode = false

    var body: some View {
        Group {
            switch viewModel.state {
            case .idle, .loading:
                NewsListLoadingView()
            case .success:
                NewsListContentView(viewModel: viewModel)
            case let .failure(message):
                ErrorStateView(message: message) {
                    await viewModel.retry()
                }
            }
        }
        .safeAreaInset(edge: .top) {
            VStack(spacing: 0) {
                OigetitSearchBar(text: Bindable(viewModel).searchText)
                    .padding(.horizontal, Spacing.lg)
                    .padding(.vertical, Spacing.sm)
                    .background(OigetitTheme.primaryBlue)

                CategoryFilterBarView(viewModel: viewModel)
            }
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack(alignment: .center, spacing: Spacing.xs) {
                    Button {} label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(.white)
                    }

                    Button {
                        isDarkMode.toggle()
                    } label: {
                        Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                            .font(.system(size: 14))
                            .foregroundStyle(.white)
                    }
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                HStack(alignment: .center, spacing: Spacing.sm) {
                    HStack(spacing: 3) {
                        Image(systemName: "globe.americas.fill")
                            .font(.system(size: 12))
                        Text("Global")
                            .font(.system(size: 12, weight: .medium))
                        Image(systemName: "chevron.down")
                            .font(.system(size: 9))
                    }
                    .foregroundStyle(.white)

                    Image(systemName: "person.circle")
                        .font(.system(size: 16))
                        .foregroundStyle(.white)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                OigetitLogoView()
            }
        }
        .toolbarBackground(OigetitTheme.primaryBlue, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .task { await viewModel.loadArticles() }
    }
}

// MARK: - Oigetit Logo

struct OigetitLogoView: View {
    var subtitle: String = "Fake News Filter"

    var body: some View {
        VStack(spacing: .zero) {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(height: 24)
            Text(subtitle)
                .font(.system(size: 10, weight: .regular))
                .foregroundStyle(.white)
        }
    }
}

// MARK: - Custom Search Bar

struct OigetitSearchBar: View {
    @Binding
    var text: String

    var body: some View {
        HStack(alignment: .center, spacing: Spacing.sm) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(OigetitTheme.reliabilityRed)
                .font(.system(size: 16))

            TextField(
                text: $text,
                prompt: Text("What News are you looking for?")
                    .foregroundColor(Color(.placeholderText))
            ) { EmptyView() }
                .font(.system(size: 15))
                .foregroundStyle(.primary)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)

            Button { text = "" } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(.secondary)
            }
            .opacity(text.isEmpty ? 0 : 1)
            .allowsHitTesting(!text.isEmpty)
        }
        .padding(.horizontal, Spacing.md)
        .frame(height: 44)
        .background(
            Capsule()
                .fill(Color(.systemGroupedBackground))
        )
    }
}

#Preview("NewsListView") {
    NavigationStack {
        NewsListView(viewModel: AppDependencies.shared.makeNewsListViewModel())
    }
    .environment(AppRouter())
}
