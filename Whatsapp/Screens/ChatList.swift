//  ContentView.swift
//  weather-app

import SwiftUI

struct User : Identifiable, Hashable, Codable {
    var id: Int
    
    var name : String
    var desc : String
    var imageURL : String? = nil
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case desc
        case imageURL = "image_url"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.desc = try container.decode(String.self, forKey: .desc)
        self.imageURL = try? container.decode(String?.self, forKey: .imageURL)
    }
}

struct Message: Identifiable, Hashable, Codable {
    var id: Int
    var isUser : Bool = false
    var senderId: Int
    var receiverId: Int
    var text: String
    var timestamp: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case isUser = "is_user"
        case senderId = "sender_id"
        case receiverId = "receiver_id"
        case text
        case timestamp
    }
    
    init(id: Int, isUser: Bool, senderId: Int, receiverId: Int, text: String, timestamp: Date) {
        self.id = id
        self.isUser = isUser
        self.senderId = senderId
        self.receiverId = receiverId
        self.text = text
        self.timestamp = timestamp
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        
        self.senderId = try container.decode(Int.self, forKey: .senderId)
        
        self.isUser = self.senderId == Int(personId)
        
        self.receiverId = try container.decode(Int.self, forKey: .receiverId)
        self.text = try container.decode(String.self, forKey: .text)
        self.timestamp = try container.decodeIfPresent(Date.self, forKey: .timestamp) ?? Date()
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
    @State var users: [User] = []
    
    var network : Network = Network()
    
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
                                    imageURL: URL(string: user.imageURL ?? "")!,
                                    chatType: .message
                                )
                                .padding(.horizontal, 20)
                            }
                        }
                    }
                }
                .onAppear() {
                    Task {
                        let users : [User]? = await network.perform(Request(url: URL(string: basePath + "/presidents")!, httpMethod: .GET))
                        
                        if let users = users {
                            self.users = users
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
