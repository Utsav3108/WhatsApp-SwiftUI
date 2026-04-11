//
//  Chat.swift
//  weather-app
//
//  Created by Utsav Hitendrabhai Pandya on 15/03/26.
//

import SwiftUI

struct Chat : View {
    
    // MARK: - Global Variable
    let user : User
    let network = Network()
    // MARK: - State
    @State var messages : [Message]
    @State var message: String = ""
    
    // MARK: - Init
    init(user: User, messages : [Message]) {
        self.user = user
        self.messages = messages
    }
    
    
    // MARK: - UI Description
    var body : some View {
        
        VStack(spacing: 0) {           
            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(messages) { message in
                            MessageView(
                                message: message.text,
                                time: message.getTimeStampString(),
                                isRead: true,
                                isUser: message.isUser,
                                messageBgColor: message.isUser ? Color.green : Color(hex: "#363636")
                            )
                            .padding(message.isUser ? .leading : .trailing, 60)
                        }
                    }
                }
                .scrollDismissesKeyboard(.immediately)
                .onAppear {
                                // Scroll to bottom on open
                                if let last = messages.last {
                                    proxy.scrollTo(last.id, anchor: .bottom)
                                }
                            }
                .onChange(of: messages.count) { _, _ in
                    // Scroll to bottom when new message arrives
                    if let last = messages.last {
                        withAnimation { proxy.scrollTo(last.id, anchor: .bottom) }
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                    // Scroll to bottom when keyboard opens
                    DispatchQueue.main.async {
                        if let last = messages.last {
                            withAnimation { proxy.scrollTo(last.id, anchor: .bottom) }
                        }
                    }
                }
            }

            HStack(spacing: 8) {
                // Text field bubble
                HStack(spacing: 10) {
                    // Emoji button
                    Button {
                        // emoji action
                    } label: {
                        Image(systemName: "face.smiling")
                            .font(.system(size: 22))
                            .foregroundStyle(.secondary)
                    }

                    TextField("Message", text: $message, axis: .vertical)
                        
                        .font(.system(size: 15))
                        
                        

                    // Attachment button
                    Button {
                        // attachment action
                    } label: {
                        Image(systemName: "paperclip")
                            .font(.system(size: 20))
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color(.systemGray4), lineWidth: 0.5)
                )

                // Send / mic button
                Button {
                    // send action
                    guard !message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }


                    Task {
                        let body: [String: Any] = [
                            "user_id": 0,
                            "text": message,
                            "is_user": true
                        ]
                        
                        message = ""

                        let request = Request(url: URL(string: basePath + "/messages")!, httpMethod: .POST, body: body)

                        if let m: Message = await network.perform(request) {
                            print("Message returned from server : ", m.timestamp)
                            
                            messages.append(m)
                        } else {
                            print("There is somee error.")
                        }
                        
                        
                        
                        
                    }
                    
                    

                } label: {
                    Image(systemName: message.isEmpty ? "mic.fill" : "arrow.up")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 44, height: 44)
                        .background(Color(red: 0.145, green: 0.827, blue: 0.4)) // WhatsApp green
                        .clipShape(Circle())
                }
                .animation(.easeInOut(duration: 0.15), value: message.isEmpty)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
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

//#Preview {
//    Chat(user: User(id: 1, name: "Narendra Modi", desc: "Online"), messages: [
//        Message(
//            isUser: true,
//            senderId: UUID(),
//            text: "Modi ji, petrol ₹120 cross ho gaya 😭 Yeh war chal raha hai ya wallet attack?",
//            timestamp: "22:10"
//        ),
//        Message(
//            isUser: false,
//            senderId: UUID(),
//            text: "Mitron, situation thodi 'worrisome' ",
//            timestamp: "22:11"
//        )])
//}
