# HPDebugKit API Documentation

## Overview

HPDebugKit provides a clean, minimal API focused on developer needs. The package uses internal utilities for complex operations while exposing only the essential interfaces that developers need.

## Table of Contents

- [HPDebugKit](#hpdebugkit) - Main public interface
- [HPSettingsView](#hpsettingsview) - SwiftUI settings interface
- [Internal Architecture](#internal-architecture) - How the package works internally

---

## HPDebugKit

The main entry point for the HPDebugKit package. This is the primary interface that developers interact with.

### Properties

#### `shared: HPDebugKit`
Singleton instance of HPDebugKit.

### Methods

#### `getVersion() -> String`
Returns the current version of HPDebugKit.

**Returns:** Version string (e.g., "1.0.0")

#### `getFullVersion() -> String`
Returns the full version string including build number.

**Returns:** Full version string (e.g., "1.0.0 (1)")

#### `getBuildNumber() -> String`
Returns the build number.

**Returns:** Build number string (e.g., "1")

#### `getDebugInfo() -> [String: Any]`
Returns comprehensive debug information about the app and package.

**Returns:** Dictionary containing:
- `version`: Package version
- `fullVersion`: Full version with build number
- `buildNumber`: Build number
- `platform`: Platform name ("iOS")
- `minimumIOSVersion`: Minimum iOS version requirement
- `timestamp`: Current timestamp

---

## HPSettingsView

SwiftUI-based settings screen for package configuration. This is the main UI component that developers can integrate into their apps.

### Properties

#### `init()`
Creates a new instance of HPSettingsView.

### Methods

#### `body: some View`
The main view body containing the settings interface.

**Availability:** iOS 16.0+, macOS 10.15+

**Features:**
- Version information display
- Local Server status (when available)
- Extensible design for future features

---

## Internal Architecture

HPDebugKit uses a clean architecture that separates public API from internal implementation:

### Public Interface
- **HPDebugKit**: Main entry point for version and debug information
- **HPSettingsView**: SwiftUI interface for settings

### Internal Implementation
The package includes internal utilities that are not exposed in the public API:

- **HPFileManager**: File and directory operations
- **HPUserDefaultsManager**: Type-safe UserDefaults management
- **HPDirectory**: Directory access utilities
- **HPUserDefaultsKey**: Predefined keys for internal use

### Design Benefits
- **Clean API**: Developers only see what they need
- **Future-Proof**: Internal changes don't affect public API
- **Maintainable**: Clear separation of concerns
- **Extensible**: Easy to add new features without breaking existing code

---

## Usage Examples

### Basic Integration

```swift
import SwiftUI
import HPDebugKit

struct ContentView: View {
    @State private var showSettings = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("My App")
                
                Button("Open Debug Settings") {
                    showSettings = true
                }
                
                Button("Show Version Info") {
                    showVersionInfo()
                }
            }
            .navigationTitle("My App")
        }
        .sheet(isPresented: $showSettings) {
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
    }
    
    private func showVersionInfo() {
        let debugKit = HPDebugKit.shared
        let version = debugKit.getVersion()
        let debugInfo = debugKit.getDebugInfo()
        
        print("HPDebugKit Version: \(version)")
        print("Debug Info: \(debugInfo)")
    }
}
```

### Settings Screen Variations

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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { showSettings = false }
                }
            }
    }
}
```

---

## Error Handling

All public methods are designed to be safe and won't throw errors. Internal error handling is managed by the package.

## Thread Safety

All HPDebugKit classes are thread-safe and can be used from any thread.

## Best Practices

1. **Use the Public API**: Only use `HPDebugKit` and `HPSettingsView`
2. **Present Settings Properly**: Use proper navigation context for `HPSettingsView`
3. **Check Return Values**: Handle debug information appropriately
4. **Future-Ready**: The API is designed to be stable as new features are added

## Future API Additions

As new features are added (like Local Server), they will be exposed through the existing public interfaces without breaking changes to the current API.

---

This documentation focuses on the public API that developers need to use. The internal implementation details are managed by the package and don't require developer attention.
