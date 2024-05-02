//
//  OtherProfileView.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-04-29.
//

import SwiftUI

struct OtherProfileView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: OtherProfileViewModel
    
    var goToChat: (User) -> Void
    
    var body: some View {
        NavigationStack{
            ZStack {
                Image("profileBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                LinearGradient(gradient: Gradient(colors: [ Color.black.opacity(0.1)]), startPoint: .zero, endPoint: .zero)
                    .ignoresSafeArea()
               
                
                VStack{
                    Spacer()
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding(.bottom, 16)
                    
                    Text("\(viewModel.userInfo?.name ?? "unknown")")
                        .font(.system(size: 24,weight: .bold))
                    Spacer()
                    menuView
                }
            }
            .foregroundStyle(.whiteFix)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.whiteFix)
                    }
                }
            }
            .task {
                await viewModel.getUser()
            }
        }
    }
    
    
    var menuView: some View {
        HStack(alignment: .center, spacing: 50) {
            ForEach(OtherProfileMenuType.allCases, id: \.self) { type in
                Button {
                    if type == .chat, let userinfo = viewModel.userInfo  {
                        dismiss()
                        goToChat(userinfo)
                    }
                } label: {
                    VStack(spacing: 15){
                        Image(systemName: type.ImageName)
                            .frame(width: 50)
                        Text("\(type.description)")
                    }
                }
            }
        }
    }
    
}

#Preview {
    OtherProfileView(viewModel: .init(userId: "userId_2", container: .stub), goToChat: {_ in
        print("Hello, OtherProfileView!")
    })
}
