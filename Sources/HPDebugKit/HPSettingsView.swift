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
            
            Button("Create Documents Directory") {
                
                //                HPFileManager.shared.createDirectory(named: "ABC", in: HPDirectory.documents.url)
                let documentDir = HPDirectory.documents.url.appendingPathComponent("ABC")
                let a = HPFileManager.shared.directoryExists(at: documentDir)
                print("ZZZZ : ",a)
            }
            .padding()
        }
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
