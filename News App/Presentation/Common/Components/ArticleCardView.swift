import SwiftUI

// MARK: - Article Card (Oigetit style)

struct ArticleCardView: View {
    let article: Article

    private var relativeDate: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: article.publishedAt, relativeTo: .now)
    }

    /// Positive sentiment when reliability ≥ 75 (matches Oigetit behaviour in screenshot)
    private var isPositiveSentiment: Bool { article.reliabilityScore >= 75 }

    var body: some View {
        VStack(spacing: 0) {
            mainContentRow
            Divider()
                .padding(.horizontal, Spacing.sm)
            sentimentRow
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color(.systemGray4), lineWidth: 0.5)
        )
        .shadow(color: .black.opacity(0.07), radius: 6, x: 0, y: 2)
    }

    // MARK: - Main Content Row

    private var mainContentRow: some View {
        HStack(alignment: .top, spacing: 0) {
            leftColumn
            articleImage
                .frame(width: 130)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top, Spacing.md)
                .padding(.trailing, Spacing.md)
                .padding(.bottom, Spacing.md)
        }
    }

    private var leftColumn: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            reliabilityBadge

            Text(article.title)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.primary)
                .lineLimit(3)
                .fixedSize(horizontal: false, vertical: true)

            Spacer(minLength: Spacing.xs)

            HStack(spacing: 4) {
                Text(article.source)
                    .lineLimit(1)
                Text("•")
                Text(relativeDate)
            }
            .font(.caption2)
            .foregroundStyle(.secondary)
        }
        .padding(Spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - Reliability Badge

    private var reliabilityBadge: some View {
        HStack(alignment: .center, spacing: Spacing.xs) {
            ZStack {
                Image(systemName: "shield.fill")
                    .font(.system(size: 32))
                    .foregroundStyle(article.reliabilityColor)
                Image(systemName: "checkmark")
                    .font(.system(size: 10, weight: .heavy))
                    .foregroundStyle(.white)
                    .offset(y: 1)
            }

            VStack(alignment: .leading, spacing: 0) {
                Text("\(article.reliabilityScore)%")
                    .font(.system(size: 22, weight: .heavy))
                    .foregroundStyle(article.reliabilityColor)
                Text("Reliability Score")
                    .font(.system(size: 10))
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
        }
    }

    // MARK: - Article Image Placeholder

    @ViewBuilder
    private var articleImage: some View {
        ZStack {
            Rectangle()
                .fill(article.category.color.opacity(0.18))
            Image(systemName: article.category.iconName)
                .font(.system(size: 36))
                .foregroundStyle(article.category.color.opacity(0.55))
        }
    }

    // MARK: - Sentiment / Actions Row

    private var sentimentRow: some View {
        HStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: Spacing.sm) {
                OigetitSentimentIcon(isPositive: isPositiveSentiment)
                Text("Sentiment")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.primary)
                Image(systemName: "questionmark.circle")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            HStack(alignment: .center, spacing: Spacing.lg) {
                Image(systemName: "hand.thumbsup")
                Image(systemName: "bubble.right")
                Image(systemName: "arrowshape.turn.up.right")
                Image(systemName: "ellipsis")
            }
            .font(.system(size: 17))
            .foregroundStyle(.secondary)
        }
        .padding(.horizontal, Spacing.md)
        .padding(.vertical, 10)
    }
}

// MARK: - Sentiment Face Icon

/// Draws a smiley or frown face to match Oigetit's sentiment indicator
struct OigetitSentimentIcon: View {
    let isPositive: Bool

    private var faceColor: Color {
        isPositive ? OigetitTheme.reliabilityGreen : OigetitTheme.reliabilityRed
    }

    var body: some View {
        Canvas { context, size in
            let w = size.width
            let h = size.height
            let cx = w / 2
            let cy = h / 2

            // Outer circle
            let circleRect = CGRect(x: 1, y: 1, width: w - 2, height: h - 2)
            var circlePath = Path()
            circlePath.addEllipse(in: circleRect)
            context.stroke(circlePath, with: .color(faceColor), lineWidth: 1.6)

            // Eyes
            let eyeY = cy - h * 0.14
            let eyeR: CGFloat = 1.6
            for xOff in [-w * 0.18, w * 0.18] {
                var eye = Path()
                eye.addEllipse(in: CGRect(
                    x: cx + xOff - eyeR,
                    y: eyeY - eyeR,
                    width: eyeR * 2,
                    height: eyeR * 2
                ))
                context.fill(eye, with: .color(faceColor))
            }

            // Mouth
            let mouthMidY = cy + h * 0.2
            let mouthHalfW = w * 0.28
            var mouth = Path()

            if isPositive {
                // Smile: arc curving downward (happy)
                mouth.move(to: CGPoint(x: cx - mouthHalfW, y: mouthMidY - h * 0.05))
                mouth.addQuadCurve(
                    to: CGPoint(x: cx + mouthHalfW, y: mouthMidY - h * 0.05),
                    control: CGPoint(x: cx, y: mouthMidY + h * 0.18)
                )
            } else {
                // Frown: arc curving upward (sad)
                mouth.move(to: CGPoint(x: cx - mouthHalfW, y: mouthMidY + h * 0.05))
                mouth.addQuadCurve(
                    to: CGPoint(x: cx + mouthHalfW, y: mouthMidY + h * 0.05),
                    control: CGPoint(x: cx, y: mouthMidY - h * 0.14)
                )
            }
            context.stroke(mouth, with: .color(faceColor), lineWidth: 1.6)
        }
        .frame(width: 16, height: 16)
    }
}

// MARK: - Previews

#Preview("Article") {
    ArticleCardView(article: .mock)
        .padding()
}

#Preview("Low Reliability Article") {
    ArticleCardView(article: .mockLowReliability)
        .padding()
}
