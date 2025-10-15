//
//  HPFileManager.swift
//  HPDebugConfigSDK
//
//  Created by Apple on 13/10/25.
//

import Foundation

public enum HPDirectory {
    case documents
    case cache
    case temporary
    case applicationSupport
    
    public var url: URL {
        switch self {
        case .documents:
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        case .cache:
            return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        case .temporary:
            return FileManager.default.temporaryDirectory
        case .applicationSupport:
            return FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        }
    }
    
    public var path: String {
        return url.path
    }
}

public final class HPFileManager {
    public static let shared = HPFileManager()
    
    private let fileManager = FileManager.default
    
    private init() {}
}

// MARK: - Directory Operations
extension HPFileManager {
    
//    /// Creates a directory at the specified HPDirectory location
//    /// - Parameter directory: The HPDirectory enum case
//    /// - Returns: True if successful, false otherwise
//    @discardableResult
//    public func createDirectory(_ directory: HPDirectory) -> Bool {
//        let url = directory.url
//        
//        do {
//            try fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
//            return true
//        } catch {
//            print("HPFileManager: Failed to create directory at \(url.path) - \(error.localizedDescription)")
//            return false
//        }
//    }
    
//    /// Creates a directory at the specified URL
//    /// - Parameter url: The directory URL
//    /// - Returns: True if successful, false otherwise
//    @discardableResult
//    public func createDirectory(at url: URL) -> Bool {
//        do {
//            try fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
//            return true
//        } catch {
//            print("HPFileManager: Failed to create directory at \(url.path) - \(error.localizedDescription)")
//            return false
//        }
//    }
    
    /// Creates a named directory within the specified base URL
    /// - Parameters:
    ///   - directoryName: The name of the directory to create
    ///   - baseURL: The base URL where the directory should be created
    /// - Returns: True if successful, false otherwise
    @discardableResult
    public func createDirectory(named directoryName: String, in baseURL: URL) -> Bool {
        let targetURL = baseURL.appendingPathComponent(directoryName)
        
        do {
            try fileManager.createDirectory(at: targetURL, withIntermediateDirectories: true, attributes: nil)
            return true
        } catch {
            print("HPFileManager: Failed to create directory '\(directoryName)' in \(baseURL.path) - \(error.localizedDescription)")
            return false
        }
    }
}

// MARK: - File Existence Operations
extension HPFileManager {
    
    /// Checks if a file or directory exists at the specified URL
    /// - Parameter url: The file or directory URL
    /// - Returns: True if exists, false otherwise
    public func itemExists(at url: URL) -> Bool {
        return fileManager.fileExists(atPath: url.path)
    }
    
    /// Checks if a file exists at the specified URL
    /// - Parameter url: The file URL
    /// - Returns: True if file exists, false otherwise
    public func fileExists(at url: URL) -> Bool {
        var isDirectory: ObjCBool = false
        let exists = fileManager.fileExists(atPath: url.path, isDirectory: &isDirectory)
        return exists && !isDirectory.boolValue
    }
    
    /// Checks if a directory exists at the specified URL
    /// - Parameter url: The directory URL
    /// - Returns: True if directory exists, false otherwise
    public func directoryExists(at url: URL) -> Bool {
        var isDirectory: ObjCBool = false
        let exists = fileManager.fileExists(atPath: url.path, isDirectory: &isDirectory)
        return exists && isDirectory.boolValue
    }
}

// MARK: - Directory Content Operations
extension HPFileManager {
    
    /// Lists the contents of a directory at the specified URL
    /// - Parameter url: The directory URL
    /// - Returns: Array of file names, or empty array if failed
    public func contentsOfDirectory(at url: URL) -> [String] {
        do {
            return try fileManager.contentsOfDirectory(atPath: url.path)
        } catch {
            print("HPFileManager: Failed to get contents of directory \(url.path) - \(error.localizedDescription)")
            return []
        }
    }
}

// MARK: - File Management Operations
extension HPFileManager {
    
    /// Removes a file or directory
    /// - Parameter url: The file or directory URL
    /// - Returns: True if successful, false otherwise
    @discardableResult
    public func removeItem(at url: URL) -> Bool {
        do {
            try fileManager.removeItem(at: url)
            return true
        } catch {
            print("HPFileManager: Failed to remove item at \(url.path) - \(error.localizedDescription)")
            return false
        }
    }
    
    /// Copies a file or directory
    /// - Parameters:
    ///   - sourceURL: The source URL
    ///   - destinationURL: The destination URL
    /// - Returns: True if successful, false otherwise
    @discardableResult
    public func copyItem(from sourceURL: URL, to destinationURL: URL) -> Bool {
        do {
            try fileManager.copyItem(at: sourceURL, to: destinationURL)
            return true
        } catch {
            print("HPFileManager: Failed to copy item from \(sourceURL.path) to \(destinationURL.path) - \(error.localizedDescription)")
            return false
        }
    }
    
    /// Moves a file or directory
    /// - Parameters:
    ///   - sourceURL: The source URL
    ///   - destinationURL: The destination URL
    /// - Returns: True if successful, false otherwise
    @discardableResult
    public func moveItem(from sourceURL: URL, to destinationURL: URL) -> Bool {
        do {
            try fileManager.moveItem(at: sourceURL, to: destinationURL)
            return true
        } catch {
            print("HPFileManager: Failed to move item from \(sourceURL.path) to \(destinationURL.path) - \(error.localizedDescription)")
            return false
        }
    }
}

// MARK: - File Writing Operations
extension HPFileManager {
    
    // MARK: - JSON Writing Methods
    
    /// Writes a Dictionary to a JSON file with pretty printing
    /// - Parameters:
    ///   - dictionary: The dictionary to write
    ///   - url: The file URL where to write the JSON
    /// - Returns: True if successful, false otherwise
    @discardableResult
    public func writeJSON(_ dictionary: [String: Any], to url: URL) -> Bool {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [.prettyPrinted, .sortedKeys])
            try jsonData.write(to: url)
            return true
        } catch {
            print("HPFileManager: Failed to write JSON dictionary to \(url.path) - \(error.localizedDescription)")
            return false
        }
    }
    
    /// Writes a Codable object to a JSON file with pretty printing
    /// - Parameters:
    ///   - codable: The Codable object to write
    ///   - url: The file URL where to write the JSON
    /// - Returns: True if successful, false otherwise
    @discardableResult
    public func writeJSON<T: Codable>(_ codable: T, to url: URL) -> Bool {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            let jsonData = try encoder.encode(codable)
            try jsonData.write(to: url)
            return true
        } catch {
            print("HPFileManager: Failed to write JSON codable to \(url.path) - \(error.localizedDescription)")
            return false
        }
    }
    
    /// Writes pre-encoded JSON Data to a file (no formatting applied)
    /// - Parameters:
    ///   - data: The pre-encoded JSON data to write
    ///   - url: The file URL where to write the JSON
    /// - Returns: True if successful, false otherwise
    @discardableResult
    public func writeJSON(_ data: Data, to url: URL) -> Bool {
        do {
            try data.write(to: url)
            return true
        } catch {
            print("HPFileManager: Failed to write JSON data to \(url.path) - \(error.localizedDescription)")
            return false
        }
    }
    
    /// Writes pre-encoded JSON Data to a file with pretty printing
    /// - Parameters:
    ///   - data: The pre-encoded JSON data to write
    ///   - url: The file URL where to write the JSON
    /// - Returns: True if successful, false otherwise
    @discardableResult
    public func writeJSONPretty(_ data: Data, to url: URL) -> Bool {
        do {
            // Parse the JSON data back to an object
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            
            // Re-encode with pretty printing
            let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted, .sortedKeys])
            try prettyData.write(to: url)
            return true
        } catch {
            print("HPFileManager: Failed to write pretty JSON data to \(url.path) - \(error.localizedDescription)")
            return false
        }
    }
    
    // MARK: - Text Writing Methods
    
    /// Writes a String to a text file
    /// - Parameters:
    ///   - text: The string to write
    ///   - url: The file URL where to write the text
    /// - Returns: True if successful, false otherwise
    @discardableResult
    public func writeText(_ text: String, to url: URL) -> Bool {
        do {
            try text.write(to: url, atomically: true, encoding: .utf8)
            return true
        } catch {
            print("HPFileManager: Failed to write text to \(url.path) - \(error.localizedDescription)")
            return false
        }
    }
    
    /// Writes Data to a text file
    /// - Parameters:
    ///   - data: The data to write
    ///   - url: The file URL where to write the text
    /// - Returns: True if successful, false otherwise
    @discardableResult
    public func writeText(_ data: Data, to url: URL) -> Bool {
        do {
            try data.write(to: url)
            return true
        } catch {
            print("HPFileManager: Failed to write text data to \(url.path) - \(error.localizedDescription)")
            return false
        }
    }
    
    // MARK: - Generic Writing Methods
    
    /// Writes Data to a file
    /// - Parameters:
    ///   - data: The data to write
    ///   - url: The file URL where to write the data
    /// - Returns: True if successful, false otherwise
    @discardableResult
    public func writeData(_ data: Data, to url: URL) -> Bool {
        do {
            try data.write(to: url)
            return true
        } catch {
            print("HPFileManager: Failed to write data to \(url.path) - \(error.localizedDescription)")
            return false
        }
    }
    
    /// Appends text to an existing file or creates a new file
    /// - Parameters:
    ///   - text: The text to append
    ///   - url: The file URL where to append the text
    /// - Returns: True if successful, false otherwise
    @discardableResult
    public func appendText(_ text: String, to url: URL) -> Bool {
        do {
            if fileManager.fileExists(atPath: url.path) {
                let fileHandle = try FileHandle(forWritingTo: url)
                defer { fileHandle.closeFile() }
                fileHandle.seekToEndOfFile()
                fileHandle.write(text.data(using: .utf8) ?? Data())
            } else {
                try text.write(to: url, atomically: true, encoding: .utf8)
            }
            return true
        } catch {
            print("HPFileManager: Failed to append text to \(url.path) - \(error.localizedDescription)")
            return false
        }
    }
}

// MARK: - Utility Operations
extension HPFileManager {
    
    /// Gets the size of a file or directory
    /// - Parameter url: The file or directory URL
    /// - Returns: Size in bytes, or nil if failed
    public func sizeOfItem(at url: URL) -> Int64? {
        do {
            let attributes = try fileManager.attributesOfItem(atPath: url.path)
            return attributes[.size] as? Int64
        } catch {
            print("HPFileManager: Failed to get size of item at \(url.path) - \(error.localizedDescription)")
            return nil
        }
    }
}
