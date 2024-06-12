//
//  HomeViewModel.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-04-25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    enum Action {
        case load
        case requestContacts
        case presentView(HomeModalDestination)
        case goToChat(User)
    }
    
    @Published var phase: Phase = .notRequested
    @Published var myUser: User?
    @Published var users: [User] = []
    @Published var modalDestination: HomeModalDestination?
    
    var userId: String
    
    private var container: DiContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DiContainer, userId: String) {
        self.container = container
        self.userId = userId
    }
    
    func send(action: Action) {
        switch action {
        case .load:
            phase = .loading
            
            container.services.userService.getUser(userId: userId)
                .handleEvents(receiveOutput: { [weak self] user in
                    self?.myUser = user
                })
                .flatMap { [weak self] user -> AnyPublisher<[User], ServiceError> in
                    guard let `self` = self else { return Empty().eraseToAnyPublisher() }
                    return self.container.services.userService.loadUsers(id: user.id)
                }
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.phase = .fail
                    }
                } receiveValue: { [weak self] users in
                    self?.phase = .success
                    self?.users = users
                }.store(in: &subscriptions)
            
        case let .presentView(destination):
            modalDestination = destination
            
        case .requestContacts:
            container.services.contactService.fetchContact()
                .flatMap { [weak self] users -> AnyPublisher<Void, ServiceError> in
                    guard let `self` = self else { return Empty().eraseToAnyPublisher() }
                    return self.container.services.userService.addUserAfterContact(users: users)
                }
                .flatMap { [weak self] _ -> AnyPublisher<[User], ServiceError> in
                    guard let `self` = self else { return Empty().eraseToAnyPublisher() }
                    return self.container.services.userService.loadUsers(id: self.userId)
                }
                .receive(on: DispatchQueue.main)
                .sink { completion in
                } receiveValue: { [weak self] users in
                    self?.phase = .success
                    self?.users = users
                }.store(in: &subscriptions)
            
        case let .goToChat(otherUser):
            container.services.chatRoomService.createChatRoomIfNeeded(myUserId: userId, otherUserId: otherUser.id, otherUserName: otherUser.name)
                .sink { completion in
                    
                } receiveValue: { [weak self] chatRoom in
                    guard let `self` = self else { return }
                    self.container.navigator.push(to: .chat(chatRoomId: chatRoom.chatRoomId,
                                                            myId: self.userId,
                                                            otherUserId: otherUser.id))
                }.store(in: &subscriptions)
        }
    }
}
