import SwiftUI

struct DeviceRow: View {
    var sensor: Sensor
    var action: (() -> Void)?
    var calibrate: (() -> Void)?

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: sensor.type.icon)
                .font(.title3)
                .foregroundStyle(.accent)
                .frame(width: 32)
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(sensor.name)
                        .font(.headline)
                    if sensor.isConnected {
                        Label("Connected", systemImage: "bolt.horizontal.fill")
                            .font(.caption2.weight(.semibold))
                            .foregroundStyle(.green)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 4)
                            .background(Color.green.opacity(0.12), in: Capsule())
                    } else {
                        Label("Offline", systemImage: "wifi.slash")
                            .font(.caption2.weight(.semibold))
                            .foregroundStyle(.orange)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 4)
                            .background(Color.orange.opacity(0.12), in: Capsule())
                    }
                }
                HStack(spacing: 8) {
                    Label("Battery \(sensor.battery)%", systemImage: "battery.100")
                    Label("RSSI \(sensor.rssi)dBm", systemImage: "antenna.radiowaves.left.and.right")
                }
                .font(.caption)
                .foregroundStyle(.secondary)

                Label(sensor.calibration.label, systemImage: "dot.radiowaves.left.right")
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(Color(sensor.calibration.color))
            }
            Spacer()
            Menu {
                Button(sensor.isConnected ? "Disconnect" : "Connect", systemImage: sensor.isConnected ? "xmark" : "checkmark") {
                    action?()
                }
                Button("Calibrate", systemImage: "scope") {
                    calibrate?()
                }
            } label: {
                Image(systemName: "ellipsis")
                    .font(.headline)
                    .padding(8)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
