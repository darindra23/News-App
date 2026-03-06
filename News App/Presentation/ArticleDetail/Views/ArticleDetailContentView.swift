import SwiftUI

struct ArticleDetailContentView: View {
    let article: Article
    let viewModel: ArticleDetailViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.xxs) {
                heroSection
                    .padding(.bottom, Spacing.xl)

                VStack(alignment: .leading, spacing: Spacing.xl) {
                    titleSection
                    metaSection
                    ReliabilityScoreView(
                        score: article.reliabilityScore,
                        label: article.reliabilityLabel,
                        color: article.reliabilityColor
                    )
                    Divider()
                    summarySection
                    contentSection
                }
                .padding(.horizontal, Spacing.lg)
                .padding(.bottom, Spacing.huge)
            }
        }
        .background(Color(.systemBackground))
    }

    // MARK: - Hero Section

    private var heroSection: some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(
                colors: [
                    article.category.color.opacity(0.9),
                    article.category.color.opacity(0.5),
                    Color(.systemBackground)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 220)

            Image(systemName: article.category.iconName)
                .font(.system(size: 140))
                .foregroundStyle(.white.opacity(0.08))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, Spacing.xl)
                .padding(.top, Spacing.xl)
                .frame(height: 220, alignment: .top)

            HStack {
                CategoryBadge(category: article.category, style: .light)
                Spacer()
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "clock.fill")
                        .font(.caption2)
                    Text(viewModel.readTimeText)
                        .font(.caption)
                        .fontWeight(.medium)
                }
                .padding(.horizontal, Spacing.sm)
                .padding(.vertical, Spacing.xs)
                .background(.ultraThinMaterial)
                .clipShape(Capsule())
                .foregroundStyle(.white)
            }
            .padding(.horizontal, Spacing.xl)
            .padding(.bottom, Spacing.xl)
        }
    }

    // MARK: - Title Section

    private var titleSection: some View {
        Text(article.title)
            .font(.title2)
            .fontWeight(.bold)
            .foregroundStyle(.primary)
            .fixedSize(horizontal: false, vertical: true)
    }

    // MARK: - Meta Section

    private var metaSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            HStack(spacing: Spacing.sm) {
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "newspaper.fill")
                        .foregroundStyle(article.category.color)
                    Text(article.source)
                        .fontWeight(.semibold)
                }
                .font(.subheadline)

                Text("·").foregroundStyle(.secondary)

                Text(article.author)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: Spacing.xs) {
                Image(systemName: "calendar")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(viewModel.formattedDate)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("·")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(viewModel.relativeDate)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }

    // MARK: - Summary Section

    private var summarySection: some View {
        Text(article.summary)
            .font(.body)
            .fontWeight(.medium)
            .foregroundStyle(.primary)
            .italic()
            .fixedSize(horizontal: false, vertical: true)
            .padding(Spacing.md)
            .background(article.category.color.opacity(0.07))
            .clipShape(RoundedRectangle(cornerRadius: Spacing.md))
            .overlay(
                RoundedRectangle(cornerRadius: Spacing.md)
                    .stroke(article.category.color.opacity(0.25), lineWidth: 1)
            )
    }

    // MARK: - Content Section

    private var contentSection: some View {
        VStack(alignment: .leading, spacing: Spacing.lg) {
            ForEach(paragraphs, id: \.self) { paragraph in
                Text(paragraph)
                    .font(.body)
                    .foregroundStyle(.primary)
                    .lineSpacing(Spacing.xs)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    private var paragraphs: [String] {
        article.content
            .components(separatedBy: "\n\n")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }
}

#Preview("ArticleDetailContentView") {
    NavigationStack {
        ArticleDetailContentView(article: .mock, viewModel: .mock)
            .navigationBarTitleDisplayMode(.inline)
    }
}
