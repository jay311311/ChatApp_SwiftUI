//
//  ChatService.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-06-11.
//

import Foundation
import Combine

protocol ChatServiceType {
    func addChat(_ chat: Chat, to chatRoomId: String) -> AnyPublisher<Chat, ServiceError>
    func observeChat(chatRoomId: String) -> AnyPublisher<Chat?, Never>
    func removeObservedHandlers()
}


class ChatService: ChatServiceType {

    private var dbRepository: ChatDBRepositoryType
    
    func addChat(_ chat: Chat, to chatRoomId: String) -> AnyPublisher<Chat, ServiceError> {
        <#code#>
    }
    
    func observeChat(chatRoomId: String) -> AnyPublisher<Chat?, Never> {
        <#code#>
    }
    
    func removeObservedHandlers() {
        <#code#>
    }
}
