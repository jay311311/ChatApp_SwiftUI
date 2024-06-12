//
//  ChatItemDirection.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-06-11.
//

import SwiftUI

enum ChatItemDirection {
    case left
    case right
    
    var backgroundColor: Color {
        switch self {
        case .left:
            return .chatColorOhter
        case .right:
            return .chatColorMe
        }
    }
    
    var overlayAlignment: Alignment {
        switch self {
        case .left:
            return .topLeading
        case .right:
            return .topTrailing
        }
    }
    
    var overlayImage: Image {
        switch self {
        case .left:
            return Image(systemName: "sparkle").resizable()
            
        case .right:
            return Image(systemName: "sparkl.").resizable()
        }
    }
}
