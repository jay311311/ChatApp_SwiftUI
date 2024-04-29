//
//  DBError.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-04-29.
//

import Foundation

enum DBError: Error {
    case error(Error)
    case emptyValue
    case invalidatedType
}
