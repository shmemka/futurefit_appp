import SwiftUI
import MapKit

struct HeatmapPreview: View {
    var route: [RoutePoint]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Heatmap Preview")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)
            ZStack {
                Map(initialPosition: .region(.defaultRegion(for: route))) {
                    ForEach(route) { point in
                        Annotation("", coordinate: point.coordinate) {
                            Circle()
                                .fill(Color.accent.opacity(point.intensity))
                                .frame(width: 14, height: 14)
                                .shadow(color: .accent.opacity(0.7), radius: 10)
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .stroke(LinearGradient.hero, lineWidth: 1)
                )

                VStack {
                    Spacer()
                    HStack {
                        Label("Live route", systemImage: "location.fill")
                        Spacer()
                        Image(systemName: "figure.run")
                    }
                    .font(.footnote.weight(.medium))
                    .padding(12)
                    .background(.thinMaterial, in: Capsule())
                    .padding()
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

private extension MKCoordinateRegion {
    static func defaultRegion(for points: [RoutePoint]) -> MKCoordinateRegion {
        guard let first = points.first?.coordinate else {
            return MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        }
        return MKCoordinateRegion(center: first, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
}
