//  ContentView.swift
//  weather-app

import SwiftUI

struct User : Identifiable, Hashable {
    var id: Int
    
    var name : String
    var desc : String
    var image : ImageResource = .narendraModi
}

struct Message: Identifiable, Hashable, Codable {
    var id: Int
    var isUser : Bool = false
    var senderId: Int
    var text: String
    var timestamp: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case isUser = "is_user"
        case senderId = "user_id"
        case text
        case timestamp
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.isUser = try container.decode(Bool.self, forKey: .isUser)
        self.senderId = try container.decode(Int.self, forKey: .senderId)
        self.text = try container.decode(String.self, forKey: .text)
        self.timestamp = try container.decode(Date.self, forKey: .timestamp)
    }
    
    func getTimeStampString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: timestamp)
    }
}

struct ChatList: View {
    
    @State private var searchedQuery: String = ""
    
    // 🔥 Conversations Dictionary
    let conversations: [Int: [Message]] = [:]

    // 🔥 Users with IDs aligned to conversations
    var users: [User] = [
        User(id: 0, name: "Narendra Modi", desc: "Runs on chai, speeches, and 56-inch confidence."),
        User(id: 1, name: "Joe Biden", desc: "Ice cream enthusiast navigating global politics.", image: .joeBiden),
        User(id: 2, name: "Emmanuel Macron", desc: "Balancing baguettes, diplomacy, and bold reforms.", image: .emmanuelMacron),
        User(id: 3, name: "Rishi Sunak", desc: "Crunching budgets faster than a fintech startup.", image: .rishiSunak),
        User(id: 4, name: "Justin Trudeau", desc: "Politics with a side of socks and selfies.", image: .justinTrudeo),
        User(id: 5, name: "Giorgia Meloni", desc: "Steering Italy with espresso-level intensity.", image: .giorgiaMeloni),
        User(id: 6, name: "Anthony Albanese", desc: "G’day diplomacy with a practical Aussie twist.", image: .anothonyAlbanese)
    ]
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                
                Color.black
                    .ignoresSafeArea()
                
                ScrollView {
                    LazyVStack(spacing: 10) {
                        
                        // Search bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.gray)

                            TextField("Ask Meta AI or search", text: $searchedQuery)

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
                        ForEach(Array(users.enumerated()), id: \.element) { index, user in
                            NavigationLink {
                                Chat(
                                    user: user,
                                    messages: conversations[index] ?? []
                                )
                            } label: {
                                ChatBox(
                                    userName: user.name,
                                    userDesc: user.desc,
                                    imageName: user.image,
                                    chatType: .message
                                )
                                .padding(.horizontal, 20)
                            }
                        }
                    }
                }
            }
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
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ChatList()
}
