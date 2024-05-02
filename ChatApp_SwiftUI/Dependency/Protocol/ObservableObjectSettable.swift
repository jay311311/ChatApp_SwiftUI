//
//  ObservableObjectSettable.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-05-01.
//

import Foundation
import Combine

protocol ObservableObjectSettable: AnyObject  {
    var objectWillChange: ObservableObjectPublisher? { get set }
    
    func setObjectWillChange(_ objectWillChange: ObservableObjectPublisher)
}

extension ObservableObjectSettable {
    func setObjectWillChange(_ objectWillChange: ObservableObjectPublisher) {
        self.objectWillChange = objectWillChange
    }
}
