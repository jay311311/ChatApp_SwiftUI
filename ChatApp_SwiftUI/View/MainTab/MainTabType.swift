//
//  MainTabType.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-04-25.
//

import Foundation

enum MainTabType: String, CaseIterable {
    case house
    case message
    case phone
    
    var title: String {
        switch self{
        case .house: "Home"
        case .message: "Message"
        case .phone: "Call"
        }
    }
    
    func imageName(selected: Bool) -> String {
        return rawValue
    }
}
