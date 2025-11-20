import SwiftUI

extension Color {
    static let accent = Color(red: 0/255, green: 240/255, blue: 168/255)
    static let panel = Color(.secondarySystemBackground)
    static let surface = Color(.systemBackground)
}

extension LinearGradient {
    static var hero: LinearGradient {
        LinearGradient(colors: [.accent.opacity(0.4), .accent.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
