// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public final class HPDebugKit {
    public static let shared = HPDebugKit()
    
    private init() {}
    
    public func getVersion() -> String {
        return HPDebugKitVersion.version
    }
    
    public func getFullVersion() -> String {
        return HPDebugKitVersion.fullVersion
    }
    
    public func getBuildNumber() -> String {
        return HPDebugKitVersion.buildNumber
    }
    
    public func getDebugInfo() -> [String: Any] {
        return [
            "version": getVersion(),
            "fullVersion": getFullVersion(),
            "buildNumber": getBuildNumber(),
            "platform": "iOS",
            "minimumIOSVersion": "16.0",
            "timestamp": Date().timeIntervalSince1970
        ]
    }
}
