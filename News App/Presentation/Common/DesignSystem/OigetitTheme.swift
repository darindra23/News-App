import SwiftUI

// MARK: - Oigetit Design System Colors
// Colors extracted from the Oigetit app using ColorPic

enum OigetitTheme {
    // MARK: - Brand Colors

    /// Primary Oigetit sky blue – #00ADEE
    static let primaryBlue = Color(red: 0.0, green: 0.678, blue: 0.933)

    // MARK: - Reliability Score Colors

    /// High reliability shield green (≥ 60%) – #27AE60
    static let reliabilityGreen = Color(red: 0.153, green: 0.682, blue: 0.376)

    /// Moderate reliability orange (40–59%) – #F39C12
    static let reliabilityOrange = Color(red: 0.953, green: 0.612, blue: 0.071)

    /// Low reliability red (< 40%) – #E74C3C
    static let reliabilityRed = Color(red: 0.906, green: 0.298, blue: 0.235)

    // MARK: - UI Colors

    /// Premium "P" button background – #CC1C1C
    static let premiumRed = Color(red: 0.80, green: 0.11, blue: 0.11)
}
