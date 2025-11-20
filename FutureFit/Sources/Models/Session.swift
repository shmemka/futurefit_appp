import Foundation
import CoreLocation

enum SessionState: String, CaseIterable, Identifiable {
    case idle
    case active
    case paused
    case completed

    var id: String { rawValue }
    var label: String {
        switch self {
        case .idle: return "Ready"
        case .active: return "Active"
        case .paused: return "Paused"
        case .completed: return "Completed"
        }
    }
}

struct LiveMetrics: Identifiable, Equatable {
    let id = UUID()
    var heartRate: Int
    var speed: Double
    var load: Int
    var cadence: Int
    var elapsed: TimeInterval
    var route: [RoutePoint]

    static let mock = LiveMetrics(
        heartRate: 142,
        speed: 4.3,
        load: 72,
        cadence: 168,
        elapsed: 12 * 60 + 25,
        route: RoutePoint.mockRoute
    )
}

struct RoutePoint: Identifiable, Equatable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let intensity: Double

    static let mockRoute: [RoutePoint] = [
        RoutePoint(coordinate: .init(latitude: 37.7765, longitude: -122.4167), intensity: 0.2),
        RoutePoint(coordinate: .init(latitude: 37.7772, longitude: -122.4162), intensity: 0.4),
        RoutePoint(coordinate: .init(latitude: 37.7779, longitude: -122.4157), intensity: 0.6),
        RoutePoint(coordinate: .init(latitude: 37.7786, longitude: -122.4152), intensity: 0.85),
        RoutePoint(coordinate: .init(latitude: 37.7793, longitude: -122.4147), intensity: 0.5)
    ]
}
