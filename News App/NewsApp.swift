import SwiftUI

@main
struct NewsApp: App {

    init() {
        configureNavigationBarAppearance()
    }

    var body: some Scene {
        WindowGroup {
            AppNavigationStack()
        }
    }

    /// Forces a solid opaque navigation bar, overriding iOS 26's default liquid glass material.
    private func configureNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(OigetitTheme.primaryBlue)
        appearance.shadowColor = .clear

        // White title/button tint on the blue bar
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = .white
    }
}
