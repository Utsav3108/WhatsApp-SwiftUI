//  ContentView.swift
//  weather-app

import SwiftUI

struct User : Identifiable, Hashable {
    var id: Int
    
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
    
    // 🔥 Conversations Dictionary
    let conversations: [Int: [Message]] = [
        
        // MARK: - Narendra Modi (0)
        0: [
            Message(isUser: true, senderId: UUID(), text: "Modi ji, petrol ₹120 cross ho gaya 😭 Iran war ka impact hai kya?", timestamp: "22:10"),
            Message(isUser: false, senderId: UUID(), text: "Global oil supply disturb hui hai… Strait of Hormuz ka effect hai", timestamp: "22:11"),
            Message(isUser: true, senderId: UUID(), text: "Matlab mera budget hi blast ho gaya 💀", timestamp: "22:12"),
            Message(isUser: false, senderId: UUID(), text: "Thoda patience rakhiye… situation monitor ho rahi hai", timestamp: "22:13"),
            Message(isUser: true, senderId: UUID(), text: "Sir, patience se tanki nahi bharti. Cycle pe office jaun kya ab? 🚲", timestamp: "22:14"),
            Message(isUser: false, senderId: UUID(), text: "Isse P.U.S.H. milega—Physical Upgrade and Sustainable Health! Fit India movement ko bal milega.", timestamp: "22:15"),
            Message(isUser: true, senderId: UUID(), text: "Aap toh aag mein ghee daal rahe ho... par ghee bhi ₹700 kilo hai 💀", timestamp: "22:16"),
            Message(isUser: false, senderId: UUID(), text: "Dekhiye, ise 'kharcha' mat kahiye, desh nirman mein ek chhota sa yogdaan samjhiye. 😊", timestamp: "22:17"),
            Message(isUser: true, senderId: UUID(), text: "Itna bada yogdaan de raha hoon, ek selfie toh banti hai? 📸", timestamp: "22:18"),
            Message(isUser: false, senderId: UUID(), text: "Digital India ka upyog karein. NaMo app par selfie bhejiye, main zaroor dekhunga!", timestamp: "22:19")
        ],
        
        // MARK: - Joe Biden (1)
        1: [
            Message(isUser: true, senderId: UUID(), text: "Mr. Biden, why is fuel price increasing globally?", timestamp: "21:00"),
            Message(isUser: false, senderId: UUID(), text: "The conflict has disrupted global oil supply chains, especially around the Gulf region.", timestamp: "21:01"),
            Message(isUser: true, senderId: UUID(), text: "So this Iran war is impacting everyone?", timestamp: "21:02"),
            Message(isUser: false, senderId: UUID(), text: "Yes, energy markets are highly interconnected. Also… I might need more ice cream for this stress.", timestamp: "21:03")
        ],
        
        // MARK: - Emmanuel Macron (2)
        2: [
            Message(isUser: true, senderId: UUID(), text: "Macron sir, Europe ka stance kya hai Iran war pe?", timestamp: "20:10"),
            Message(isUser: false, senderId: UUID(), text: "We are urging restraint and stability. Escalation will only worsen global conditions.", timestamp: "20:11"),
            Message(isUser: true, senderId: UUID(), text: "But oil crisis toh already ho raha hai", timestamp: "20:12"),
            Message(isUser: false, senderId: UUID(), text: "Yes… and my people are already protesting before I even speak 😅", timestamp: "20:13")
        ],
        
        // MARK: - Rishi Sunak (3)
        3: [
            Message(isUser: true, senderId: UUID(), text: "Sunak sir, UK economy pe kya impact hai?", timestamp: "19:00"),
            Message(isUser: false, senderId: UUID(), text: "Energy prices are rising, and inflation pressure is increasing due to the conflict.", timestamp: "19:01"),
            Message(isUser: true, senderId: UUID(), text: "So common people suffer again 😅", timestamp: "19:02"),
            Message(isUser: false, senderId: UUID(), text: "I am trying spreadsheets… but Excel bhi emotional ho gaya hai now.", timestamp: "19:03")
        ],
        
        // MARK: - Justin Trudeau (4)
        4: [
            Message(isUser: true, senderId: UUID(), text: "Trudeau sir, Canada safe hai na?", timestamp: "18:10"),
            Message(isUser: false, senderId: UUID(), text: "We are geographically safer, but global economy impacts everyone.", timestamp: "18:11"),
            Message(isUser: true, senderId: UUID(), text: "At least petrol cheap hoga waha?", timestamp: "18:12"),
            Message(isUser: false, senderId: UUID(), text: "Let’s just say… even my socks are stressed now 🧦", timestamp: "18:13")
        ],
        
        // MARK: - Giorgia Meloni (5)
        5: [
            Message(isUser: true, senderId: UUID(), text: "Hello Meloni ma'am, how is the situation in Italy currently?", timestamp: "17:00"),
            Message(isUser: false, senderId: UUID(), text: "Energy crisis is hitting hard. We are working to secure alternatives.", timestamp: "17:01"),
            Message(isUser: true, senderId: UUID(), text: "Are pizza prices going to skyrocket too? That would be a global disaster! 😭", timestamp: "17:02"),
            Message(isUser: false, senderId: UUID(), text: "If that happens… even I will protest on the streets 🍕", timestamp: "17:03"),
            Message(isUser: true, senderId: UUID(), text: "The world isn't ready for a protest led by the Prime Minister over sourdough! 😂", timestamp: "17:04"),
            Message(isUser: false, senderId: UUID(), text: "Some things are sacred. In Italy, the crust is a national treasure.", timestamp: "17:05"),
            Message(isUser: true, senderId: UUID(), text: "True. Speaking of treasures, the 'Melodi' selfies are still trending in India. Did you see them?", timestamp: "17:06"),
            Message(isUser: false, senderId: UUID(), text: "The friendship between Italy and India is strong. The memes? Even stronger.", timestamp: "17:07"),
            Message(isUser: true, senderId: UUID(), text: "You should visit India again soon. We can trade some Pasta for local snacks!", timestamp: "17:08"),
            Message(isUser: false, senderId: UUID(), text: "I would love that! Just promise me: no pineapple on the pizza and we have a deal.", timestamp: "17:09"),
            Message(isUser: true, senderId: UUID(), text: "Don't worry, I wouldn't dare commit a food crime against Italy. 🇮🇹🤝🇮🇳", timestamp: "17:10")
        ],
        
        // MARK: - Anthony Albanese (6)
        6: [
            Message(isUser: true, senderId: UUID(), text: "Albanese sir, Australia pe impact?", timestamp: "16:00"),
            Message(isUser: false, senderId: UUID(), text: "We are monitoring the situation closely, especially fuel and trade routes.", timestamp: "16:01"),
            Message(isUser: true, senderId: UUID(), text: "Petrol aur kangaroo dono safe hai na?", timestamp: "16:02"),
            Message(isUser: false, senderId: UUID(), text: "Kangaroos are fine… petrol not so much mate 😅", timestamp: "16:03")
        ]
    ]

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
