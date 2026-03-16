import SwiftUI

struct NewsListLoadingView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: Spacing.md) {
                ForEach(0 ..< 6, id: \.self) { _ in
                    skeletonArticleCard
                }
            }
            .padding(.horizontal, Spacing.lg)
            .padding(.top, Spacing.md)
        }
        .background(Color(.systemGroupedBackground))
        .allowsHitTesting(false)
    }

    // MARK: - Skeleton Card (matches the Oigetit ArticleCardView layout)

    private var skeletonArticleCard: some View {
        VStack(spacing: 0) {
            // Main content row: left column + right image
            HStack(alignment: .top, spacing: 0) {
                // Left: reliability badge + title lines + source line
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    // Reliability badge skeleton
                    HStack(spacing: Spacing.xs) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color(.systemFill))
                            .frame(width: 32, height: 32)
                            .shimmer()

                        VStack(alignment: .leading, spacing: 4) {
                            RoundedRectangle(cornerRadius: 3)
                                .fill(Color(.systemFill))
                                .frame(width: 44, height: 14)
                                .shimmer()
                            RoundedRectangle(cornerRadius: 3)
                                .fill(Color(.systemFill))
                                .frame(width: 60, height: 10)
                                .shimmer()
                        }
                    }

                    // Title lines
                    VStack(alignment: .leading, spacing: Spacing.xs) {
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color(.systemFill))
                            .frame(height: 14)
                            .shimmer()
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color(.systemFill))
                            .frame(height: 14)
                            .shimmer()
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color(.systemFill))
                            .frame(width: 120, height: 14)
                            .shimmer()
                    }

                    Spacer(minLength: Spacing.xs)

                    // Source • time
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color(.systemFill))
                        .frame(width: 130, height: 10)
                        .shimmer()
                }
                .padding(Spacing.md)

                // Right: image placeholder — matches ArticleCardView (width 130,
                // rounded corners, inset with top/trailing/bottom padding)
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemFill))
                    .frame(width: 130)
                    .shimmer()
                    .padding(.top, Spacing.md)
                    .padding(.trailing, Spacing.md)
                    .padding(.bottom, Spacing.md)
            }
            .frame(minHeight: 130)

            Divider()
                .padding(.horizontal, Spacing.sm)

            // Sentiment row skeleton
            HStack {
                HStack(spacing: Spacing.xs) {
                    Circle()
                        .fill(Color(.systemFill))
                        .frame(width: 24, height: 24)
                        .shimmer()
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color(.systemFill))
                        .frame(width: 70, height: 12)
                        .shimmer()
                }
                Spacer()
                HStack(spacing: Spacing.xl) {
                    ForEach(0 ..< 4, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color(.systemFill))
                            .frame(width: 18, height: 16)
                            .shimmer()
                    }
                }
            }
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, 10)
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color(.systemGray4), lineWidth: 0.5)
        )
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 1)
    }
}

#Preview("NewsListLoadingView") {
    NewsListLoadingView()
        .padding(.top, Spacing.md)
}
