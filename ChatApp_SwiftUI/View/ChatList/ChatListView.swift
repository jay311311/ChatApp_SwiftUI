//
//  ChatListView.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-06-12.
//

import SwiftUI

struct ChatListView: View {
    @EnvironmentObject var container: DiContainer
    @StateObject var viewModel: ChatListViewModel
    
    var body: some View {
        NavigationStack(path: $container.navigator.destinations) {
            ScrollView {
                NavigationLink(value: NavigatorDestination.search(userId: viewModel.userId)) {
                    SearchButton()
                }
                .padding(.top, 14)
                .padding(.bottom, 14)
                
                ForEach(viewModel.chatRooms, id: \.self) { chatRoom in
                    ChatRoomCell(chatRoom: chatRoom, myUserId: viewModel.userId)
                }
            }
            .navigationTitle("Chat")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: NavigatorDestination.self) {
                NavigatorRoutingView(destination: $0)
            }
            .onAppear {
                viewModel.send(action: .load)
            }
        }
    }
}

fileprivate struct ChatRoomCell: View {
    let chatRoom: ChatRoom
    let myUserId: String
    
    var body: some View {
        NavigationLink(value: NavigatorDestination.chat(chatRoomId: chatRoom.chatRoomId,
                                                        myId: myUserId,
                                                         otherUserId: chatRoom.otherUseId)) {
            HStack(spacing: 8) {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 40, height: 40)
                VStack(alignment: .leading, spacing: 3) {
                    Text(chatRoom.otherUserName)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.bkText)
                    if let lastMessage = chatRoom.lastMessage {
                        Text(lastMessage)
                            .font(.system(size: 12))
                            .foregroundColor(.greyDeep)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 17)
        }
    }
}

//#Preview {
//    ChatListView(viewModel: .init(container: Self.container, userId: "user1_id"))
//        .environmentObject(Self.container)
//}
