//
//  ChatView.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-05-01.
//

import SwiftUI
import PhotosUI

struct ChatView: View {
    @StateObject var viewModel: ChatViewModel
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                if viewModel.chatDataList.isEmpty {
                    Color.chatBg
                } else {
                    contentView
                }
            }
            .onChange(of: viewModel.chatDataList.last?.chats) { newValue in
                proxy.scrollTo(newValue?.last?.id, anchor: .bottom)
            }
        }
        .background(Color.chatBg)
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .tabBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.chatBg, for: .navigationBar)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    viewModel.send(action: .pop)
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                }
                
                Text(viewModel.otherUser?.name ?? "Chat Room Name")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.bkText)
            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Image(systemName: "clock")
                    .resizable()
                    .frame(width: 16, height: 16)

                Image(systemName: "bookmark")
                    .resizable()
                    .frame(width: 16, height: 16)

                Image(systemName: "gearshape")
                    .resizable()
                    .frame(width: 16, height: 16)

            }
        }
        .keyboardToolbar(height: 50) {
            HStack(spacing: 13) {
                Button {
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 19, height: 19)

                }
                PhotosPicker(selection: $viewModel.imageSelection,
                             matching: .images) {
                    
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 19, height: 19)
                }
                
                Button {
                } label: {
                    Image(systemName: "camera")
                        .resizable()
                        .frame(width: 19, height: 19)

                }
                
                TextField("", text: $viewModel.message)
                    .font(.system(size: 16))
                    .foregroundColor(.blackFix)
                    .focused($isFocused)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 13)
                    .background(Color.greyCool)
                    .cornerRadius(20)
                
                Button {
                    viewModel.send(action: .addChat(viewModel.message))
                    isFocused = false
                } label: {
                    Image(systemName: "paperplane")
                        .resizable()
                        .frame(width: 19, height: 19)

                }
                .disabled(viewModel.message.isEmpty)
            }
            .padding(.horizontal, 27)
        }
        .onAppear {
            viewModel.send(action: .load)
        }
    }
    
    var contentView: some View {
        ForEach(viewModel.chatDataList) { chatData in
            Section {
                ForEach(chatData.chats) { chat in
                    if let message = chat.message {
                        ChatItemView(message: message,
                                     direcion: viewModel.getDirection(id: chat.userId),
                                     date: chat.date)
                        .id(chat.chatId)
                        .accessibilityElement(children: .combine)
                    } else if let photoURL = chat.photoURL {
                        ChatImageItemView(urlString: photoURL,
                                          direction: viewModel.getDirection(id: chat.userId),
                                          date: chat.date)
                        .id(chat.chatId)
                    }
                    
                }
            } header: {
                headerView(dateStr: chatData.dateStr)
            }
        }
    }
    
    func headerView(dateStr: String) -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 76, height: 20)
                .background(Color.chatNotice)
                .cornerRadius(50)
            Text(dateStr)
                .font(.system(size: 10))
                .foregroundColor(.bgWh)
        }
        .padding(.top)
    }
}

#Preview {
    NavigationStack {
        ChatView(viewModel: .init(container: .stub,
                                  chatRoomId: "chatRoom1_id",
                                  myUserId: "user1_id",
                                  otherUserId: "user2_id"))
    }
}
