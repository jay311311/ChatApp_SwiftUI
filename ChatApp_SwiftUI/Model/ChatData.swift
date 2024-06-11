//
//  ChatData.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-06-11.
//

import Foundation

struct ChatData: Hashable, Identifiable {
    // dateStr == id ???
    var dateStr: String
    var chats: [Chat]
    var id: String { dateStr }
}
