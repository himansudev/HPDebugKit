//
//  HPSettingsView.swift
//  HPDebugKit
//
//  Created by Apple on 15/10/25.
//

import Foundation

#if canImport(SwiftUI)
import SwiftUI

@available(iOS 16.0, macOS 10.15, *)
public struct HPSettingsView: View {
    
    public init() {}
    
    @available(iOS 16.0, macOS 10.15, *)
    public var body: some View {
        VStack {
            versionView
            Text("Local Server : \(localServerEnabled ? "Enabled" : "Disabled")")
        }
    }
    
    
    private var localServerEnabled: Bool {
        if let localServerEnabled = HPUserDefaultsManager.shared.fetch(
            Bool.self,
            forKey: .localServerEnabled
        ){
            return localServerEnabled
        }
        return false
    }
    
    @available(iOS 16.0, macOS 10.15, *)
    private var versionView: some View {
        VStack {
            Text("HPDebugKit")
                .font(.title)
            Text("Version: \(HPDebugKit.shared.getVersion())")
                .font(.caption)
        }
    }
}

#else
// Fallback for when SwiftUI is not available
@available(iOS 16.0, macOS 10.15, *)
public struct HPSettingsView {
    public init() {}
}
#endif
