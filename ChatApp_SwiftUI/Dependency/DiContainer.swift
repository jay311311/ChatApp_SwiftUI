//
//  DiContainer.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-04-24.
//

import Foundation

class DiContainer: ObservableObject {
    var services: ServiceType

    init(services: ServiceType) {
        self.services = services
    }
}

extension DiContainer {
    static var stub: DiContainer {
        .init(services: StubService())
    }
}
