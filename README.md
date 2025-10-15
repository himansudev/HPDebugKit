# HPDebugKit

A comprehensive debugging toolkit for iOS developers that simplifies development workflows and provides essential debugging utilities.

## Overview

HPDebugKit is designed to make iOS development easier by providing developers with powerful debugging tools and utilities. The package offers a unified interface for common debugging tasks, file management, data persistence, and development-specific features.

## Features

### 🔧 Core Debugging Tools
- **Version Information**: Easy access to app version, build number, and debug information
- **Settings UI**: Built-in SwiftUI interface for package configuration

### 🌐 Local Server (Coming Soon)
- **Response Caching**: Save server responses locally for offline development
- **Mock Server**: Run your app using cached responses without network dependency
- **Development Testing**: Test your app's behavior with different server responses

### 📱 Developer-Friendly UI
- **HPSettingsView**: SwiftUI-based settings screen for package configuration
- **Easy Integration**: Simple to integrate into your existing app
- **Clean API**: Minimal public interface focused on developer needs

## Installation

### Swift Package Manager

Add HPDebugKit to your project using Swift Package Manager:

1. In Xcode, go to **File → Add Package Dependencies**
2. Enter the repository URL: `https://github.com/yourusername/HPDebugKit.git`
3. Select the version and add to your target

### Package.swift

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/HPDebugKit.git", from: "1.0.0")
]
```

## Requirements

- iOS 16.0+
- Swift 5.9+
- Xcode 15.0+

## Quick Start

### 1. Import the Package

```swift
import HPDebugKit
import SwiftUI
```

### 2. Access Version Information

```swift
let debugKit = HPDebugKit.shared

// Get version information
let version = debugKit.getVersion()
let fullVersion = debugKit.getFullVersion()
let buildNumber = debugKit.getBuildNumber()

// Get comprehensive debug info
let debugInfo = debugKit.getDebugInfo()
print(debugInfo)
```

### 3. Present Settings Screen

```swift
struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("My App")
                
                Button("Open Debug Settings") {
                    showSettings = true
                }
            }
        }
        .sheet(isPresented: $showSettings) {
            HPSettingsView()
        }
    }
    
    @State private var showSettings = false
}
```

## Detailed Usage

### Core API

HPDebugKit provides a clean, minimal API focused on developer needs:

```swift
// Get version information
let debugKit = HPDebugKit.shared
let version = debugKit.getVersion()
let fullVersion = debugKit.getFullVersion()
let buildNumber = debugKit.getBuildNumber()

// Get comprehensive debug info
let debugInfo = debugKit.getDebugInfo()
print(debugInfo)
```

### Internal Implementation

HPDebugKit uses internal utilities for file management and data persistence, but these are not exposed in the public API to keep the interface clean and focused. The package handles all the complexity internally while providing a simple interface for developers.

### Settings Screen Integration

The `HPSettingsView` provides a built-in settings interface for your debug package:

```swift
// Present as sheet
.sheet(isPresented: $showSettings) {
    HPSettingsView()
}

// Present as navigation destination
NavigationLink("Debug Settings") {
    HPSettingsView()
}

// Present as full screen cover
.fullScreenCover(isPresented: $showSettings) {
    NavigationView {
        HPSettingsView()
            .navigationTitle("Debug Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        showSettings = false
                    }
                }
            }
    }
}
```

## Internal Architecture

HPDebugKit is built with a clean architecture that separates public API from internal implementation:

- **Public Interface**: Only `HPDebugKit` and `HPSettingsView` are exposed to host apps
- **Internal Implementation**: File management, UserDefaults, and other utilities are internal
- **Future-Ready**: Designed to easily add new features without breaking existing API

## Debug Information

Get comprehensive debug information about your app:

```swift
let debugInfo = HPDebugKit.shared.getDebugInfo()
/*
Returns:
{
    "version": "1.0.0",
    "fullVersion": "1.0.0 (1)",
    "buildNumber": "1",
    "platform": "iOS",
    "minimumIOSVersion": "16.0",
    "timestamp": 1697123456.789
}
*/
```

## Future Features

### Local Server (Coming Soon)
- **Response Caching**: Automatically save server responses
- **Offline Development**: Run your app without network connectivity
- **Response Management**: View, edit, and manage cached responses
- **Mock Scenarios**: Test different server response scenarios

### Additional Planned Features
- **Network Monitoring**: Track and log network requests
- **Performance Metrics**: Monitor app performance
- **Log Management**: Centralized logging system
- **Crash Reporting**: Enhanced crash reporting tools

## Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

## License

HPDebugKit is released under the MIT License. See [LICENSE](LICENSE) for details.

## Support

For questions, issues, or feature requests, please:
- Open an issue on GitHub
- Contact the development team
- Check the documentation for common solutions

## Changelog

### Version 1.0.0
- Initial release
- Core debugging utilities with clean public API
- Internal file management and data persistence systems
- HPSettingsView SwiftUI interface
- Version information utilities
- Local Server foundation (internal)

---

**Made with ❤️ for iOS developers**
