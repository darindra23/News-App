import SwiftUI

struct ReliabilityScoreView: View {
    let score: Int
    let label: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            HStack {
                Image(systemName: "shield.checkered")
                    .font(.caption)
                    .foregroundStyle(color)
                Text("Source Reliability")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(label)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(color)
                Text("·")
                    .foregroundStyle(.secondary)
                Text("\(score)/100")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(color)
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color(.systemFill))
                        .frame(height: Spacing.xs)
                    Capsule()
                        .fill(color)
                        .frame(width: geo.size.width * CGFloat(score) / 100, height: Spacing.xs)
                        .animation(.spring(duration: 0.8, bounce: 0.2), value: score)
                }
            }
            .frame(height: Spacing.xs)
        }
        .padding(Spacing.md)
        .background(color.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: Spacing.md))
    }
}

#Preview("ReliabilityScoreView") {
    VStack(spacing: Spacing.md) {
        ReliabilityScoreView(score: 87, label: "Highly Reliable", color: .green)
        ReliabilityScoreView(score: 65, label: "Reliable", color: .blue)
        ReliabilityScoreView(score: 45, label: "Moderate", color: .orange)
        ReliabilityScoreView(score: 21, label: "Low Reliability", color: .red)
    }
    .padding()
}
