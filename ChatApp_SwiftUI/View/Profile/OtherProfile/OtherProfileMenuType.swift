//
//  OtherProfileMenuType.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-05-02.
//

import Foundation

enum OtherProfileMenuType: Hashable, CaseIterable {
    case chat
    case phoneCall
    case videoCall
    
    var ImageName: String {
        switch self {
        case .chat:
            "bubble"
        case .phoneCall:
            "phone"
        case .videoCall:
            "video"
        }
    }
    
    var description: String {
        switch self {
        case .chat:
            "Chat"
        case .phoneCall:
            "Call"
        case .videoCall:
            "Video"
        }
    }
}
