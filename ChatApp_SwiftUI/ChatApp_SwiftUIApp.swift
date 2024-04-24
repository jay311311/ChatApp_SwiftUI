//
//  ChatApp_SwiftUIApp.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-04-23.
//

import SwiftUI

@main
struct ChatApp_SwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}