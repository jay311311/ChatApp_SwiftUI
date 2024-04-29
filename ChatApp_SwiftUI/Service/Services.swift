//
//  Services.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-04-24.
//

import Foundation


protocol ServiceType {
    var authService: AuthenticationServiceType { get set }
    var userService: UserServiceType { get set }

}

class Services: ServiceType {
    var authService: AuthenticationServiceType
    var userService: UserServiceType
    
    init() {
        self.authService = AuthenticationService()
        self.userService = UserService(dbRepository: UserDBRepository(reference: DBReference()))
    }
}

class StubService: ServiceType {
    var authService: AuthenticationServiceType = StubAuthenticationService()
    var userService: UserServiceType = StubUserService()
}
