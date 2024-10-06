//
//  Media.swift
//  Mini Calculator
//
//  Created by Akha on 06.10.2024.
//

import Foundation

enum MediaType {
    case image
    case video
    case unsupported
}

struct MediaItem: Identifiable {
    let id = UUID()
    let name: String
    
    // Computed property to determine media type based on file extension
    var type: MediaType {
        let fileExtension = (name as NSString).pathExtension.lowercased()
        switch fileExtension {
        case "jpg", "jpeg", "png":
            return .image
        case "mp4", "mov", "m4v":
            return .video
        default:
            return .unsupported
        }
    }
}
