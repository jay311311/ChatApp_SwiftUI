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
        case appleLogin(ASAuthorizationAppleIDRequest)
        case appleLoginCompletion(Result<ASAuthorization, Error>)
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
        case .checkAuthenticationState: break
        default: break
        }
    }
}
