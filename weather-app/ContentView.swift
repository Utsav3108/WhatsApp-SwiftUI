//
//  ContentView.swift
//  weather-app
//
//  Created by Utsav Hitendrabhai Pandya on 13/03/26.
//

import SwiftUI

struct User : Identifiable {
    var id: UUID = UUID()
    
    var name : String
    var desc : String
}

struct ContentView: View {
    
    var users: [User] = [
        User(name: "Narendra Modi", desc: "Runs on chai, speeches, and 56-inch confidence."),
        User(name: "Joe Biden", desc: "Ice cream enthusiast navigating global politics."),
        User(name: "Emmanuel Macron", desc: "Balancing baguettes, diplomacy, and bold reforms."),
        User(name: "Rishi Sunak", desc: "Crunching budgets faster than a fintech startup."),
        User(name: "Justin Trudeau", desc: "Politics with a side of socks and selfies."),
        User(name: "Giorgia Meloni", desc: "Steering Italy with espresso-level intensity."),
        User(name: "Olaf Scholz", desc: "Quietly calculating Europe’s next move."),
        User(name: "Fumio Kishida", desc: "Diplomacy polished like a perfectly brewed matcha."),
        User(name: "Anthony Albanese", desc: "G’day diplomacy with a practical Aussie twist."),
        User(name: "Pedro Sánchez", desc: "Juggling coalitions like a political flamenco.")
    ]
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                
                // Add background color
                Color.black
                    .ignoresSafeArea()
                
                
                ScrollView {
                    LazyVStack(spacing: 10) {
                        
                        // Search bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.black)

                            Text("Ask Meta AI or search")
                                .foregroundStyle(.black)

                            Spacer()
                        }
                        .padding(.horizontal)
                        .frame(height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(uiColor: .gray))
                        )
                        .padding(.horizontal)

                        // Users
                        ForEach(users) { user in
                            VStack(alignment: .leading) {
                                Text(user.name)
                                    .foregroundStyle(Color.white)
                                Text(user.desc)
                                    .foregroundStyle(.gray)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                        }
                    }
                }
                
            }
            // Forces the entire stack into dark mode style
            
            .navigationTitle("WhatsApp")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            print("Profile")
                        } label: {
                            Image(systemName: "person")
                        }
                    }
                    
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button {
                            print("Add tapped")
                        } label: {
                            Image(systemName: "plus")
                        }
                        
                        Button {
                            print("minus tapped")
                        } label: {
                            Image(systemName: "minus")
                        }
                    }
                    

                }
            
                
            
        }.preferredColorScheme(.dark)
        
        
        
    }
    
}

#Preview {
    ContentView()
}
