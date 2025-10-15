# HPDebugKit Quick Start Guide

## What is HPDebugKit?

HPDebugKit is a developer-focused debugging toolkit that makes iOS development easier by providing:

- **🔧 Core Debugging Tools**: Version info, file management, data persistence
- **🌐 Local Server** (Coming Soon): Save server responses and run offline
- **📱 Settings UI**: Built-in SwiftUI interface for package configuration
- **⚡ Type Safety**: Enum-based keys prevent typos and improve maintainability

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

// Test file operations
let fileManager = HPFileManager.shared
let documentsURL = HPDirectory.documents.url
fileManager.createDirectory(named: "TestData", in: documentsURL)

// Test UserDefaults
let userDefaults = HPUserDefaultsManager.shared
userDefaults.save("test_user", forKey: .userID)
let userID = userDefaults.fetchString(forKey: .userID, defaultValue: "unknown")
print("User ID: \(userID)")
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

### 2. Save App Settings

```swift
// Define your keys
enum MyAppKeys: String, CaseIterable {
    case userID = "user_id"
    case theme = "app_theme"
    case notifications = "notifications_enabled"
}

// Save settings
let userDefaults = HPUserDefaultsManager.shared
userDefaults.save("dark", forKey: .theme)
userDefaults.save(true, forKey: .notifications)

// Load settings
let theme = userDefaults.fetchString(forKey: .theme, defaultValue: "light")
let notifications = userDefaults.fetch(Bool.self, forKey: .notifications, defaultValue: false)
```

### 3. File Management

```swift
let fileManager = HPFileManager.shared

// Create app data directory
let documentsURL = HPDirectory.documents.url
fileManager.createDirectory(named: "MyAppData", in: documentsURL)

// Save user data
let userData = ["name": "John", "age": 30]
let dataURL = documentsURL.appendingPathComponent("MyAppData/user.json")
fileManager.writeJSON(userData, to: dataURL)

// Check if file exists
let exists = fileManager.fileExists(at: dataURL)
print("File exists: \(exists)")
```

### 4. Save Complex Objects

```swift
// Define your model
struct UserProfile: Codable {
    let name: String
    let email: String
    let preferences: [String: Any]
}

// Save complex object
let profile = UserProfile(name: "John", email: "john@example.com", preferences: [:])
let userDefaults = HPUserDefaultsManager.shared
userDefaults.saveCodable(profile, forKey: .userPreferences)

// Load complex object
let loadedProfile = userDefaults.fetchCodable(UserProfile.self, forKey: .userPreferences)
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

### 1. Use Enum Keys
```swift
// ✅ Good - Type safe, autocomplete, no typos
userDefaults.save(value, forKey: .userID)

// ❌ Bad - Prone to typos, no autocomplete
userDefaults.save(value, forKey: "user_id")
```

### 2. Check Return Values
```swift
// ✅ Good - Handle failures
let success = fileManager.createDirectory(named: "Data", in: documentsURL)
if !success {
    print("Failed to create directory")
}

// ❌ Bad - Ignore failures
fileManager.createDirectory(named: "Data", in: documentsURL)
```

### 3. Use Specialized Methods
```swift
// ✅ Good - Better performance
let string = userDefaults.fetchString(forKey: .userID)

// ❌ Bad - Less efficient
let string = userDefaults.fetch(String.self, forKey: .userID)
```

### 4. Present Settings Properly
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

## Troubleshooting

### "Cannot find 'HPSettingsView' in scope"

**Solution:**
1. Clean build folder (Cmd+Shift+K)
2. Update package dependencies
3. Make sure you're importing both `HPDebugKit` and `SwiftUI`

### UserDefaults not saving

**Solution:**
1. Check if you're using enum keys correctly
2. Verify the value is UserDefaults-compatible
3. Check return value of save method

### File operations failing

**Solution:**
1. Check if directory exists before writing
2. Verify you have write permissions
3. Check return values for error handling

## Next Steps

1. **Explore the API**: Check out [API Documentation](API_DOCUMENTATION.md)
2. **Read Examples**: See [README](README.md) for more examples
3. **Customize Settings**: Extend `HPSettingsView` for your needs
4. **Add Your Keys**: Extend `HPUserDefaultsKey` with your app's keys

## Support

- **GitHub Issues**: Report bugs and request features
- **Documentation**: Check README and API docs
- **Community**: Join our developer community

---

**Happy Debugging! 🚀**
