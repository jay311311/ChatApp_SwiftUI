//
//  OtherProfileView.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-04-29.
//

import SwiftUI

struct OtherProfileView: View {
    @Environment(\.dismiss) var dismiss
    var goToChat: () -> Void

    var body: some View {
        VStack {
            Text("Hello, OtherProfileView!")
            Button {
                dismiss()
                goToChat()
            } label: {
                Text("goToChat() 호출되는지 확인 버튼")
            }

        }
    }
}

#Preview {
    OtherProfileView{
        print("Hello, OtherProfileView!")
    }
}
