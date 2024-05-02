//
//  OtherProfileViewModel.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-05-02.
//

import Foundation
import Combine

class OtherProfileViewModel: ObservableObject {
    @Published var userInfo: User?
    
    private let userId: String
    private let container: DiContainer
    
    init(userId: String, container: DiContainer) {
        self.userId = userId
        self.container = container
    }
    
    func getUser() async {
        if let user = try? await container.services.userService.getUser(userId: userId) {
            userInfo = user
        }
        
    }
    
}
