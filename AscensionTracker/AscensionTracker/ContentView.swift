//
//  ContentView.swift
//  AscensionTracker
//
//  Created by Regie Lopez
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            // Dark mode background
            Color(red: 0.05, green: 0.05, blue: 0.1).ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header: User Profile
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.cyan)
                    
                    VStack(alignment: .leading) {
                        Text("Hunter Name")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text("Rank: B-Class | Level 5")
                            .font(.subheadline)
                            .foregroundColor(.cyan)
                        ProgressView(value: 0.6)
                            .tint(.cyan)
                    }
                    Spacer()
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(15)
                
                // Activity Streak Card
                VStack {
                    Text("Activity Streak")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text("7 Days")
                        .font(.system(size: 40, weight: .black, design: .monospaced))
                        .foregroundColor(.cyan)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(15)
                
                // Friends Leaderboard
                VStack(alignment: .leading, spacing: 10) {
                    Text("Guild Leaderboard")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    FriendRow(name: "Alex", score: "1200 XP")
                    FriendRow(name: "Sam", score: "950 XP")
                    FriendRow(name: "Jen", score: "800 XP")
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(15)
                
                // Action Buttons
                HStack(spacing: 15) {
                    ActionButton(title: "Quest Log", icon: "scroll.fill")
                    ActionButton(title: "Calendar", icon: "calendar")
                }
                ActionButton(title: "Growth Journal", icon: "book.closed.fill")
                
                Spacer()
            }
            .padding()
        }
    }
}

// Sub-view for the Leaderboard rows
struct FriendRow: View {
    let name: String
    let score: String
    var body: some View {
        HStack {
            Text(name).foregroundColor(.white)
            Spacer()
            Text(score).foregroundColor(.cyan).fontWeight(.bold)
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
        .background(Color.black.opacity(0.3))
        .cornerRadius(8)
    }
}

// Sub-view for the Action Buttons
struct ActionButton: View {
    let title: String
    let icon: String
    var body: some View {
        HStack {
            Image(systemName: icon)
            Text(title).fontWeight(.bold)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.cyan.opacity(0.2))
        .foregroundColor(.cyan)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.cyan, lineWidth: 1)
        )
    }
}
