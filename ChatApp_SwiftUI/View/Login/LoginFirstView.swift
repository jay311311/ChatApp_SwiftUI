//
//  LoginView.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-04-24.
//

import SwiftUI

struct LoginFirstView: View {
    @State var isPresentLoginView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing:20) {
                Spacer()

                Text("Welcome")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundStyle(.bkText)
                Text("무료 메신저를 즐겨보세요!")
                    .font(.system(size: 12))
                    .foregroundStyle(.greyDeep)
                Spacer()
                Button {
                    isPresentLoginView.toggle()
                } label: {
                    Text("Log In")
                }.buttonStyle(LoginButtonStyle(textColor: .lineApp))
            }
            .navigationDestination(isPresented: $isPresentLoginView) {
                LoginView()
            }
        }
    }
}

#Preview {
    LoginFirstView()
}
