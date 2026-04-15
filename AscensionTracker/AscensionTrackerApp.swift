//
//  AscensionTrackerApp.swift
//  AscensionTracker
//
//  Created by Regie Lopez
//

import SwiftUI
import FirebaseCore

@main
struct AscensionTrackerApp: App {
    
    // Initialize Firebase directly in the App struct
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
