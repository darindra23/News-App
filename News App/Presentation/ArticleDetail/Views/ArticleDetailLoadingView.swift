import SwiftUI

struct ArticleDetailLoadingView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Hero image skeleton
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color(.systemFill))
                        .frame(maxWidth: .infinity)
                        .frame(height: 220)
                        .shimmer()

                    // Body skeleton
                    VStack(alignment: .leading, spacing: Spacing.lg) {
                        VStack(alignment: .leading, spacing: Spacing.sm) {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(.systemFill))
                                .frame(height: 22)
                                .shimmer()
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(.systemFill))
                                .frame(width: 220, height: 22)
                                .shimmer()
                        }

                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color(.systemFill))
                            .frame(width: 140, height: 12)
                            .shimmer()

                        Divider()

                        VStack(alignment: .leading, spacing: Spacing.sm) {
                            ForEach(0 ..< 12, id: \.self) { i in
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(Color(.systemFill))
                                    .frame(maxWidth: i % 5 == 4 ? 180 : .infinity)
                                    .frame(height: 14)
                                    .shimmer()
                            }
                        }
                    }
                    .padding(.horizontal, Spacing.lg)
                    .padding(.top, Spacing.lg)
                    .padding(.bottom, 100)
                }
            }
            .background(Color(.systemBackground))
            .safeAreaInset(edge: .top, spacing: 0) {
                // Reliability + Sentiment row skeleton (pinned)
                HStack {
                    HStack(spacing: Spacing.xs) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color(.systemFill))
                            .frame(width: 28, height: 28)
                            .shimmer()
                        VStack(alignment: .leading, spacing: 3) {
                            RoundedRectangle(cornerRadius: 3)
                                .fill(Color(.systemFill))
                                .frame(width: 44, height: 14)
                                .shimmer()
                            RoundedRectangle(cornerRadius: 3)
                                .fill(Color(.systemFill))
                                .frame(width: 72, height: 10)
                                .shimmer()
                        }
                    }
                    Spacer()
                    HStack(spacing: Spacing.xs) {
                        Circle()
                            .fill(Color(.systemFill))
                            .frame(width: 18, height: 18)
                            .shimmer()
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color(.systemFill))
                            .frame(width: 60, height: 14)
                            .shimmer()
                    }
                }
                .padding(.horizontal, Spacing.lg)
                .padding(.vertical, Spacing.md)
                .background(Color(.systemBackground))
                .overlay(alignment: .bottom) { Divider() }
            }
            .allowsHitTesting(false)

            // Bottom bar skeleton
            HStack {
                ForEach(0 ..< 4, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(.systemFill))
                        .frame(width: 24, height: 24)
                        .shimmer()
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.vertical, Spacing.md)
            .background(Color(.systemBackground))
        }
        .ignoresSafeArea(.container, edges: .bottom)
    }
}

#Preview("ArticleDetailLoadingView") {
    ArticleDetailLoadingView()
}
