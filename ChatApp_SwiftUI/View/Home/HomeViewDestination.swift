//
//  HomeViewDestination.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-04-29.
//

import Foundation

enum HomeModalDestination: Hashable, Identifiable {
    case myProfile
    case otherProfile(String)
    case setting
    
    var id: Int {
        hashValue
    }
}
