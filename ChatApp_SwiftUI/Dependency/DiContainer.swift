//
//  DiContainer.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-04-24.
//

import Foundation

class DiContainer: ObservableObject {
    var services: ServiceType
    var navigator: NavigationRoutable & ObservableObjectSettable

    init(services: ServiceType, 
         navigator: NavigationRoutable & ObservableObjectSettable = NavigatorRouter()) {
        self.services = services
        self.navigator = navigator
        
        self.navigator.setObjectWillChange(objectWillChange)
    }
}

extension DiContainer {
    static var stub: DiContainer {
        .init(services: StubService() )
    }
}
