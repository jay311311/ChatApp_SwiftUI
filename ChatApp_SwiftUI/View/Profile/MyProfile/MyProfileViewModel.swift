//
//  MyProfileViewModel.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-05-02.
//

import Foundation
import Combine
import SwiftUI
import PhotosUI

class MyProfileViewModel: ObservableObject {
    
    @Published var userInfo: User?
    @Published var isPresendDescView: Bool = false
    @Published var imageSelector: PhotosPickerItem?{
        didSet{
            Task{
                await uploadProfileImage(pickerItem: imageSelector)
            }
        }
    }
    
    private let userId: String
    private let container: DiContainer
    
    init(userId: String,
         container: DiContainer) {
        self.userId = userId
        self.container = container
    }
    
    func getUser() async {
        if let user = try? await container.services.userService.getUser(userId: userId) {
            userInfo = user
        }
    }
    
    func updateDescription(description: String) async {
        do {
            try await container.services.userService.updateDescription(userId: userId, text: description)
            userInfo?.description = description
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func uploadProfileImage(pickerItem: PhotosPickerItem?) async {
        guard let pickerItem = pickerItem else  { return }
        do {
            let data = try await container.services.photoPickerService.loadTransterable(from: pickerItem)
            let url = try await container.services.uploadService.uploadImage(source: .profile(userId: userId), data: data)
            try await container.services.userService.updateProfileURL(userId: userId, urlString: url.absoluteString)
            userInfo?.profileURL = url.absoluteString
        } catch {
            print(error.localizedDescription)
        }
    }
}
