//
//  UploadService.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-05-02.
//

import Foundation
import Combine

protocol UploadServiceType {
    func uploadImage(source: UploadSourceType, data: Data) -> AnyPublisher<URL, ServiceError>
    func uploadImage(source: UploadSourceType, data: Data) async throws -> URL
}

class UploadService: UploadServiceType {
    private let provider: UploadProviderType
    
    init(provider: UploadProviderType) {
        self.provider = provider
    }
    
    func uploadImage(source: UploadSourceType, data: Data) -> AnyPublisher<URL, ServiceError> {
        provider.uploadURL(path: source.path, data: data, fileName: UUID().uuidString)
            .mapError { .error($0) }
            .eraseToAnyPublisher()
    }
    
    func uploadImage(source: UploadSourceType, data: Data) async throws -> URL {
        let url = try await provider.uploadURL(path: source.path, data: data, fileName: UUID().uuidString)
        return url
    }
}

class StubUploadService: UploadServiceType {
    
    func uploadImage(source: UploadSourceType, data: Data) -> AnyPublisher<URL, ServiceError> {
        Empty().eraseToAnyPublisher()
    }
    
    func uploadImage(source: UploadSourceType, data: Data) async throws -> URL {
        return URL(string: "")!
    }
}
