import SwiftUI

struct ArticleCardView: View {
    let article: Article

    private var relativeDate: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: article.publishedAt, relativeTo: .now)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xxs) {
            HStack(alignment: .top, spacing: Spacing.md) {
                // Category icon panel
                ZStack {
                    RoundedRectangle(cornerRadius: Spacing.md)
                        .fill(article.category.color.opacity(0.12))
                        .frame(width: 56, height: 56)
                    Image(systemName: article.category.iconName)
                        .font(.title3)
                        .foregroundStyle(article.category.color)
                }

                // Text content
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    CategoryBadge(category: article.category)

                    Text(article.title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)

                    Text(article.summary)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
            }
            .padding(.horizontal, Spacing.lg)
            .padding(.top, Spacing.lg)

            // Footer
            HStack(spacing: Spacing.xxs) {
                // Source
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "newspaper.fill")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    Text(article.source)
                        .font(.caption2)
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                // Meta row
                HStack(spacing: Spacing.sm) {
                    HStack(spacing: Spacing.xs) {
                        Image(systemName: "clock")
                            .font(.caption2)
                        Text("\(article.readTimeMinutes) min")
                            .font(.caption2)
                    }
                    .foregroundStyle(.secondary)

                    Text("·")
                        .font(.caption2)
                        .foregroundStyle(.secondary)

                    Text(relativeDate)
                        .font(.caption2)
                        .foregroundStyle(.secondary)

                    if article.isTrending {
                        HStack(spacing: Spacing.xs) {
                            Image(systemName: "flame.fill")
                            Text("Hot")
                        }
                        .font(.caption2)
                        .fontWeight(.medium)
                        .foregroundStyle(.orange)
                    }
                }
            }
            .padding(.horizontal, Spacing.lg)
            .padding(.vertical, Spacing.sm)

            // Reliability bar
            GeometryReader { geo in
                HStack(spacing: Spacing.xxs) {
                    Rectangle()
                        .fill(article.reliabilityColor)
                        .frame(width: geo.size.width * CGFloat(article.reliabilityScore) / 100)
                    Rectangle()
                        .fill(Color(.systemFill))
                }
            }
            .frame(height: 3)
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: Spacing.lg))
        .shadow(color: .black.opacity(0.06), radius: Spacing.sm, x: 0, y: Spacing.xxs)
    }
}

#Preview("Trending Article") {
    ArticleCardView(article: .mock)
        .padding()
}

#Preview("Low Reliability Article") {
    ArticleCardView(article: .mockLowReliability)
        .padding()
}
