//
//  AuthenticationView.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-04-24.
//

import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject var container: DiContainer
    @StateObject var authViewModel: AuthenticationViewModel
    var body: some View {
        VStack{
            switch authViewModel.authenticationState {
            case .unauthenticated:
                LoginFirstView()
            case .authenticated:
                MainTabView()
            }
        }.onAppear {
            authViewModel.send(action: .checkAuthenticationState)
       }
       
    }
}

#Preview {

    AuthenticationView(authViewModel: .init(container: .init(services: StubService())))
//        .environmentObject(container)
}
