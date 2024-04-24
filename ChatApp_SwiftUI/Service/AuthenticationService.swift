//
//  AuthenticationService.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-04-24.
//

import Foundation
import Combine
import FirebaseCore
import FirebaseAuth

enum AuthenticationError: Error {
    case clinetIDError
    case tokenError
    case invalidated
}

protocol AuthenticationServiceType {
    func checkAuthenticationState() -> String?
}

class AuthenticationService: AuthenticationServiceType {
    func checkAuthenticationState() -> String? {
        if let user = Auth.auth().currentUser {
            return user.uid
        } else {
            return nil
        }
    }
}



class StubAuthenticationService: AuthenticationServiceType {
    func checkAuthenticationState() -> String? {
        return nil
    }
    
}
