import CoreFoundation
import SwiftUI

/// Single source of truth for all layout spacing in the app.
/// Values follow an even-number, base-4 scale.
enum Spacing {
    /// 2pt — hairline gaps, divider insets
    static let xxs: CGFloat = 2
    /// 4pt — tight inline gaps (icon + label, badge padding)
    static let xs: CGFloat = 4
    /// 8pt — default inner padding, small card gaps
    static let sm: CGFloat = 8
    /// 12pt — card internal padding, chip horizontal padding
    static let md: CGFloat = 12
    /// 16pt — standard section padding, default screen margin
    static let lg: CGFloat = 16
    /// 20pt — content section spacing, hero insets
    static let xl: CGFloat = 20
    /// 24pt — large section gaps
    static let xxl: CGFloat = 24
    /// 32pt — between major layout blocks
    static let xxxl: CGFloat = 32
    /// 40pt — screen-level bottom padding
    static let huge: CGFloat = 40
    /// 48pt — extra-large decorative gaps
    static let massive: CGFloat = 48

    static let allCases: [(name: String, value: CGFloat)] = [
        ("xxs", xxs),
        ("xs", xs),
        ("sm", sm),
        ("md", md),
        ("lg", lg),
        ("xl", xl),
        ("xxl", xxl),
        ("xxxl", xxxl),
        ("huge", huge),
        ("massive", massive)
    ]
}

#Preview("Spacing Design System") {
    ScrollView {
        VStack(alignment: .leading, spacing: Spacing.lg) {
            Text("Spacing Scale")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal, Spacing.lg)

            ForEach(Spacing.allCases, id: \.name) { token in
                HStack(spacing: Spacing.md) {
                    // Token name + pt value
                    VStack(alignment: .leading, spacing: Spacing.xxs) {
                        Text(".\(token.name)")
                            .font(.system(.caption, design: .monospaced))
                            .fontWeight(.semibold)
                        Text("\(Int(token.value))pt")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    .frame(width: 64, alignment: .leading)

                    // Visual bar
                    Rectangle()
                        .fill(Color.accentColor)
                        .frame(width: token.value, height: Spacing.lg)
                        .clipShape(RoundedRectangle(cornerRadius: Spacing.xxs))

                    Spacer()
                }
                .padding(.horizontal, Spacing.lg)
            }
        }
        .padding(.vertical, Spacing.lg)
    }
}
