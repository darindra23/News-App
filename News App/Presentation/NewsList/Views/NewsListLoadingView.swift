import SwiftUI

struct NewsListLoadingView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.xl) {
                skeletonTrendingSection
                skeletonArticleList
            }
            .padding(Spacing.lg)
        }
        .allowsHitTesting(false)
    }

    private var skeletonTrendingSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            RoundedRectangle(cornerRadius: Spacing.xs)
                .fill(Color(.systemFill))
                .frame(width: 90, height: 20)
                .shimmer()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Spacing.md) {
                    ForEach(0 ..< 3, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: Spacing.lg)
                            .fill(Color(.systemFill))
                            .frame(width: 250, height: 160)
                            .shimmer()
                    }
                }
            }
        }
    }

    private var skeletonArticleList: some View {
        LazyVStack(spacing: Spacing.md) {
            ForEach(0 ..< 5, id: \.self) { _ in
                skeletonArticleCard
            }
        }
    }

    private var skeletonArticleCard: some View {
        HStack(alignment: .top, spacing: Spacing.md) {
            RoundedRectangle(cornerRadius: Spacing.md)
                .fill(Color(.systemFill))
                .frame(width: 56, height: 56)
                .shimmer()

            VStack(alignment: .leading, spacing: Spacing.sm) {
                RoundedRectangle(cornerRadius: Spacing.xs)
                    .fill(Color(.systemFill))
                    .frame(height: 12)
                    .shimmer()

                RoundedRectangle(cornerRadius: Spacing.xs)
                    .fill(Color(.systemFill))
                    .frame(height: 12)
                    .shimmer()

                RoundedRectangle(cornerRadius: Spacing.xs)
                    .fill(Color(.systemFill))
                    .frame(width: 120, height: 12)
                    .shimmer()
            }
        }
        .padding(Spacing.lg)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: Spacing.lg))
    }
}

#Preview("NewsListLoadingView") {
    NewsListLoadingView()
}
