//
//  ChatItemView.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-06-11.
//

import SwiftUI

struct ChatItemView: View {
    let message: String
    let direcion: ChatItemDirection
    let date: Date
    
    var body: some View {
        HStack(alignment: .bottom) {
            if direcion == .right {
                Spacer()
                dateView
            }
            
            Text(message)
                .font(.system(size: 14))
                .foregroundColor(.blackFix)
                .padding(.vertical, 9)
                .padding(.horizontal, 20)
                .background(direcion.backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .overlay(alignment: direcion.overlayAlignment) {
                    direcion.overlayImage
                }
            
            if direcion == .left {
                dateView
                Spacer()
            }
        }
        .padding(.horizontal, 35)
        .padding(.bottom)
    }
    
    var dateView: some View {
        Text(date.toChatTime)
            .font(.system(size: 10))
            .foregroundColor(.greyDeep)
    }
}

#Preview {
    ChatItemView(message: "hi.", direcion: .left, date: Date())
}
