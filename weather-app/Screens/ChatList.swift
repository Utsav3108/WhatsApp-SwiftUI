//
//  ContentView.swift
//  weather-app
//
//  Created by Utsav Hitendrabhai Pandya on 13/03/26.
//

import SwiftUI

struct User : Identifiable, Hashable {
    var id: UUID = UUID()
    
    var name : String
    var desc : String
    var image : ImageResource = .narendraModi
}

struct Message: Identifiable, Hashable {
    var id: UUID = UUID()
    var isUser : Bool = false
    var senderId: UUID
    var text: String
    var timestamp: String
}

struct ChatList: View {
    
    @State private var searchedQuery: String = ""
    
    let messages: [Message] = [
        Message(
            isUser: true,
            senderId: UUID(),
            text: "Modi ji, petrol ₹120 cross ho gaya 😭 Yeh war chal raha hai ya wallet attack?",
            timestamp: "22:10"
        ),
        Message(
            isUser: false,
            senderId: UUID(),
            text: "Mitron, situation thodi 'worrisome' hai... par control mein hai 😌",
            timestamp: "22:11"
        ),
        Message(
            isUser: true,
            senderId: UUID(),
            text: "Control mein matlab? Pump pe toh mera BP 140 ho gaya 💀",
            timestamp: "22:12"
        ),
        Message(
            isUser: false,
            senderId: UUID(),
            text: "Global oil supply thodi disturb hui hai... Strait of Hormuz ka chakkar hai",
            timestamp: "22:13"
        ),
        Message(
            isUser: true,
            senderId: UUID(),
            text: "Mujhe toh sirf mera scooter disturb lag raha hai, full tank karane se pehle hi budget khatam 😭",
            timestamp: "22:14"
        ),
        Message(
            isUser: false,
            senderId: UUID(),
            text: "Aap electric vehicle consider kijiye 🔋",
            timestamp: "22:15"
        ),
        Message(
            isUser: true,
            senderId: UUID(),
            text: "Sir charging station dhoondhne mein hi aadha din nikal jayega 😂",
            timestamp: "22:16"
        ),
        Message(
            isUser: false,
            senderId: UUID(),
            text: "Desh badal raha hai... thoda adjust kariye 😄",
            timestamp: "22:17"
        ),
        Message(
            isUser: true,
            senderId: UUID(),
            text: "Sir desh badal raha hai, par mera bank balance reverse gear mein ja raha hai 🚶‍♂️",
            timestamp: "22:18"
        ),
        Message(
            isUser: false,
            senderId: UUID(),
            text: "Aatmanirbhar baniye… cycle chalaiye 🚲",
            timestamp: "22:19"
        ),
        Message(
            isUser: true,
            senderId: UUID(),
            text: "Next message: 'Sir office 12km hai' 😐",
            timestamp: "22:20"
        ),
        Message(
            isUser: true,
            senderId: UUID(),
            text: "Hey .. sir? ",
            timestamp: "22:20"
        )
    ]
    
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
                                .fill(Color(hex: "#363636"))
                        )
                        .padding(.horizontal)

                        // Users
                        ForEach(users) { user in
                            NavigationLink(value: user) {
                                ChatBox(userName: user.name, userDesc: user.desc, imageName: user.image, chatType: .message).padding(.horizontal, 20)
                            }
                        }
                        
                    }
                }.navigationDestination(for: User.self) { user in
                    Chat(user: user, messages: messages)
                }
                
            }
            // Forces the entire stack into dark mode style
            
            .navigationTitle("Chats")
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
                            Image(systemName: "camera")
                        }
                        
                        Button {
                            print("minus tapped")
                        } label: {
                            Image(systemName: "qrcode")
                        }
                    }
                    

                }
            
                
            
        }.preferredColorScheme(.dark)
        
        
        
    }
    
}

#Preview {
    ChatList()
}
