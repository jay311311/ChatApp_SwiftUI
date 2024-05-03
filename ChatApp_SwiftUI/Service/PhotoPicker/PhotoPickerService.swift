//
//  PhotoPickerService.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-05-02.
//

import Foundation
import SwiftUI
import PhotosUI

enum PhotoPickerError: Error {
    case importFailed
}

protocol PhotoPickerServiceType {
    func loadTransterable(from imageSelection: PhotosPickerItem) async throws -> Data
}

class PhotoPickerService: PhotoPickerServiceType {
    func loadTransterable(from imageSelection: PhotosPickerItem) async throws -> Data {
        guard let image = try await imageSelection.loadTransferable(type: PhotoImage.self) else  {
           throw PhotoPickerError.importFailed
        }
        return image.data
    }
}
