//
//  File.swift
//  HPDebugConfigSDK
//
//  Created by Apple on 13/10/25.
//

import Foundation
struct HPPathManager{
    
    static func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
