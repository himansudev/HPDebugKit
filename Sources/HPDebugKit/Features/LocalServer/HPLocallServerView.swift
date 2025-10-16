//
//  File.swift
//  HPDebugKit
//
//  Created by Apple on 16/10/25.
//

import SwiftUI
// MARK: - Local Server View
@available(iOS 16.0, macOS 10.15, *)
struct LocalServerView: View {
    
    init() {}
    
    var body: some View {
        VStack {
            Text("Local Server")
                .font(.largeTitle)
                .padding()
            
            Text("Local Server configuration will be implemented here")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
        }
        .navigationTitle("Local Server")
        .navigationBarTitleDisplayMode(.inline)
    }
}
