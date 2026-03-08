import SwiftUI

extension Color {
    // MARK: - App Palette

    /// Cream background — #fefae0
    static let appBackground = Color(hex: "fefae0")

    /// Olive green — #606c38 (primary brand, navigation tint)
    static let appPrimary = Color(hex: "606c38")

    /// Deep forest green — #283618 (dark headings, strong accents)
    static let appDark = Color(hex: "283618")

    /// Sandy tan — #dda15e (stars, selected chips, highlights)
    static let appAccent = Color(hex: "dda15e")

    /// Burnt orange — #bc6c25 (prominent buttons, accent dark)
    static let appAccentDark = Color(hex: "bc6c25")

    // MARK: - Hex initialiser

    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}
