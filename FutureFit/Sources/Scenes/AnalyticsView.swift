import SwiftUI

struct AnalyticsView: View {
    @EnvironmentObject var viewModel: AnalyticsViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                riskHeader
                TrendChartCard(title: "HRV vs Load", data: viewModel.model.hrvLoad)
                TrendChartCard(title: "Fatigue", data: viewModel.model.fatigueTrend, color: .orange)
                BarChartCard(title: "Weekly Load", data: viewModel.model.loadBars, color: .purple)
                VStack(alignment: .leading, spacing: 8) {
                    Text("Insights")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.secondary)
                    ForEach(viewModel.model.insights) { insight in
                        InsightCard(insight: insight)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("AI Analytics")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Picker("Range", selection: $viewModel.selectedRange) {
                    ForEach(AnalyticsViewModel.RangeType.allCases) { range in
                        Text(range.rawValue.capitalized).tag(range)
                    }
                }
                .pickerStyle(.segmented)
                Picker("Sport", selection: $viewModel.sport) {
                    ForEach(AnalyticsViewModel.Sport.allCases) { sport in
                        Text(sport.label).tag(sport)
                    }
                }
                .pickerStyle(.menu)
            }
        }
    }

    private var riskHeader: some View {
        Grid(horizontalSpacing: 12, verticalSpacing: 12) {
            GridRow {
                GaugeCard(metric: viewModel.model.recovery)
                GaugeCard(metric: viewModel.model.fatigue)
            }
            GridRow {
                GaugeCard(metric: viewModel.model.overload)
                GaugeCard(metric: viewModel.model.injury)
            }
        }
    }
}
