import SwiftUI

struct ArticleDetailContentView: View {
    let article: Article
    let viewModel: ArticleDetailViewModel

    private var isPositiveSentiment: Bool { article.reliabilityScore >= 75 }

    private var relativeDate: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: article.publishedAt, relativeTo: .now)
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    heroImage
                    articleBody
                        .padding(.bottom, 80)
                }
            }
            .background(Color(.systemBackground))
            .safeAreaInset(edge: .top, spacing: 0) {
                reliabilitySentimentRow
            }

            bottomActionBar
        }
        .ignoresSafeArea(.container, edges: .bottom)
    }

    // MARK: - Reliability + Sentiment Row (pinned)

    private var reliabilitySentimentRow: some View {
        HStack(alignment: .center) {
            HStack(spacing: Spacing.xs) {
                ZStack {
                    Image(systemName: "shield.fill")
                        .font(.system(size: 28))
                        .foregroundStyle(article.reliabilityColor)
                    Image(systemName: "checkmark")
                        .font(.system(size: 9, weight: .heavy))
                        .foregroundStyle(.white)
                        .offset(y: 1)
                }

                VStack(alignment: .leading, spacing: 0) {
                    Text("\(article.reliabilityScore)%")
                        .font(.system(size: 18, weight: .heavy))
                        .foregroundStyle(article.reliabilityColor)
                    Text("Reliability Score")
                        .font(.system(size: 9))
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()

            HStack(spacing: Spacing.xs) {
                OigetitSentimentIcon(isPositive: isPositiveSentiment)
                    .frame(width: 18, height: 18)
                Text("Sentiment")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.primary)
                Image(systemName: "questionmark.circle")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, Spacing.lg)
        .padding(.vertical, Spacing.md)
        .background(Color(.systemBackground))
        .overlay(alignment: .bottom) {
            Divider()
        }
    }

    // MARK: - Hero Image

    private var heroImage: some View {
        ZStack(alignment: .bottomTrailing) {
            ZStack {
                Rectangle()
                    .fill(article.category.color.opacity(0.18))
                Image(systemName: article.category.iconName)
                    .font(.system(size: 80))
                    .foregroundStyle(article.category.color.opacity(0.4))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 220)

            Text("© \(article.source)")
                .font(.system(size: 10))
                .foregroundStyle(.white.opacity(0.85))
                .padding(.horizontal, Spacing.xs)
                .padding(.vertical, 3)
                .background(.black.opacity(0.35))
                .padding(.trailing, Spacing.sm)
                .padding(.bottom, Spacing.sm)
        }
    }

    // MARK: - Article Body

    private var articleBody: some View {
        VStack(alignment: .leading, spacing: Spacing.lg) {
            Text(article.title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 4) {
                Text(article.source)
                    .fontWeight(.semibold)
                Text("•")
                Text(relativeDate)
            }
            .font(.caption)
            .foregroundStyle(.secondary)

            Divider()

            VStack(alignment: .leading, spacing: Spacing.lg) {
                ForEach(paragraphs, id: \.self) { paragraph in
                    Text(paragraph)
                        .font(.body)
                        .foregroundStyle(.primary)
                        .lineSpacing(4)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .padding(.horizontal, Spacing.lg)
        .padding(.top, Spacing.lg)
    }

    private var paragraphs: [String] {
        article.content
            .components(separatedBy: "\n\n")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }

    // MARK: - Bottom Action Bar

    private var bottomActionBar: some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(bottomActions, id: \.icon) { action in
                Button {
                    action.handler()
                } label: {
                    Image(systemName: action.icon)
                        .font(.system(size: 22))
                        .foregroundStyle(OigetitTheme.primaryBlue)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.top, Spacing.md)
        .padding(.bottom, Spacing.lg)
        .background(
            Color(.systemBackground)
                .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: -2)
        )
    }

    private var bottomActions: [BottomAction] {
        [
            BottomAction(icon: "hand.thumbsup") {},
            BottomAction(icon: "bubble.right") {},
            BottomAction(icon: "arrowshape.turn.up.right") {},
            BottomAction(icon: "bookmark") { viewModel.toggleBookmark() },
        ]
    }
}

private struct BottomAction {
    let icon: String
    let handler: () -> Void
}

#Preview("ArticleDetailContentView") {
    NavigationStack {
        ArticleDetailContentView(article: .mock, viewModel: .mock)
            .navigationBarTitleDisplayMode(.inline)
    }
}
