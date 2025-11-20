import SwiftUI

struct DevicesView: View {
    @EnvironmentObject var viewModel: DeviceViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(viewModel.sensors) { sensor in
                    DeviceRow(sensor: sensor) {
                        viewModel.toggleConnection(for: sensor)
                    } calibrate: {
                        viewModel.calibrate(sensor)
                    }
                }
                scanSection
            }
            .padding()
        }
        .navigationTitle("Devices")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: viewModel.startScan) {
                    Label("Scan", systemImage: viewModel.isScanning ? "antenna.radiowaves.left.and.right" : "dot.radiowaves.left.right")
                }
            }
        }
    }

    private var scanSection: some View {
        VStack(spacing: 10) {
            HStack {
                Label(viewModel.isScanning ? "Scanning for sensors" : "Ready to pair", systemImage: viewModel.isScanning ? "antenna.radiowaves.left.and.right" : "plus")
                Spacer()
            }
            ProgressView()
                .progressViewStyle(.circular)
                .opacity(viewModel.isScanning ? 1 : 0)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
