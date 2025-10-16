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
public struct HPDebugKitView: View {
    
    public init() {}
    
    @State private var navigationPath = NavigationPath()
    
    @available(iOS 16.0, macOS 10.15, *)
    public var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                versionView
                featuresList
            }
            .navigationDestination(for: HPFeatureType.self) { feature in
                switch feature {
                case .localServer:
                    LocalServerView()
                }
            }
        }
    }
    
    private var featuresList: some View {
        List {
            ForEach(HPFeatureType.allCases, id: \.self) { feature in
                NavigationLink(value: feature) {
                    HStack {
                        Image(systemName: feature.iconName)
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text(feature.title)
                                .font(.headline)
                            Text(feature.subtitle)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
//                        Image(systemName: "chevron.right")
//                            .foregroundColor(.secondary)
//                            .font(.caption)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .listStyle(PlainListStyle())
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
