import Foundation

enum DomainError: LocalizedError, Equatable {
    case articleNotFound
    case dataUnavailable
    case unknown(String)

    var errorDescription: String? {
        switch self {
        case .articleNotFound:
            return "The requested article could not be found."
        case .dataUnavailable:
            return "Unable to load news. Please try again."
        case let .unknown(message):
            return message
        }
    }
}
