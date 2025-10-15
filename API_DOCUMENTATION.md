# HPDebugKit API Documentation

## Overview

HPDebugKit is a comprehensive debugging toolkit designed to simplify iOS development workflows. This document provides detailed API documentation for all available classes, methods, and utilities.

## Table of Contents

- [HPDebugKit](#hpdebugkit)
- [HPFileManager](#hpfilemanager)
- [HPUserDefaultsManager](#hpuserddefaultsmanager)
- [HPSettingsView](#hpsettingsview)
- [HPDirectory](#hpdirectory)
- [HPUserDefaultsKey](#hpuserddefaultskey)

---

## HPDebugKit

The main entry point for the HPDebugKit package.

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

## HPFileManager

Comprehensive file and directory management utilities.

### Properties

#### `shared: HPFileManager`
Singleton instance of HPFileManager.

### Directory Operations

#### `createDirectory(named:in:) -> Bool`
Creates a directory with the specified name in the given base URL.

**Parameters:**
- `directoryName: String` - Name of the directory to create
- `baseURL: URL` - Base URL where the directory should be created

**Returns:** `true` if successful, `false` otherwise

### File Existence Operations

#### `itemExists(at:) -> Bool`
Checks if a file or directory exists at the specified URL.

**Parameters:**
- `url: URL` - The file or directory URL to check

**Returns:** `true` if exists, `false` otherwise

#### `fileExists(at:) -> Bool`
Checks if a file exists at the specified URL.

**Parameters:**
- `url: URL` - The file URL to check

**Returns:** `true` if file exists, `false` otherwise

#### `directoryExists(at:) -> Bool`
Checks if a directory exists at the specified URL.

**Parameters:**
- `url: URL` - The directory URL to check

**Returns:** `true` if directory exists, `false` otherwise

### Directory Content Operations

#### `contentsOfDirectory(at:) -> [String]`
Lists the contents of a directory at the specified URL.

**Parameters:**
- `url: URL` - The directory URL

**Returns:** Array of file names, or empty array if failed

### File Management Operations

#### `removeItem(at:) -> Bool`
Removes a file or directory.

**Parameters:**
- `url: URL` - The file or directory URL to remove

**Returns:** `true` if successful, `false` otherwise

#### `copyItem(from:to:) -> Bool`
Copies a file or directory.

**Parameters:**
- `sourceURL: URL` - The source URL
- `destinationURL: URL` - The destination URL

**Returns:** `true` if successful, `false` otherwise

#### `moveItem(from:to:) -> Bool`
Moves a file or directory.

**Parameters:**
- `sourceURL: URL` - The source URL
- `destinationURL: URL` - The destination URL

**Returns:** `true` if successful, `false` otherwise

### File Writing Operations

#### `writeJSON(_:to:) -> Bool`
Writes a Dictionary to a JSON file with pretty printing.

**Parameters:**
- `dictionary: [String: Any]` - The dictionary to write
- `url: URL` - The file URL where to write the JSON

**Returns:** `true` if successful, `false` otherwise

#### `writeJSON<T: Codable>(_:to:) -> Bool`
Writes a Codable object to a JSON file with pretty printing.

**Parameters:**
- `codable: T` - The Codable object to write
- `url: URL` - The file URL where to write the JSON

**Returns:** `true` if successful, `false` otherwise

#### `writeText(_:to:) -> Bool`
Writes a String to a text file.

**Parameters:**
- `text: String` - The string to write
- `url: URL` - The file URL where to write the text

**Returns:** `true` if successful, `false` otherwise

#### `writeData(_:to:) -> Bool`
Writes Data to a file.

**Parameters:**
- `data: Data` - The data to write
- `url: URL` - The file URL where to write the data

**Returns:** `true` if successful, `false` otherwise

#### `appendText(_:to:) -> Bool`
Appends text to an existing file or creates a new file.

**Parameters:**
- `text: String` - The text to append
- `url: URL` - The file URL where to append the text

**Returns:** `true` if successful, `false` otherwise

### Utility Operations

#### `sizeOfItem(at:) -> Int64?`
Gets the size of a file or directory.

**Parameters:**
- `url: URL` - The file or directory URL

**Returns:** Size in bytes, or `nil` if failed

---

## HPUserDefaultsManager

Type-safe UserDefaults management with enum-based keys.

### Properties

#### `shared: HPUserDefaultsManager`
Singleton instance of HPUserDefaultsManager.

### Generic Data Operations

#### `save<T>(_:forKey:) -> Bool`
Saves any UserDefaults-compatible value.

**Parameters:**
- `value: T` - The value to save (must be UserDefaults-compatible)
- `key: HPUserDefaultsKey` - The enum key to associate with the value

**Returns:** `true` if successful, `false` otherwise

#### `fetch<T>(_:forKey:) -> T?`
Fetches a value from UserDefaults with type safety.

**Parameters:**
- `type: T.Type` - The type to cast the value to
- `key: HPUserDefaultsKey` - The enum key to fetch the value for

**Returns:** The value cast to the specified type, or `nil` if not found or wrong type

#### `fetch<T>(_:forKey:defaultValue:) -> T`
Fetches a value from UserDefaults with a default value.

**Parameters:**
- `type: T.Type` - The type to cast the value to
- `key: HPUserDefaultsKey` - The enum key to fetch the value for
- `defaultValue: T` - The default value to return if not found or wrong type

**Returns:** The value cast to the specified type or the default value

### Specialized Methods

#### `fetchString(forKey:) -> String?`
Fetches a String value from UserDefaults (uses optimized UserDefaults.string method).

**Parameters:**
- `key: HPUserDefaultsKey` - The enum key to fetch the value for

**Returns:** The string value, or `nil` if not found

#### `fetchString(forKey:defaultValue:) -> String`
Fetches a String value from UserDefaults with a default value.

**Parameters:**
- `key: HPUserDefaultsKey` - The enum key to fetch the value for
- `defaultValue: String` - The default value to return if not found

**Returns:** The string value or the default value

#### `fetchData(forKey:) -> Data?`
Fetches Data from UserDefaults (uses optimized UserDefaults.data method).

**Parameters:**
- `key: HPUserDefaultsKey` - The enum key to fetch the value for

**Returns:** The data, or `nil` if not found

#### `fetchArray(forKey:) -> [Any]?`
Fetches an Array from UserDefaults (uses optimized UserDefaults.array method).

**Parameters:**
- `key: HPUserDefaultsKey` - The enum key to fetch the value for

**Returns:** The array, or `nil` if not found

#### `fetchDictionary(forKey:) -> [String: Any]?`
Fetches a Dictionary from UserDefaults (uses optimized UserDefaults.dictionary method).

**Parameters:**
- `key: HPUserDefaultsKey` - The enum key to fetch the value for

**Returns:** The dictionary, or `nil` if not found

### Codable Object Operations

#### `saveCodable<T: Codable>(_:forKey:) -> Bool`
Saves a Codable object to UserDefaults as JSON.

**Parameters:**
- `object: T` - The Codable object to save
- `key: HPUserDefaultsKey` - The enum key to associate with the value

**Returns:** `true` if successful, `false` otherwise

#### `fetchCodable<T: Codable>(_:forKey:) -> T?`
Fetches a Codable object from UserDefaults.

**Parameters:**
- `type: T.Type` - The type of the Codable object to fetch
- `key: HPUserDefaultsKey` - The enum key to fetch the value for

**Returns:** The decoded object, or `nil` if not found or failed to decode

#### `fetchCodable<T: Codable>(_:forKey:defaultValue:) -> T`
Fetches a Codable object from UserDefaults with a default value.

**Parameters:**
- `type: T.Type` - The type of the Codable object to fetch
- `key: HPUserDefaultsKey` - The enum key to fetch the value for
- `defaultValue: T` - The default value to return if not found or failed to decode

**Returns:** The decoded object or the default value

### Bulk Operations

#### `saveMultiple(_:) -> Bool`
Saves multiple key-value pairs to UserDefaults.

**Parameters:**
- `values: [HPUserDefaultsKey: Any]` - Dictionary of enum key-value pairs to save

**Returns:** `true` if all values were saved successfully, `false` otherwise

#### `fetchMultiple(forKeys:) -> [HPUserDefaultsKey: Any]`
Fetches multiple values from UserDefaults.

**Parameters:**
- `keys: [HPUserDefaultsKey]` - Array of enum keys to fetch

**Returns:** Dictionary of fetched key-value pairs

#### `removeMultiple(forKeys:) -> Bool`
Removes multiple keys from UserDefaults.

**Parameters:**
- `keys: [HPUserDefaultsKey]` - Array of enum keys to remove

**Returns:** `true` if all keys were removed successfully, `false` otherwise

### Utility Operations

#### `keyExists(_:) -> Bool`
Checks if a key exists in UserDefaults.

**Parameters:**
- `key: HPUserDefaultsKey` - The enum key to check

**Returns:** `true` if the key exists, `false` otherwise

#### `remove(forKey:) -> Bool`
Removes a value for a specific key from UserDefaults.

**Parameters:**
- `key: HPUserDefaultsKey` - The enum key to remove

**Returns:** `true` if successful, `false` otherwise

#### `clearAll() -> Bool`
Clears all UserDefaults data.

**Returns:** `true` if successful, `false` otherwise

#### `getAllKeys() -> [String]`
Gets all keys currently stored in UserDefaults.

**Returns:** Array of all keys as strings

#### `getAllValues() -> [String: Any]`
Gets all key-value pairs currently stored in UserDefaults.

**Returns:** Dictionary of all key-value pairs

#### `getAllEnumKeys() -> [HPUserDefaultsKey]`
Gets all enum keys that are currently stored in UserDefaults.

**Returns:** Array of enum keys that exist in UserDefaults

#### `synchronize() -> Bool`
Synchronizes UserDefaults to disk.

**Returns:** `true` if successful, `false` otherwise

### Debug Operations

#### `printAllData()`
Prints all stored UserDefaults data for debugging.

#### `printData(forKeys:)`
Prints UserDefaults data for specific enum keys.

**Parameters:**
- `keys: [HPUserDefaultsKey]` - Array of enum keys to print

#### `printEnumKeysData()`
Prints all enum keys and their values for debugging.

---

## HPSettingsView

SwiftUI-based settings screen for package configuration.

### Properties

#### `init()`
Creates a new instance of HPSettingsView.

### Methods

#### `body: some View`
The main view body containing the settings interface.

**Availability:** iOS 16.0+, macOS 10.15+

**Features:**
- Version information display
- File management testing tools
- Extensible design for future features

---

## HPDirectory

Enum providing easy access to common iOS directories.

### Cases

#### `.documents`
Documents directory URL.

#### `.cache`
Cache directory URL.

#### `.temporary`
Temporary directory URL.

#### `.applicationSupport`
Application Support directory URL.

### Properties

#### `url: URL`
Returns the URL for the directory.

#### `path: String`
Returns the path string for the directory.

---

## HPUserDefaultsKey

Enum defining UserDefaults keys for type-safe access.

### Default Keys

#### `.userID`
User identifier key.

#### `.isLoggedIn`
Login status key.

#### `.lastSyncDate`
Last synchronization date key.

#### `.userPreferences`
User preferences key.

#### `.appTheme`
Application theme key.

#### `.notificationsEnabled`
Notifications enabled status key.

#### `.language`
Application language key.

#### `.debugMode`
Debug mode status key.

#### `.lastAppVersion`
Last app version key.

#### `.onboardingCompleted`
Onboarding completion status key.

### Properties

#### `rawValue: String`
The string value of the key.

### Usage

```swift
// Add your own keys by extending the enum
extension HPUserDefaultsKey {
    static let myCustomKey = HPUserDefaultsKey(rawValue: "my_custom_key")
}

// Or create nested enums for organization
enum MyAppKeys: String, CaseIterable {
    case userID = "user_id"
    case userName = "user_name"
    case userEmail = "user_email"
}
```

---

## Error Handling

All methods that can fail return `Bool` values indicating success or failure. Failed operations are logged to the console with descriptive error messages.

## Thread Safety

All HPDebugKit classes are thread-safe and can be used from any thread.

## Best Practices

1. **Use enum keys** for UserDefaults to prevent typos and improve maintainability
2. **Check return values** for file operations to handle failures gracefully
3. **Use specialized methods** (like `fetchString`) for better performance
4. **Present HPSettingsView** in a sheet or navigation view for better UX
5. **Extend HPUserDefaultsKey** with your own keys for type safety

## Examples

### Complete Integration Example

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
                
                Button("Test File Operations") {
                    testFileOperations()
                }
                
                Button("Test UserDefaults") {
                    testUserDefaults()
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
    
    private func testFileOperations() {
        let fileManager = HPFileManager.shared
        let documentsURL = HPDirectory.documents.url
        
        // Create a test directory
        let success = fileManager.createDirectory(named: "TestData", in: documentsURL)
        print("Directory creation: \(success)")
        
        // Write test data
        let testData = "Hello, HPDebugKit!".data(using: .utf8)!
        let fileURL = documentsURL.appendingPathComponent("TestData/test.txt")
        let writeSuccess = fileManager.writeData(testData, to: fileURL)
        print("File write: \(writeSuccess)")
    }
    
    private func testUserDefaults() {
        let userDefaults = HPUserDefaultsManager.shared
        
        // Save test data
        userDefaults.save("test_user", forKey: .userID)
        userDefaults.save(true, forKey: .isLoggedIn)
        userDefaults.save(Date(), forKey: .lastSyncDate)
        
        // Fetch test data
        let userID = userDefaults.fetchString(forKey: .userID, defaultValue: "unknown")
        let isLoggedIn = userDefaults.fetch(Bool.self, forKey: .isLoggedIn, defaultValue: false)
        
        print("User ID: \(userID)")
        print("Is Logged In: \(isLoggedIn)")
    }
}
```

This comprehensive API documentation provides developers with all the information they need to effectively use HPDebugKit in their iOS applications.
