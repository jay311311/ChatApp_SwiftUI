//
//  SearchDataController.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-05-14.
//

import Foundation
import CoreData

protocol DataControllable {
    var persistantContainer: NSPersistentContainer { get set }
}

class SearchDataController: DataControllable {
    var persistantContainer = NSPersistentContainer(name: "Search")

    init() {
        persistantContainer.loadPersistentStores { description, error in
            if let error {
                print("Core data failed: ", error.localizedDescription)
            }
        }
    }
}
