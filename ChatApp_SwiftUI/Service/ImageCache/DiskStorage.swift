//
//  DiskStorage.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-05-04.
//

import UIKit

protocol DiskStorageType {
    func getValue(for key: String) throws -> UIImage?
    func storageValue(for key: String, image: UIImage) throws
}

class DiskStorage: DiskStorageType {
    private let fileManager: FileManager
    private let directURL: URL
    
    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
        self.directURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathComponent("ImageCache")
        
        createDirectory()
    }
    
    func createDirectory(){
        guard !fileManager.fileExists(atPath: directURL.path()) else { return }
        
        do {
            try fileManager.createDirectory(atPath: directURL.path(), withIntermediateDirectories: true)
        } catch {
            print(" createDirectoryError = \(error)")
        }
    }
    
    func cacheFileURL(for key: String) -> URL {
        let fileName = sha256(key)
        return directURL.appendingPathComponent(fileName, isDirectory: false)
    }
    
    
    func getValue(for key: String) throws -> UIImage? {
        let fileUrl = cacheFileURL(for: key)
        
        guard fileManager.fileExists(atPath: fileUrl.path()) else { return nil }
        let data = try Data(contentsOf: fileUrl)
        return UIImage(data: data)
    }
    
    func storageValue(for key: String, image: UIImage) throws {
        let data = image.jpegData(compressionQuality: 0.5)
        let fileUrl = cacheFileURL(for: key)
        
        try data?.write(to: fileUrl)
    }
    
}
