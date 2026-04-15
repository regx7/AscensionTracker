//
//  ContentView.swift
//  AscensionTracker
//
//  Created by Regie Lopez
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Dark mode background
                Color(red: 0.05, green: 0.05, blue: 0.1).ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Header: User Profile
                    NavigationLink(destination: UserProfileView()) {
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
                    }
                    .buttonStyle(PlainButtonStyle())
                    
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
                    NavigationLink(destination: FriendsListView()) {
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
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // Action Buttons
                    HStack(spacing: 15) {
                        NavigationLink(destination: QuestLogView()) {
                            ActionButton(title: "Quest Log", icon: "scroll.fill")
                        }
                        NavigationLink(destination: CalendarScreenView()) {
                            ActionButton(title: "Calendar", icon: "calendar")
                        }
                    }
                    NavigationLink(destination: GrowthJournalView()) {
                        ActionButton(title: "Growth Journal", icon: "book.closed.fill")
                    }
                    
                    Spacer()
                }
                .padding()
            }
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

// MARK: - Quest Log Screen
struct QuestLogView: View {
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.05, blue: 0.1).ignoresSafeArea()
            VStack {
                Text("Daily Quests").font(.largeTitle).foregroundColor(.white).padding()
                ScrollView {
                    QuestRow(title: "Drink 2L of Water", isCompleted: true)
                    QuestRow(title: "Read 10 pages", isCompleted: true)
                    QuestRow(title: "Code for 1 hour", isCompleted: false)
                    QuestRow(title: "Workout", isCompleted: false)
                }
                Spacer()
                Button(action: { showingAlert = true }) {
                    Image(systemName: "plus.circle.fill").font(.system(size: 50)).foregroundColor(.cyan)
                }
                .padding()
                .alert("New Quest", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("Custom quests will unlock once the backend database is connected!")
                }
            }
        }
    }
}

struct QuestRow: View {
    let title: String
    @State var isCompleted: Bool
    var body: some View {
        HStack {
            Button(action: { isCompleted.toggle() }) {
                Image(systemName: isCompleted ? "checkmark.square.fill" : "square")
                    .foregroundColor(.cyan).font(.title)
            }
            Text(title).foregroundColor(.white).font(.headline)
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

// MARK: - Calendar Screen
struct CalendarScreenView: View {
    let days = ["S", "M", "T", "W", "T", "F", "S"]
    @State private var selectedDay = 17
    
    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.05, blue: 0.1).ignoresSafeArea()
            VStack {
                Text("Calendar").font(.largeTitle).foregroundColor(.white).padding()
                
                // Grid Header
                HStack {
                    ForEach(days, id: \.self) { day in
                        Text(day).foregroundColor(.gray).frame(maxWidth: .infinity)
                    }
                }.padding(.horizontal)
                
                // Grid Days
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 15) {
                    ForEach(1...30, id: \.self) { day in
                        VStack {
                            Text("\(day)").foregroundColor(selectedDay == day ? .cyan : .white)
                            if day % 3 == 0 || day % 7 == 0 {
                                Image(systemName: "checkmark").foregroundColor(.cyan).font(.caption)
                            } else {
                                Image(systemName: "circle").foregroundColor(.clear).font(.caption)
                            }
                        }
                        .onTapGesture { selectedDay = day }
                    }
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(10)
                .padding()
                
                // Day Detail
                VStack(alignment: .leading, spacing: 10) {
                    Text("Day Detail - Apr \(selectedDay)").font(.title2).foregroundColor(.white).padding(.bottom, 5)
                    HStack { Image(systemName: "checkmark.square.fill").foregroundColor(.cyan); Text("Daily Reflection").foregroundColor(.white) }
                    HStack { Image(systemName: "checkmark.square.fill").foregroundColor(.cyan); Text("Quests Completed").foregroundColor(.white) }
                    Spacer()
                }
                .padding().frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white.opacity(0.1)).cornerRadius(10).padding(.horizontal)
            }
        }
    }
}

// MARK: - Growth Journal Screen
struct GrowthJournalView: View {
    @State private var journalText: String = ""
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.05, blue: 0.1).ignoresSafeArea()
            VStack {
                Text("Growth Journal").font(.largeTitle).foregroundColor(.white).padding()
                Text("April 15").font(.headline).foregroundColor(.gray)
                
                TextEditor(text: $journalText)
                    .scrollContentBackground(.hidden)
                    .background(Color.white.opacity(0.1))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                
                Button(action: {
                    journalText = ""
                    showingAlert = true
                }) {
                    Image(systemName: "plus.circle.fill").font(.system(size: 50)).foregroundColor(.cyan)
                }
                .padding()
                .alert("Entry Saved", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("Your reflection has been recorded.")
                }
            }
        }
    }
}

// MARK: - User Profile Screen
struct UserProfileView: View {
    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.05, blue: 0.1).ignoresSafeArea()
            VStack(spacing: 20) {
                Text("User Profile").font(.largeTitle).foregroundColor(.white).padding(.top)
                
                // Avatar & Info
                HStack {
                    Image(systemName: "person.crop.circle")
                        .resizable().frame(width: 80, height: 80).foregroundColor(.cyan)
                    VStack(alignment: .leading) {
                        Text("Hunter Name").font(.title).foregroundColor(.white)
                        Text("Rank: B-Class").foregroundColor(.cyan)
                    }.padding(.leading, 10)
                    Spacer()
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(15)
                .padding(.horizontal)
                
                // Stats Grid
                HStack {
                    StatBox(title: "STR", value: "10")
                    StatBox(title: "INT", value: "7")
                    StatBox(title: "AGI", value: "8")
                }.padding(.horizontal)
                
                // Trophy Case
                Text("Trophy Case").font(.title2).foregroundColor(.white).padding(.top)
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 15) {
                    TrophyIcon(icon: "shield.fill")
                    TrophyIcon(icon: "text.book.closed.fill")
                    TrophyIcon(icon: "shield.fill")
                    TrophyIcon(icon: "bolt.fill")
                    TrophyIcon(icon: "square.dashed") // Empty slot
                    TrophyIcon(icon: "bolt.fill")
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(15)
                .padding(.horizontal)
                
                Spacer()
            }
        }
    }
}

struct StatBox: View {
    let title: String
    let value: String
    var body: some View {
        VStack {
            Text(title).foregroundColor(.gray)
            Text(value).font(.title).foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
    }
}

struct TrophyIcon: View {
    let icon: String
    var body: some View {
        Image(systemName: icon)
            .resizable()
            .scaledToFit()
            .frame(height: 40)
            .foregroundColor(.cyan)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.1))
            .cornerRadius(10)
    }
}

// MARK: - Friends List Screen
struct FriendsListView: View {
    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.05, blue: 0.1).ignoresSafeArea()
            VStack {
                Text("Friends").font(.largeTitle).foregroundColor(.white).padding()
                
                ScrollView {
                    FriendDetailRow(name: "TJ", level: 12, progress: 0.4)
                    FriendDetailRow(name: "Alex", level: 8, progress: 0.2)
                    FriendDetailRow(name: "Sam", level: 15, progress: 0.8)
                    FriendDetailRow(name: "Jess", level: 7, progress: 0.5)
                    FriendDetailRow(name: "Chris", level: 20, progress: 0.9)
                }.padding(.horizontal)
                
                Button(action: {}) {
                    Text("Add Friend")
                        .fontWeight(.bold)
                        .foregroundColor(.cyan)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.cyan.opacity(0.2))
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.cyan, lineWidth: 1))
                }.padding()
            }
        }
    }
}

struct FriendDetailRow: View {
    let name: String
    let level: Int
    let progress: Double
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle")
                .resizable().frame(width: 40, height: 40).foregroundColor(.gray)
            VStack(alignment: .leading) {
                Text("\(name) - Level \(level)").foregroundColor(.white).font(.headline)
                ProgressView(value: progress)
                    .tint(.cyan)
            }.padding(.leading, 10)
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
        .padding(.bottom, 5)
    }
}
