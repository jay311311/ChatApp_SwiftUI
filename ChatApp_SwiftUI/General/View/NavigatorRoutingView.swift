//
//  NavigatorRoutingView.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-05-01.
//

import SwiftUI

struct NavigatorRoutingView: View {
    @EnvironmentObject var DiContainer: DiContainer
    @State var destination: NavigatorDestination
    var body: some View {
        switch destination {
        case let .chat(chatRoomId, myId, otherUserId) :
            ChatView()
                .foregroundStyle(.blue)
        case let .search(userId):
            SearchView()
                .foregroundStyle(.green)

        }
    }
}

//#Preview {
//    NavigatorRoutingView(destination: .search(userId: User.stub1.id))
//}