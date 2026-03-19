# Shady

A personal iOS playground for learning and experimenting with Metal shaders in a SwiftUI app.

## Overview

Shady is a sandbox project for exploring GPU-side graphics programming on Apple platforms. It pairs SwiftUI views with substantive Metal files to produce elementary real-time visuals.

## Shaders

| File | Description |
|---|---|
| `Vignette.metal` | Radial vignette effect available as both a SwiftUI **stitchable** color effect and a standalone fullscreen-triangle render pass with configurable center, radius, feather, and aspect correction. |
| `HelloTriangle.metal` | Minimal vertex + fragment pipeline that renders a triangle with a UV-gradient color output — a classic "Hello, World!" for Metal. |
| `Spectrogram.metal` | Fullscreen-triangle pass that samples a scrolling 2D spectrogram texture, mapping intensity to grayscale. Uses a circular-buffer head offset for real-time scrolling. |

## Swift Side

| File | Role |
|---|---|
| `ShadyApp.swift` | App entry point (`@main`). Launches a `WindowGroup` containing `VignetteView`. |
| `VignetteView.swift` | Demonstrates the stitchable vignette shader via a `ViewModifier` and a convenience `.vignette()` modifier on `View`. |
| `ContentView.swift` | Default SwiftUI starter view (template). |

## License

This is a personal learning project. No license is currently specified.
