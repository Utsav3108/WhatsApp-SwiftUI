//
//  Chat.swift
//  weather-app
//
//  Created by Utsav Hitendrabhai Pandya on 15/03/26.
//

import SwiftUI

struct Chat : View {
    
    let user : User
    let messages : [Message]
    
    init(user: User, messages : [Message]) {
        self.user = user
        self.messages = messages
    }
    
    @State var message: String = ""
    
    var body : some View {
        
        VStack(spacing: 0) {           
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(messages) { message in
                        MessageView(
                            message: message.text,
                            time: message.timestamp,
                            isRead: true,
                            isUser: message.isUser,
                            messageBgColor: message.isUser ? Color.green : Color(hex: "#363636")
                        )
                        .padding(message.isUser ? .leading : .trailing, 60)
                    }
                }
            }
            .scrollDismissesKeyboard(.interactively)

            // Input bar sits naturally at the bottom
            HStack {
                TextField("Type a message", text: $message)
                    .padding(10)
                    .background(Color.white.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding()
            .background(.ultraThinMaterial)
        }
        .background {
            // Background goes here, outside layout flow
            Image(.whatsAppBg)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(0.3)
        }
        .toolbar {
            // Center: Profile Image + Name
            ToolbarItem(placement: .principal) {
                
                ChatBox(userName: user.name, userDesc: "Online", imageName: user.image, chatType: .status)
                
            }
            
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button {
                    print("Add tapped")
                } label: {
                    Image(systemName: "video")
                }
                
                Button {
                    print("minus tapped")
                } label: {
                    Image(systemName: "phone")
                }
            }
            
            
        }
        
        
        
        
        
    }
    
}

#Preview {
    Chat(user: User(name: "Narendra Modi", desc: "Online"), messages: [
        Message(
            isUser: true,
            senderId: UUID(),
            text: "Modi ji, petrol ₹120 cross ho gaya 😭 Yeh war chal raha hai ya wallet attack?",
            timestamp: "22:10"
        ),
        Message(
            isUser: false,
            senderId: UUID(),
            text: "Mitron, situation thodi 'worrisome' ",
            timestamp: "22:11"
        )])
}
