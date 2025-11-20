import SwiftUI

struct ProfileView: View {
    @State private var notifications = true
    @State private var units: Units = .metric

    var body: some View {
        Form {
            Section("Preferences") {
                Picker("Units", selection: $units) {
                    ForEach(Units.allCases) { unit in
                        Text(unit.rawValue.capitalized).tag(unit)
                    }
                }
                Toggle("Notifications", isOn: $notifications)
                NavigationLink("Data Export") { Text("Export options coming soon") }
                NavigationLink("Privacy") { Text("Manage Health and location access") }
            }

            Section("Account") {
                NavigationLink("Apple Health") { Text("Connect to Apple Health") }
                Button("Sign Out", role: .destructive) { }
            }
        }
        .navigationTitle("Profile")
    }
}

enum Units: String, CaseIterable, Identifiable {
    case metric, imperial
    var id: String { rawValue }
}
