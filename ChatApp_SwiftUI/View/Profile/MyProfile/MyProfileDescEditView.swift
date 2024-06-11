//
//  MyProfileDescEditView.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-05-03.
//

import SwiftUI

struct MyProfileDescEditView: View {
    @Environment(\.dismiss) var dismiss
    @State var description: String
    
    var onCompleted: (String) -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Please enter a status message", text: $description)
                    .multilineTextAlignment(.center)
            }
            .toolbar {
                Button("Done") {
                    dismiss()
                    onCompleted(description)
                }
                .disabled(description.isEmpty)
            }
        }
    }
}

struct MyProfileDescEditView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileDescEditView(description: "") { _ in
            
        }
    }
}
