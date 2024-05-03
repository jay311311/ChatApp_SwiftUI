//
//  UploadProvider.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-05-03.
//

import Foundation
import FirebaseStorage
import FirebaseStorageCombineSwift

protocol UploadProviderType{
    func uploadURL(path: String, data: Data, fileName: String) async throws -> URL
}

class UploadProvider: UploadProviderType {
    
    let storafeRef = Storage.storage().reference()
    
    func uploadURL(path: String, data: Data, fileName: String) async throws -> URL {
        let ref = storafeRef.child(path).child(fileName)
        let _ = try await ref.putDataAsync(data)
        let url  = try await ref.downloadURL()
        
        return url
    }
    
    
}
