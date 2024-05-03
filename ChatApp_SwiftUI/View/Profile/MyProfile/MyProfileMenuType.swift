//
//  MyProfileMenuType.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-05-03.
//

import Foundation

enum MyProfileMenuType: Hashable, CaseIterable {
    case studio
    case decorate
    case keep
    case story
    
    var description: String {
        switch self {
        case .studio:
            return "Studio"
        case .decorate:
            return "Decoration"
        case .keep:
            return "Keep"
        case .story:
            return "Story"
        }
    }
    
    var imageName: String {
        switch self {
        case .studio:
            return "face.smiling"
        case .decorate:
            return "paintpalette"
        case .keep:
            return "bookmark"
        case .story:
            return "play.circle"
        }
    }
}
