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
    var image : ImageResource = .narendraModi
}

struct ContentView: View {
    
    @State private var searchedQuery: String = ""
    
    var users: [User] = [
        User(name: "Narendra Modi", desc: "Runs on chai, speeches, and 56-inch confidence."),
        User(name: "Joe Biden", desc: "Ice cream enthusiast navigating global politics.", image: .joeBiden),
        User(name: "Emmanuel Macron", desc: "Balancing baguettes, diplomacy, and bold reforms.", image: .emmanuelMacron),
        User(name: "Rishi Sunak", desc: "Crunching budgets faster than a fintech startup.", image: .rishiSunak),
        User(name: "Justin Trudeau", desc: "Politics with a side of socks and selfies.", image: .justinTrudeo),
        User(name: "Giorgia Meloni", desc: "Steering Italy with espresso-level intensity.", image: .giorgiaMeloni),
        User(name: "Olaf Scholz", desc: "Quietly calculating Europe’s next move.", image: .olafScholz),
        User(name: "Fumio Kishida", desc: "Diplomacy polished like a perfectly brewed matcha.", image: .fumioKishida),
        User(name: "Anthony Albanese", desc: "G’day diplomacy with a practical Aussie twist.", image: .anothonyAlbanese),
        User(name: "Pedro Sánchez", desc: "Juggling coalitions like a political flamenco.", image: .pedroSanchez)
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
                                .foregroundStyle(.gray)

                            TextField("Ask Meta AI or search", text: $searchedQuery) {
                                
                            }

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
                            ChatBox(userName: user.name, userDesc: user.desc, imageName: user.image).padding(.horizontal, 20)
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
