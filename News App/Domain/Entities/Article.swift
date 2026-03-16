import SwiftUI

// MARK: - Article Category

enum ArticleCategory: String, CaseIterable, Identifiable {
    case technology = "Technology"
    case politics = "Politics"
    case sports = "Sports"
    case business = "Business"
    case health = "Health"
    case science = "Science"
    case entertainment = "Entertainment"

    var id: String { rawValue }

    var iconName: String {
        switch self {
        case .technology: return "cpu.fill"
        case .politics: return "building.columns.fill"
        case .sports: return "figure.run"
        case .business: return "chart.line.uptrend.xyaxis"
        case .health: return "heart.fill"
        case .science: return "atom"
        case .entertainment: return "film.fill"
        }
    }

    /// Oigetit-style display name used in the category filter bar
    var displayName: String {
        switch self {
        case .technology: return "A.I. News"
        case .politics: return "Politics"
        case .sports: return "Sports"
        case .business: return "Business"
        case .health: return "Health"
        case .science: return "Science"
        case .entertainment: return "Entertainment"
        }
    }

    var color: Color {
        switch self {
        case .technology: return Color(red: 0.23, green: 0.51, blue: 0.97)
        case .politics: return Color(red: 0.93, green: 0.27, blue: 0.27)
        case .sports: return Color(red: 0.07, green: 0.72, blue: 0.51)
        case .business: return Color(red: 0.97, green: 0.62, blue: 0.07)
        case .health: return Color(red: 0.93, green: 0.29, blue: 0.59)
        case .science: return Color(red: 0.55, green: 0.36, blue: 0.97)
        case .entertainment: return Color(red: 0.97, green: 0.40, blue: 0.13)
        }
    }
}

// MARK: - Article Entity

struct Article: Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let source: String
    let author: String
    let publishedAt: Date
    let category: ArticleCategory
    let summary: String
    let content: String
    let readTimeMinutes: Int
    /// Oigetit-inspired reliability score: 0–100
    let reliabilityScore: Int

    var reliabilityLabel: String {
        switch reliabilityScore {
        case 80 ... 100: return "Highly Reliable"
        case 60 ..< 80: return "Reliable"
        case 40 ..< 60: return "Moderate"
        case 20 ..< 40: return "Low Reliability"
        default: return "Unverified"
        }
    }

    var reliabilityColor: Color {
        switch reliabilityScore {
        case 60 ... 100: return OigetitTheme.reliabilityGreen
        case 40 ..< 60: return OigetitTheme.reliabilityOrange
        default: return OigetitTheme.reliabilityRed
        }
    }
}
