//
//  NavigatorRoutingView.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-05-01.
//

import SwiftUI

struct NavigatorRoutingView: View {
    @EnvironmentObject var container: DiContainer
    @State var destination: NavigatorDestination
    
    var body: some View {
        switch destination {
        case let .chat(chatRoomId, myId, otherUserId) :
            ChatView(viewModel: .init(container: container, chatRoomId: chatRoomId, myUserId: myId, otherUserId: otherUserId))
        case let .search(userId):
            SearchView(viewModel: .init(container: container, userId: userId))
        }
    }
}

//#Preview {
//    NavigatorRoutingView(destination: .search(userId: User.stub1.id))
//}
