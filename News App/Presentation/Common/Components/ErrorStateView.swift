import SwiftUI

struct ErrorStateView: View {
    let message: String
    let onRetry: () async -> Void

    var body: some View {
        ContentUnavailableView {
            Label("Couldn't Load News", systemImage: "wifi.exclamationmark")
        } description: {
            Text(message)
        } actions: {
            Button {
                Task { await onRetry() }
            } label: {
                Label("Try Again", systemImage: "arrow.clockwise")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview("ErrorStateView") {
    ErrorStateView(message: "The network connection was lost. Please check your internet connection and try again.") { }
}
