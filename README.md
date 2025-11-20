# Future Fit iOS App

A SwiftUI, dark-themed phygital sports analytics experience for Future Fit sensors. The project targets iOS 18 (Swift 6), embraces native controls, and ships with mock data so the UI runs in the simulator without hardware.

## Features
- **Training:** Start/pause/resume/stop controls with haptics, live HR/speed/load/cadence tiles, elapsed timer, and a MapKit heatmap preview of the route.
- **Devices:** Manage Future Fit Core and foot pods with connection toggles, pairing scan state, firmware/battery/RSSI display, and calibration triggers.
- **AI Analytics:** Recovery/fatigue/overload/injury gauges, HRV vs load and fatigue trend line charts, weekly load bar chart, and inline insights.
- **Profile:** Units, notifications, and account/HealthKit placeholders for expansion.

## Project Structure
```
FutureFit/
├─ Sources/
│  ├─ FutureFitApp.swift        # App entry + tab navigation
│  ├─ Extensions/               # Theme colors, haptics helper
│  ├─ Models/                   # Session, device, analytics data models
│  ├─ Services/                 # ObservableObject view models with mock data
│  ├─ Components/               # Reusable SwiftUI cards, tiles, controls
│  └─ Scenes/                   # Training, Devices, Analytics, Profile screens
└─ Resources/                   # Placeholder for assets
```

## Running
1. Open the folder in Xcode 16+ on macOS with iOS 18 SDK installed.
2. Create a new iOS App target named **FutureFit** pointing at the `FutureFit` folder as the source root (or add these files to an existing SwiftUI target).
3. Ensure the deployment target is iOS 17+ and **Enable MapKit/Charts** frameworks.
4. Run the app in the simulator. Mock data will animate live metrics without physical sensors.

## Notes
- The UI is dark by default and uses `.tint(.accent)` where `accent` is an electric teal brand color.
- Haptic feedback routes through the `Haptics` helper (UIImpact/UIFeedback generators).
- `SessionViewModel` drives a timer that randomly mutates metrics to simulate a live workout feed.
- `DeviceViewModel` mocks scan and calibration flows with short delays; replace with real Bluetooth/ULP sensor logic when available.
