import Foundation

enum ViewState<T> {
    case idle
    case loading
    case success(T)
    case failure(String)

    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }

    var errorMessage: String? {
        if case .failure(let message) = self { return message }
        return nil
    }

    var value: T? {
        if case .success(let value) = self { return value }
        return nil
    }
}
