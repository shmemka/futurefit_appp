import Foundation
import CoreLocation

@MainActor
final class SessionViewModel: ObservableObject {
    @Published var state: SessionState = .idle
    @Published var metrics: LiveMetrics = .mock
    @Published var isLocked: Bool = false
    @Published var autoLapEnabled: Bool = true

    private var timer: Timer?

    func toggleSession() {
        switch state {
        case .idle, .completed:
            start()
        case .active:
            pause()
        case .paused:
            resume()
        }
    }

    func stop() {
        timer?.invalidate()
        state = .completed
    }

    func start() {
        metrics = .mock
        state = .active
        startTimer()
    }

    func pause() {
        timer?.invalidate()
        state = .paused
    }

    func resume() {
        startTimer()
        state = .active
    }

    func toggleAutoLap() {
        autoLapEnabled.toggle()
    }

    func toggleLock() {
        isLocked.toggle()
    }

    func addMarker() {
        // Hook for future marker placement
    }

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else { return }
            metrics.elapsed += 1
            metrics.heartRate = Int.random(in: 120...168)
            metrics.speed = Double.random(in: 3.2...5.6)
            metrics.load = Int.random(in: 60...90)
            metrics.cadence = Int.random(in: 162...178)
        }
    }
}

@MainActor
final class DeviceViewModel: ObservableObject {
    @Published var sensors: [Sensor] = Sensor.mock
    @Published var isScanning = false

    func toggleConnection(for sensor: Sensor) {
        guard let index = sensors.firstIndex(where: { $0.id == sensor.id }) else { return }
        sensors[index].isConnected.toggle()
    }

    func startScan() {
        isScanning = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) { [weak self] in
            self?.isScanning = false
        }
    }

    func calibrate(_ sensor: Sensor) {
        guard let index = sensors.firstIndex(where: { $0.id == sensor.id }) else { return }
        sensors[index].calibration = .calibrating
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { [weak self] in
            guard let self else { return }
            sensors[index].calibration = .ready
        }
    }
}

@MainActor
final class AnalyticsViewModel: ObservableObject {
    @Published var model: AnalyticsModel = .mock
    @Published var selectedRange: RangeType = .week
    @Published var sport: Sport = .running

    enum RangeType: String, CaseIterable, Identifiable {
        case day, week, month
        var id: String { rawValue }
    }

    enum Sport: String, CaseIterable, Identifiable {
        case running, cycling, strength
        var id: String { rawValue }
        var label: String {
            switch self {
            case .running: return "Run"
            case .cycling: return "Bike"
            case .strength: return "Strength"
            }
        }
    }
}
