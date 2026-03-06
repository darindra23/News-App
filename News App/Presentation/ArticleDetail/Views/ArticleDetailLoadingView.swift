import SwiftUI

struct ArticleDetailLoadingView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.lg) {
                RoundedRectangle(cornerRadius: Spacing.xxs)
                    .fill(Color(.systemFill))
                    .frame(maxWidth: .infinity)
                    .frame(height: 220)
                    .shimmer()

                VStack(alignment: .leading, spacing: Spacing.xl) {
                    VStack(alignment: .leading, spacing: Spacing.sm) {
                        RoundedRectangle(cornerRadius: Spacing.xs)
                            .fill(Color(.systemFill))
                            .frame(height: 28)
                            .shimmer()
                        RoundedRectangle(cornerRadius: Spacing.xs)
                            .fill(Color(.systemFill))
                            .frame(width: 200, height: 28)
                            .shimmer()
                    }

                    RoundedRectangle(cornerRadius: Spacing.md)
                        .fill(Color(.systemFill))
                        .frame(height: 60)
                        .shimmer()

                    VStack(alignment: .leading, spacing: Spacing.sm) {
                        ForEach(0 ..< 10, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: Spacing.xs)
                                .fill(Color(.systemFill))
                                .frame(height: 14)
                                .shimmer()
                        }
                    }
                }
                .padding(.horizontal, Spacing.lg)
                .padding(.bottom, Spacing.huge)
            }
        }
        .allowsHitTesting(false)
    }
}

#Preview("ArticleDetailLoadingView") {
    ArticleDetailLoadingView()
}
