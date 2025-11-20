import Foundation
import SwiftUI

struct RecoveryMetric: Identifiable {
    let id = UUID()
    var title: String
    var value: Double
    var unit: String
    var trend: Double
}

struct RiskInsight: Identifiable {
    let id = UUID()
    var title: String
    var body: String
    var severity: Severity

    enum Severity: String {
        case low, medium, high

        var color: Color {
            switch self {
            case .low: return .green
            case .medium: return .yellow
            case .high: return .red
            }
        }

        var icon: String {
            switch self {
            case .low: return "checkmark.seal.fill"
            case .medium: return "exclamationmark.triangle.fill"
            case .high: return "flame.fill"
            }
        }
    }
}

struct TrendSample: Identifiable {
    let id = UUID()
    let label: String
    let value: Double
}

struct AnalyticsModel {
    var recovery: RecoveryMetric
    var fatigue: RecoveryMetric
    var overload: RecoveryMetric
    var injury: RecoveryMetric
    var hrvLoad: [TrendSample]
    var fatigueTrend: [TrendSample]
    var loadBars: [TrendSample]
    var insights: [RiskInsight]

    static let mock = AnalyticsModel(
        recovery: .init(title: "Recovery", value: 78, unit: "%", trend: 6),
        fatigue: .init(title: "Fatigue", value: 62, unit: "%", trend: -4),
        overload: .init(title: "Overload", value: 31, unit: "%", trend: -2),
        injury: .init(title: "Injury", value: 12, unit: "%", trend: -1),
        hrvLoad: [
            TrendSample(label: "Mon", value: 7.2),
            TrendSample(label: "Tue", value: 6.6),
            TrendSample(label: "Wed", value: 6.2),
            TrendSample(label: "Thu", value: 6.8),
            TrendSample(label: "Fri", value: 7.4),
            TrendSample(label: "Sat", value: 7.9),
            TrendSample(label: "Sun", value: 7.1)
        ],
        fatigueTrend: [
            TrendSample(label: "Mon", value: 62),
            TrendSample(label: "Tue", value: 66),
            TrendSample(label: "Wed", value: 70),
            TrendSample(label: "Thu", value: 63),
            TrendSample(label: "Fri", value: 58),
            TrendSample(label: "Sat", value: 55),
            TrendSample(label: "Sun", value: 60)
        ],
        loadBars: [
            TrendSample(label: "Run", value: 42),
            TrendSample(label: "Bike", value: 28),
            TrendSample(label: "Strength", value: 16),
            TrendSample(label: "Mobility", value: 12)
        ],
        insights: [
            RiskInsight(title: "Recovery trending up", body: "HRV improving and load stabilizing. Maintain current plan.", severity: .low),
            RiskInsight(title: "Fatigue cluster", body: "Acute:Chronic ratio spiked midweek; schedule lighter session tomorrow.", severity: .medium),
            RiskInsight(title: "Overload risk", body: "Two hard days in a row detected. Prioritize sleep and fueling.", severity: .high)
        ]
    )
}
