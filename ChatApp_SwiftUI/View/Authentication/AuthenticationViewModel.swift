//
//  AuthenticationViewModel.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-04-24.
//

import Foundation
import Combine
import AuthenticationServices

enum AuthenticationState {
    case unauthenticated
    case authenticated
}

class AuthenticationViewModel: ObservableObject {
    
    enum Action {
        case checkAuthenticationState
        case googleLogin
        case requestPushNotification
        case setPushToken
        case logout
    }
    
    @Published var authenticationState:AuthenticationState = .unauthenticated
    @Published var isLoading: Bool = false
    
    var userId: String?
    
    private var currentNonce: String?
    private var container: DiContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DiContainer) {
        self.container = container
    }
    
    func send(action: Action) {
        switch action {
        case .checkAuthenticationState:
            if let userId = container.services.authService.checkAuthenticationState() {
                self.userId = userId
                self.authenticationState = .authenticated
            }
        case .googleLogin:
            isLoading = true
            
            container.services.authService.signInWithGoogle()
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.isLoading = false
                    }
                } receiveValue: { [weak self] user in
                    self?.userId = user.id
                    self?.authenticationState = .authenticated
                }.store(in: &subscriptions)

        case .logout:
            container.services.authService.logout()
                .sink { completion in
                    // TODO:
                } receiveValue: { [weak self] _ in
                    self?.authenticationState = .unauthenticated
                    self?.userId = nil
                }.store(in: &subscriptions)
        default: break
        }
    }
}
