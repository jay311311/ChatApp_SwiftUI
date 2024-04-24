//
//  AppDelegate.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-04-23.
//

import UIKit
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
