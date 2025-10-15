//
//  HPUserDefaultsManager.swift
//  HPDebugKit
//
//  Created by Apple on 13/10/25.
//

import Foundation

/// A comprehensive UserDefaults manager for saving and fetching data
internal final class HPUserDefaultsManager {
    static let shared = HPUserDefaultsManager()
    
    private let userDefaults = UserDefaults.standard
    
    private init() {}
}

// MARK: - UserDefaults Keys
enum HPUserDefaultsKey: String, CaseIterable {
    // Example keys - replace with your actual keys
//    case userID = "user_id"
//    case isLoggedIn = "is_logged_in"
//    case lastSyncDate = "last_sync_date"
//    case userPreferences = "user_preferences"
//    case appTheme = "app_theme"
//    case notificationsEnabled = "notifications_enabled"
//    case language = "app_language"
//    case debugMode = "debug_mode"
//    case lastAppVersion = "last_app_version"
//    case onboardingCompleted = "onboarding_completed"
    
    case localServerEnabled = "is_local_server_enabled"
    
    // You can also organize keys by creating nested enums:
    // enum User: String, CaseIterable {
    //     case id = "user_id"
    //     case name = "user_name"
    //     case email = "user_email"
    // }
    // 
    // enum Settings: String, CaseIterable {
    //     case theme = "app_theme"
    //     case notifications = "notifications_enabled"
    //     case language = "app_language"
    // }
}

// MARK: - Generic Data Operations
extension HPUserDefaultsManager {
    
    /// Saves any UserDefaults-compatible value
    /// - Parameters:
    ///   - value: The value to save (must be UserDefaults-compatible)
    ///   - key: The enum key to associate with the value
    /// - Returns: True if successful, false otherwise
    @discardableResult
    func save<T>(_ value: T, forKey key: HPUserDefaultsKey) -> Bool {
        userDefaults.set(value, forKey: key.rawValue)
        return userDefaults.synchronize()
    }
    
    /// Fetches a value from UserDefaults with type safety
    /// - Parameters:
    ///   - type: The type to cast the value to
    ///   - key: The enum key to fetch the value for
    /// - Returns: The value cast to the specified type, or nil if not found or wrong type
    func fetch<T>(_ type: T.Type, forKey key: HPUserDefaultsKey) -> T? {
        return userDefaults.object(forKey: key.rawValue) as? T
    }
    
    /// Fetches a value from UserDefaults with a default value
    /// - Parameters:
    ///   - type: The type to cast the value to
    ///   - key: The enum key to fetch the value for
    ///   - defaultValue: The default value to return if not found or wrong type
    /// - Returns: The value cast to the specified type or the default value
    func fetch<T>(_ type: T.Type, forKey key: HPUserDefaultsKey, defaultValue: T) -> T {
        return fetch(type, forKey: key) ?? defaultValue
    }
    
    // MARK: - Specialized Methods for Better Performance
    
    /// Fetches a String value from UserDefaults (uses optimized UserDefaults.string method)
    /// - Parameter key: The enum key to fetch the value for
    /// - Returns: The string value, or nil if not found
    func fetchString(forKey key: HPUserDefaultsKey) -> String? {
        return userDefaults.string(forKey: key.rawValue)
    }
    
    /// Fetches a String value from UserDefaults with a default value
    /// - Parameters:
    ///   - key: The enum key to fetch the value for
    ///   - defaultValue: The default value to return if not found
    /// - Returns: The string value or the default value
    func fetchString(forKey key: HPUserDefaultsKey, defaultValue: String) -> String {
        return userDefaults.string(forKey: key.rawValue) ?? defaultValue
    }
    
    /// Fetches Data from UserDefaults (uses optimized UserDefaults.data method)
    /// - Parameter key: The enum key to fetch the value for
    /// - Returns: The data, or nil if not found
    func fetchData(forKey key: HPUserDefaultsKey) -> Data? {
        return userDefaults.data(forKey: key.rawValue)
    }
    
    /// Fetches an Array from UserDefaults (uses optimized UserDefaults.array method)
    /// - Parameter key: The enum key to fetch the value for
    /// - Returns: The array, or nil if not found
    func fetchArray(forKey key: HPUserDefaultsKey) -> [Any]? {
        return userDefaults.array(forKey: key.rawValue)
    }
    
    /// Fetches a Dictionary from UserDefaults (uses optimized UserDefaults.dictionary method)
    /// - Parameter key: The enum key to fetch the value for
    /// - Returns: The dictionary, or nil if not found
    func fetchDictionary(forKey key: HPUserDefaultsKey) -> [String: Any]? {
        return userDefaults.dictionary(forKey: key.rawValue)
    }
}

// MARK: - Codable Object Operations
extension HPUserDefaultsManager {
    
    /// Saves a Codable object to UserDefaults as JSON
    /// - Parameters:
    ///   - object: The Codable object to save
    ///   - key: The enum key to associate with the value
    /// - Returns: True if successful, false otherwise
    @discardableResult
    func saveCodable<T: Codable>(_ object: T, forKey key: HPUserDefaultsKey) -> Bool {
        do {
            let data = try JSONEncoder().encode(object)
            return save(data, forKey: key)
        } catch {
            print("HPUserDefaultsManager: Failed to encode Codable object for key '\(key.rawValue)' - \(error.localizedDescription)")
            return false
        }
    }
    
    /// Fetches a Codable object from UserDefaults
    /// - Parameters:
    ///   - type: The type of the Codable object to fetch
    ///   - key: The enum key to fetch the value for
    /// - Returns: The decoded object, or nil if not found or failed to decode
    func fetchCodable<T: Codable>(_ type: T.Type, forKey key: HPUserDefaultsKey) -> T? {
        guard let data = fetchData(forKey: key) else {
            return nil
        }
        
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            print("HPUserDefaultsManager: Failed to decode Codable object for key '\(key.rawValue)' - \(error.localizedDescription)")
            return nil
        }
    }
    
    /// Fetches a Codable object from UserDefaults with a default value
    /// - Parameters:
    ///   - type: The type of the Codable object to fetch
    ///   - key: The enum key to fetch the value for
    ///   - defaultValue: The default value to return if not found or failed to decode
    /// - Returns: The decoded object or the default value
    func fetchCodable<T: Codable>(_ type: T.Type, forKey key: HPUserDefaultsKey, defaultValue: T) -> T {
        return fetchCodable(type, forKey: key) ?? defaultValue
    }
}

// MARK: - Bulk Operations
extension HPUserDefaultsManager {
    
    /// Saves multiple key-value pairs to UserDefaults
    /// - Parameter values: Dictionary of enum key-value pairs to save
    /// - Returns: True if all values were saved successfully, false otherwise
    @discardableResult
    func saveMultiple(_ values: [HPUserDefaultsKey: Any]) -> Bool {
        for (key, value) in values {
            userDefaults.set(value, forKey: key.rawValue)
        }
        
        return userDefaults.synchronize()
    }
    
    /// Fetches multiple values from UserDefaults
    /// - Parameter keys: Array of enum keys to fetch
    /// - Returns: Dictionary of fetched key-value pairs
    func fetchMultiple(forKeys keys: [HPUserDefaultsKey]) -> [HPUserDefaultsKey: Any] {
        var result: [HPUserDefaultsKey: Any] = [:]
        
        for key in keys {
            if let value = userDefaults.object(forKey: key.rawValue) {
                result[key] = value
            }
        }
        
        return result
    }
    
    /// Removes multiple keys from UserDefaults
    /// - Parameter keys: Array of enum keys to remove
    /// - Returns: True if all keys were removed successfully, false otherwise
    @discardableResult
    func removeMultiple(forKeys keys: [HPUserDefaultsKey]) -> Bool {
        for key in keys {
            userDefaults.removeObject(forKey: key.rawValue)
        }
        return userDefaults.synchronize()
    }
}

// MARK: - Utility Operations
extension HPUserDefaultsManager {
    
    /// Checks if a key exists in UserDefaults
    /// - Parameter key: The enum key to check
    /// - Returns: True if the key exists, false otherwise
    func keyExists(_ key: HPUserDefaultsKey) -> Bool {
        return userDefaults.object(forKey: key.rawValue) != nil
    }
    
    /// Removes a value for a specific key from UserDefaults
    /// - Parameter key: The enum key to remove
    /// - Returns: True if successful, false otherwise
    @discardableResult
    func remove(forKey key: HPUserDefaultsKey) -> Bool {
        userDefaults.removeObject(forKey: key.rawValue)
        return userDefaults.synchronize()
    }
    
    /// Clears all UserDefaults data
    /// - Returns: True if successful, false otherwise
    @discardableResult
    func clearAll() -> Bool {
        let domain = Bundle.main.bundleIdentifier ?? "default"
        userDefaults.removePersistentDomain(forName: domain)
        return userDefaults.synchronize()
    }
    
    /// Gets all keys currently stored in UserDefaults
    /// - Returns: Array of all keys as strings
    func getAllKeys() -> [String] {
        return Array(userDefaults.dictionaryRepresentation().keys)
    }
    
    /// Gets all key-value pairs currently stored in UserDefaults
    /// - Returns: Dictionary of all key-value pairs
    func getAllValues() -> [String: Any] {
        return userDefaults.dictionaryRepresentation()
    }
    
    /// Gets all enum keys that are currently stored in UserDefaults
    /// - Returns: Array of enum keys that exist in UserDefaults
    func getAllEnumKeys() -> [HPUserDefaultsKey] {
        let allKeys = getAllKeys()
        return HPUserDefaultsKey.allCases.filter { key in
            allKeys.contains(key.rawValue)
        }
    }
    
    /// Synchronizes UserDefaults to disk
    /// - Returns: True if successful, false otherwise
    @discardableResult
    func synchronize() -> Bool {
        return userDefaults.synchronize()
    }
}

// MARK: - Debug Operations
extension HPUserDefaultsManager {
    
    /// Prints all stored UserDefaults data for debugging
    func printAllData() {
        let allData = getAllValues()
        print("HPUserDefaultsManager: All stored data:")
        for (key, value) in allData {
            print("  \(key): \(value)")
        }
    }
    
    /// Prints UserDefaults data for specific enum keys
    /// - Parameter keys: Array of enum keys to print
    func printData(forKeys keys: [HPUserDefaultsKey]) {
        print("HPUserDefaultsManager: Data for specified keys:")
        for key in keys {
            if let value = userDefaults.object(forKey: key.rawValue) {
                print("  \(key.rawValue): \(value)")
            } else {
                print("  \(key.rawValue): nil")
            }
        }
    }
    
    /// Prints all enum keys and their values for debugging
    func printEnumKeysData() {
        print("HPUserDefaultsManager: Data for enum keys:")
        for key in HPUserDefaultsKey.allCases {
            if let value = userDefaults.object(forKey: key.rawValue) {
                print("  \(key.rawValue): \(value)")
            } else {
                print("  \(key.rawValue): nil")
            }
        }
    }
}
