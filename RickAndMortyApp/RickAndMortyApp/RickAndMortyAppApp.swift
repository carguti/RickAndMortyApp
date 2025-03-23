//
//  RickAndMortyAppApp.swift
//  RickAndMortyApp
//
//  Created by Carlos Gutiérrez Casado on 22/3/25.
//

import SwiftUI

@main
struct RickAndMortyAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}
