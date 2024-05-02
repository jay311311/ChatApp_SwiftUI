//
//  NavigatorDestination.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-05-01.
//

import Foundation

enum NavigatorDestination: Hashable {
    case chat(chatRoomId: String, myId: String, otherUserId: String)
    case search(userId: String)
}
