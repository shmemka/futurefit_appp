import SwiftUI
import Charts

struct GaugeCard: View {
    var metric: RecoveryMetric

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(metric.title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)
            Gauge(value: metric.value, in: 0...100) {
                Text(metric.title)
            } currentValueLabel: {
                Text("\(Int(metric.value))\(metric.unit)")
                    .font(.title2.weight(.semibold))
            }
            .tint(.accent)
            HStack(spacing: 4) {
                Image(systemName: metric.trend >= 0 ? "arrow.up.right" : "arrow.down.right")
                Text("\(metric.trend >= 0 ? "+" : "")\(Int(metric.trend)) vs last period")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

struct InsightCard: View {
    var insight: RiskInsight

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: insight.severity.icon)
                .foregroundStyle(insight.severity.color)
                .font(.title3)
                .padding(10)
                .background(insight.severity.color.opacity(0.12), in: Circle())
            VStack(alignment: .leading, spacing: 6) {
                Text(insight.title)
                    .font(.headline)
                Text(insight.body)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

struct TrendChartCard: View {
    var title: String
    var data: [TrendSample]
    var color: Color = .accent

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)
            Chart(data) { sample in
                LineMark(
                    x: .value("Label", sample.label),
                    y: .value("Value", sample.value)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(color)
                PointMark(
                    x: .value("Label", sample.label),
                    y: .value("Value", sample.value)
                )
                .symbolSize(40)
                .foregroundStyle(color.opacity(0.8))
            }
            .chartXAxis {
                AxisMarks(position: .bottom)
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .frame(height: 180)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

struct BarChartCard: View {
    var title: String
    var data: [TrendSample]
    var color: Color = .accent

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)
            Chart(data) { sample in
                BarMark(
                    x: .value("Label", sample.label),
                    y: .value("Value", sample.value)
                )
                .foregroundStyle(color.gradient)
            }
            .frame(height: 160)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}
