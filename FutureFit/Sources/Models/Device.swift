import Foundation

enum DeviceType: String, Identifiable, CaseIterable {
    case corePod = "Core Pod"
    case footPod = "Foot Pod"
    case chestStrap = "Chest Strap"

    var id: String { rawValue }
    var icon: String {
        switch self {
        case .corePod: return "sensor.tag.radiowaves.forward.fill"
        case .footPod: return "shoeprints.fill"
        case .chestStrap: return "waveform.path"
        }
    }
}

enum CalibrationStatus: String {
    case ready, calibrating, needsCalibration, error

    var label: String {
        switch self {
        case .ready: return "Ready"
        case .calibrating: return "Calibrating"
        case .needsCalibration: return "Needs calibration"
        case .error: return "Check device"
        }
    }

    var color: String {
        switch self {
        case .ready: return "green"
        case .calibrating: return "yellow"
        case .needsCalibration: return "orange"
        case .error: return "red"
        }
    }
}

struct Sensor: Identifiable {
    let id = UUID()
    var name: String
    var type: DeviceType
    var battery: Int
    var rssi: Int
    var firmware: String
    var calibration: CalibrationStatus
    var isConnected: Bool

    static let mock: [Sensor] = [
        Sensor(name: "Core Pod", type: .corePod, battery: 86, rssi: -45, firmware: "1.4.2", calibration: .ready, isConnected: true),
        Sensor(name: "Left Foot", type: .footPod, battery: 62, rssi: -58, firmware: "1.1.0", calibration: .needsCalibration, isConnected: true),
        Sensor(name: "Right Foot", type: .footPod, battery: 64, rssi: -60, firmware: "1.1.0", calibration: .calibrating, isConnected: false),
        Sensor(name: "Chest HR", type: .chestStrap, battery: 78, rssi: -50, firmware: "2.0.3", calibration: .ready, isConnected: true)
    ]
}
