# HPDebugKit

A comprehensive debugging toolkit for iOS developers that simplifies development workflows and provides essential debugging utilities.

## Overview

HPDebugKit is designed to make iOS development easier by providing developers with powerful debugging tools and utilities. The package offers a unified interface for common debugging tasks, file management, data persistence, and development-specific features.

## Features

### 🔧 Core Debugging Tools
- **Version Information**: Easy access to app version, build number, and debug information
- **File Management**: Comprehensive file and directory operations
- **Data Persistence**: Type-safe UserDefaults management with enum-based keys
- **Settings UI**: Built-in SwiftUI interface for package configuration

### 🌐 Local Server (Coming Soon)
- **Response Caching**: Save server responses locally for offline development
- **Mock Server**: Run your app using cached responses without network dependency
- **Development Testing**: Test your app's behavior with different server responses

### 📱 Developer-Friendly UI
- **HPSettingsView**: SwiftUI-based settings screen for package configuration
- **Easy Integration**: Simple to integrate into your existing app
- **Customizable**: Extensible design for future features

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

### File Management

HPDebugKit provides comprehensive file management capabilities:

```swift
let fileManager = HPFileManager.shared

// Create directories
let documentsURL = HPDirectory.documents.url
fileManager.createDirectory(named: "MyAppData", in: documentsURL)

// Check if files/directories exist
let exists = fileManager.fileExists(at: someURL)
let dirExists = fileManager.directoryExists(at: someURL)

// Write data
let data = "Hello World".data(using: .utf8)!
fileManager.writeData(data, to: someURL)

// Write JSON
let jsonData = ["key": "value"]
fileManager.writeJSON(jsonData, to: someURL)
```

### UserDefaults Management

Type-safe UserDefaults with enum-based keys:

```swift
let userDefaults = HPUserDefaultsManager.shared

// Define your keys
enum MyAppKeys: String, CaseIterable {
    case userID = "user_id"
    case isLoggedIn = "is_logged_in"
    case lastSyncDate = "last_sync_date"
}

// Save data
userDefaults.save("john_doe", forKey: .userID)
userDefaults.save(true, forKey: .isLoggedIn)
userDefaults.save(Date(), forKey: .lastSyncDate)

// Fetch data with type safety
let userID: String? = userDefaults.fetch(String.self, forKey: .userID)
let isLoggedIn: Bool = userDefaults.fetch(Bool.self, forKey: .isLoggedIn, defaultValue: false)

// Save Codable objects
struct UserPreferences: Codable {
    let theme: String
    let notifications: Bool
}

let preferences = UserPreferences(theme: "dark", notifications: true)
userDefaults.saveCodable(preferences, forKey: .userPreferences)
let fetchedPrefs = userDefaults.fetchCodable(UserPreferences.self, forKey: .userPreferences)
```

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

## Available Directories

HPDebugKit provides easy access to common iOS directories:

```swift
// Documents directory
let documentsURL = HPDirectory.documents.url

// Cache directory
let cacheURL = HPDirectory.cache.url

// Temporary directory
let tempURL = HPDirectory.temporary.url

// Application Support directory
let appSupportURL = HPDirectory.applicationSupport.url
```

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
- Core debugging utilities
- File management system
- UserDefaults management with enum keys
- HPSettingsView SwiftUI interface
- Version information utilities

---

**Made with ❤️ for iOS developers**
