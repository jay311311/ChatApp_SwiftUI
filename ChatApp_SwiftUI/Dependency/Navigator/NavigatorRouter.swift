//
//  NavigatorRouter.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-05-01.
//

import Foundation
import Combine

protocol NavigationRoutable {
    var destinations:[NavigatorDestination] { get set }
    
    func pop()
    func popToRoot()
    func push(to view: NavigatorDestination)
}

class NavigatorRouter: NavigationRoutable & ObservableObjectSettable{
    
    var destinations: [NavigatorDestination] = [] {
        didSet{
            objectWillChange?.send()
        }
    }
    
    var objectWillChange: ObservableObjectPublisher?
    
    
    func push(to view: NavigatorDestination) {
        destinations.append(view)
    }
    
    func popToRoot() {
        destinations = []
    }
    
    func pop() {
        destinations.popLast()
    }
}
