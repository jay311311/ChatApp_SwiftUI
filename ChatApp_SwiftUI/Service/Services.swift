//
//  Services.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-04-24.
//

import Foundation


protocol ServiceType {
    var authService: AuthenticationServiceType { get set }
    var userService: UserServiceType { get set }
    var contactService: ContactServiceType { get set }
    var uploadService: UploadServiceType { get set }
    var photoPickerService: PhotoPickerServiceType { get set }
    var imageCacheService: ImageCacheServiceType { get set }
    var chatRoomService: ChatRoomServiceType { get set }
    var chatService: ChatServiceType { get set }
}

class Services: ServiceType {
    var authService: AuthenticationServiceType
    var userService: UserServiceType
    var contactService: ContactServiceType
    var uploadService: UploadServiceType
    var photoPickerService: PhotoPickerServiceType
    var imageCacheService: ImageCacheServiceType
    var chatRoomService: ChatRoomServiceType
    var chatService: ChatServiceType
    
    init() {
        self.authService = AuthenticationService()
        self.userService = UserService(dbRepository: UserDBRepository(reference: DBReference()))
        self.contactService = ContactService()
        self.uploadService = UploadService(provider: UploadProvider())
        self.photoPickerService = PhotoPickerService()
        self.imageCacheService = ImageCacheService(memoryStorage: MemoryStorage(), diskStorage: DiskStorage())
        self.chatRoomService = ChatRoomService(dbRepository: ChatRoomDBRepository(reference: DBReference()))
        self.chatService = ChatService(dbRepository: ChatDBRepository(reference: DBReference()))
    }
}

class StubService: ServiceType {
    var authService: AuthenticationServiceType = StubAuthenticationService()
    var userService: UserServiceType = StubUserService()
    var contactService: ContactServiceType = StubContactService()
    var uploadService: UploadServiceType = StubUploadService()
    var photoPickerService: PhotoPickerServiceType = PhotoPickerService()
    var imageCacheService: ImageCacheServiceType = StubImageCacheService()
    var chatRoomService: ChatRoomServiceType = StubChatRoomService()
    var chatService: ChatServiceType = StubChatService()
}
