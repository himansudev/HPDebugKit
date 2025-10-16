//
//  FeatureType.swift
//  HPDebugKit
//
//  Created by Apple on 16/10/25.
//


// MARK: - Feature Types
@available(iOS 16.0, macOS 10.15, *)
enum HPFeatureType: CaseIterable, Hashable {
    case localServer
    
    var title: String {
        switch self {
        case .localServer:
            return "Local Server"
        }
    }
    
    var subtitle: String {
        switch self {
        case .localServer:
            return "Enable local debugging server"
        }
    }
    
    var iconName: String {
        switch self {
        case .localServer:
            return "server.rack"
        }
    }
}
