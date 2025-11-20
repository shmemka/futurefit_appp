import SwiftUI

struct TrainingView: View {
    @EnvironmentObject var viewModel: SessionViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                SessionHeader(state: viewModel.state, metrics: viewModel.metrics)
                metricsGrid
                HeatmapPreview(route: viewModel.metrics.route)
            }
            .padding()
        }
        .safeAreaInset(edge: .bottom) {
            SessionControlBar()
                .environmentObject(viewModel)
                .background(.ultraThinMaterial)
        }
        .navigationTitle("Training")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.toggleLock()
                } label: {
                    Image(systemName: viewModel.isLocked ? "lock.fill" : "lock.open")
                }
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: viewModel.state)
    }

    private var metricsGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            MetricTile(title: "Heart Rate", value: "\(viewModel.metrics.heartRate)", unit: "bpm", icon: "heart.fill")
            MetricTile(title: "Speed", value: String(format: "%.1f", viewModel.metrics.speed), unit: "m/s", icon: "gauge")
            MetricTile(title: "Load", value: "\(viewModel.metrics.load)", unit: "TSS", icon: "bolt.fill")
            MetricTile(title: "Cadence", value: "\(viewModel.metrics.cadence)", unit: "spm", icon: "metronome")
        }
    }
}

struct SessionHeader: View {
    var state: SessionState
    var metrics: LiveMetrics

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Label(state.label, systemImage: icon(for: state))
                    .font(.caption.weight(.semibold))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(.thinMaterial, in: Capsule())
                Spacer()
                Text(metrics.elapsed.formattedElapsed)
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .monospacedDigit()
            }
            ProgressView(value: min(metrics.heartRate, 190), total: 190)
                .progressViewStyle(.linear)
                .tint(.accent)
            HStack {
                VStack(alignment: .leading) {
                    Text("Speed")
                        .foregroundStyle(.secondary)
                    Text("\(String(format: "%.1f", metrics.speed)) m/s")
                        .font(.title3.weight(.semibold))
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Load")
                        .foregroundStyle(.secondary)
                    Text("\(metrics.load) TSS")
                        .font(.title3.weight(.semibold))
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            LinearGradient.hero
                .blendMode(.screen)
                .background(Color.surface)
        )
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(.white.opacity(0.05), lineWidth: 1)
        )
        .shadow(color: .accent.opacity(0.15), radius: 18, y: 8)
    }

    private func icon(for state: SessionState) -> String {
        switch state {
        case .idle: return "play"
        case .active: return "pause"
        case .paused: return "playpause"
        case .completed: return "checkmark"
        }
    }
}

private extension TimeInterval {
    var formattedElapsed: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: self) ?? "00:00"
    }
}
