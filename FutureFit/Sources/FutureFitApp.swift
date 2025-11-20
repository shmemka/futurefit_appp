import SwiftUI

@main
struct FutureFitApp: App {
    @StateObject private var sessionViewModel = SessionViewModel()
    @StateObject private var deviceViewModel = DeviceViewModel()
    @StateObject private var analyticsViewModel = AnalyticsViewModel()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(sessionViewModel)
                .environmentObject(deviceViewModel)
                .environmentObject(analyticsViewModel)
                .preferredColorScheme(.dark)
        }
    }
}

struct RootTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                TrainingView()
            }
            .tabItem { Label("Training", systemImage: "figure.run") }

            NavigationStack {
                DevicesView()
            }
            .tabItem { Label("Devices", systemImage: "sensor.tag.radiowaves.forward.fill") }

            NavigationStack {
                AnalyticsView()
            }
            .tabItem { Label("AI", systemImage: "brain.head.profile") }

            NavigationStack {
                ProfileView()
            }
            .tabItem { Label("Profile", systemImage: "person.crop.circle") }
        }
        .tint(.accent)
    }
}
