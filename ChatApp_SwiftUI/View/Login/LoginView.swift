//
//  LoginView.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-04-24.
//

import SwiftUI
import AuthenticationServices


struct LoginView: View {
    @Environment(\.dismiss) var dismiss  // for backButton Customize
    @EnvironmentObject var authViewModel: AuthenticationViewModel

    var body: some View {
        VStack(alignment: .leading){
            Group{
                Text("Login")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(.bkText)
                    .padding(.top,80)
                
                Text("로그인 방식을 선택해주세요")
                    .font(.system(size: 14))
                    .foregroundStyle(.greyDeep)
                
            }.padding(.horizontal, 30)
            Spacer()
            
            Button {
                authViewModel.send(action: .googleLogin)
//                authViewModel.send(action: .logout)

            } label: {
                Text("Google Login")
            }.buttonStyle(LoginButtonStyle(textColor: .bkText, borderColor: .greyLight))
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName:"chevron.backward")
                        .foregroundStyle(.bkText)
                }

            }
        }
        .overlay {
            if authViewModel.isLoading {
                ProgressView()
            }
        }
    }
}

#Preview {
    LoginView()
}
