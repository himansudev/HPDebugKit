# HPDebugKit Quick Start Guide

## What is HPDebugKit?

HPDebugKit is a developer-focused debugging toolkit that makes iOS development easier by providing:

- **🔧 Core Debugging Tools**: Version info and debug information
- **🌐 Local Server** (Coming Soon): Save server responses and run offline
- **📱 Settings UI**: Built-in SwiftUI interface for package configuration
- **⚡ Clean API**: Minimal public interface focused on developer needs

## 5-Minute Setup

### Step 1: Add the Package

In Xcode:
1. **File → Add Package Dependencies**
2. Enter: `https://github.com/yourusername/HPDebugKit.git`
3. Add to your target

### Step 2: Import and Use

```swift
import HPDebugKit
import SwiftUI

struct ContentView: View {
    @State private var showSettings = false
    
    var body: some View {
        VStack {
            Text("My App")
            
            Button("Debug Settings") {
                showSettings = true
            }
        }
        .sheet(isPresented: $showSettings) {
            HPSettingsView()
        }
    }
}
```

### Step 3: Test It Works

```swift
// Get version info
let version = HPDebugKit.shared.getVersion()
print("HPDebugKit Version: \(version)")

// Get debug information
let debugInfo = HPDebugKit.shared.getDebugInfo()
print("Debug Info: \(debugInfo)")

// The package handles all internal operations automatically
// You only need to use the public API
```

## Common Use Cases

### 1. Present Debug Settings

```swift
// As a sheet
.sheet(isPresented: $showSettings) {
    HPSettingsView()
}

// As navigation destination
NavigationLink("Debug Settings") {
    HPSettingsView()
}

// As full screen cover
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

### 2. Get Debug Information

```swift
// Get comprehensive debug info
let debugKit = HPDebugKit.shared
let debugInfo = debugKit.getDebugInfo()

// Debug info includes:
// - Package version
// - Build number
// - Platform information
// - Timestamp
print("Debug Info: \(debugInfo)")
```

### 3. Access Settings Programmatically

```swift
// The HPSettingsView shows current settings
// You can access debug information programmatically
let debugKit = HPDebugKit.shared
let version = debugKit.getVersion()
let buildNumber = debugKit.getBuildNumber()

// Use this information for debugging or logging
print("App Version: \(version) (\(buildNumber))")
```

## Local Server Feature (Coming Soon)

The Local Server feature will allow you to:

1. **Save Server Responses**: Automatically cache API responses
2. **Run Offline**: Test your app without network connectivity
3. **Mock Scenarios**: Test different server response scenarios
4. **Response Management**: View, edit, and manage cached responses

```swift
// Future API (subject to change)
let localServer = HPLocalServer.shared

// Enable response caching
localServer.enableCaching()

// Save a response
localServer.saveResponse(for: "api/users", data: responseData)

// Use cached response
let cachedData = localServer.getCachedResponse(for: "api/users")
```

## Best Practices

### 1. Use the Public API Only
```swift
// ✅ Good - Use only public interfaces
let debugKit = HPDebugKit.shared
let version = debugKit.getVersion()

// ❌ Bad - Don't access internal classes
// HPFileManager.shared // This is internal
```

### 2. Present Settings Properly
```swift
// ✅ Good - Proper navigation
NavigationView {
    HPSettingsView()
        .navigationTitle("Debug Settings")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") { showSettings = false }
            }
        }
}

// ❌ Bad - No navigation context
HPSettingsView()
```

### 3. Handle Debug Information Appropriately
```swift
// ✅ Good - Use debug info for logging
let debugInfo = HPDebugKit.shared.getDebugInfo()
print("Debug Info: \(debugInfo)")

// ✅ Good - Use version info for support
let version = HPDebugKit.shared.getVersion()
print("App Version: \(version)")
```

## Troubleshooting

### "Cannot find 'HPSettingsView' in scope"

**Solution:**
1. Clean build folder (Cmd+Shift+K)
2. Update package dependencies
3. Make sure you're importing both `HPDebugKit` and `SwiftUI`

### Debug information not showing

**Solution:**
1. Make sure you're calling the correct methods
2. Check that the package is properly imported
3. Verify the package is up to date

## Next Steps

1. **Explore the API**: Check out [API Documentation](API_DOCUMENTATION.md)
2. **Read Examples**: See [README](README.md) for more examples
3. **Integrate Settings**: Add `HPSettingsView` to your app's debug menu
4. **Future Features**: Watch for Local Server and other upcoming features

## Support

- **GitHub Issues**: Report bugs and request features
- **Documentation**: Check README and API docs
- **Community**: Join our developer community

---

**Happy Debugging! 🚀**
