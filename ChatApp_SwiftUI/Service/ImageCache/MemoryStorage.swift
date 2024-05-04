//
//  MemoryStorage.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-05-04.
//

import UIKit

protocol MemoryStorageType {
    func getValue(for key: String) -> UIImage?
    func storeValue(for key: String, image: UIImage)
}

class MemoryStorage: MemoryStorageType {
    
    let cache = NSCache<NSString, UIImage>()
    
    func getValue(for key: String) -> UIImage? {
        cache.object(forKey: NSString(string: key))
    }
    
    func storeValue(for key: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: key))
    }
    
    
}
