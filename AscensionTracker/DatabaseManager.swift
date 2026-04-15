//
//  DatabaseManager.swift
//  AscensionTracker
//
//  Created by Regie Lopez
//

import Foundation
import Combine
import FirebaseFirestore

class DatabaseManager: ObservableObject {
    private var db = Firestore.firestore()
    
    func createHunterProfile(username: String, level: Int, hunterClass: String) {
        db.collection("users").document(username).setData([
            "hunterName": username,
            "level": level,
            "rank": hunterClass,
            "streak": 0,
            "dateCreated": Timestamp(date: Date())
        ]) { error in
            if let error = error {
                print("Error saving Hunter stats: \(error)")
            } else {
                print("Hunter profile successfully synced to cloud!")
            }
        }
    }
}
