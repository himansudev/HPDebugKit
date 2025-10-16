//
//  HPLocallServerView.swift
//  HPDebugKit
//
//  Created by Apple on 16/10/25.
//

import SwiftUI

// MARK: - Local Server View
@available(iOS 16.0, macOS 10.15, *)
struct HPLocalServerView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    private var saveNetworkCallEnabled: Binding<Bool> {
        Binding(
            get: {
                HPUserDefaultsManager.shared.fetch(Bool.self, forKey: .saveNetworkCallEnabled) ?? false
            },
            set: { newValue in
                HPUserDefaultsManager.shared.save(newValue, forKey: .saveNetworkCallEnabled)
            }
        )
    }
    
    var body: some View {
        VStack(spacing: 20) {
            headerSection
            settingsSection
            Spacer()
        }
        .background(Color(.systemBackground))
        .navigationBarHidden(true)
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .fontWeight(.medium)
                    Text("Back")
                        .font(.headline)
                }
                .foregroundColor(.blue)
            }
            
            Spacer()
            
            Text("Local Server")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
            
            // Invisible spacer to center the title
            HStack(spacing: 8) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .fontWeight(.medium)
                Text("Back")
                    .font(.headline)
            }
            .opacity(0)
        }
        .padding(.horizontal)
    }
    
    // MARK: - Settings Section
    private var settingsSection: some View {
        VStack(spacing: 16) {
            saveNetworkCallToggle
        }
        .padding(.horizontal)
    }
    
    // MARK: - Save Network Call Toggle
    private var saveNetworkCallToggle: some View {
        HStack {
            Image(systemName: "network")
                .foregroundColor(.blue)
                .font(.title2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Save Network Call")
                    .font(.headline)
                Text("Automatically save network requests and responses")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Toggle("", isOn: saveNetworkCallEnabled)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
