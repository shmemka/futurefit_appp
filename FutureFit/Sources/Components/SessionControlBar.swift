import SwiftUI

struct SessionControlBar: View {
    @EnvironmentObject var viewModel: SessionViewModel

    var body: some View {
        HStack(spacing: 12) {
            Button {
                viewModel.toggleSession()
                Haptics.medium()
            } label: {
                Label(viewModel.state == .active ? "Pause" : viewModel.state == .paused ? "Resume" : "Start", systemImage: viewModel.state == .active ? "pause.fill" : "play.fill")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.accent)

            Menu {
                Button("Stop", systemImage: "stop.fill") {
                    viewModel.stop()
                    Haptics.heavy()
                }
                Button(viewModel.autoLapEnabled ? "Disable Auto-Lap" : "Enable Auto-Lap", systemImage: "flag.checkered") {
                    viewModel.toggleAutoLap()
                }
                Button(viewModel.isLocked ? "Unlock Screen" : "Lock Screen", systemImage: "lock") {
                    viewModel.toggleLock()
                }
                Button("Add Marker", systemImage: "mappin.and.ellipse") {
                    viewModel.addMarker()
                }
            } label: {
                Image(systemName: "ellipsis.circle")
                    .font(.title2)
                    .frame(width: 50, height: 50)
            }
            .buttonStyle(.bordered)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(.ultraThinMaterial)
    }
}
