//
//  UploadProvider.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-05-03.
//

import Foundation
import Combine
import FirebaseStorage
import FirebaseStorageCombineSwift

enum UploadError: Error {
    case error(Error)
}

protocol UploadProviderType{
    func uploadURL(path: String, data: Data, fileName: String) async throws -> URL
    func uploadURL(path: String, data: Data, fileName: String) -> AnyPublisher<URL, UploadError>
}

class UploadProvider: UploadProviderType {
    
    let storageRef = Storage.storage().reference()
    
    func uploadURL(path: String, data: Data, fileName: String) async throws -> URL {
        let ref = storageRef.child(path).child(fileName)
        let _ = try await ref.putDataAsync(data)
        let url  = try await ref.downloadURL()
        
        return url
    }
    
    func uploadURL(path: String, data: Data, fileName: String) -> AnyPublisher<URL, UploadError> {
        let ref = storageRef.child(path).child(fileName)
        
        return ref.putData(data)
            .flatMap { _ in
                ref.downloadURL()
            }
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
    
    
}
