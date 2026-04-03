//
//  Chat.swift
//  weather-app
//
//  Created by Utsav Hitendrabhai Pandya on 15/03/26.
//

import SwiftUI

struct Chat : View {
    
    let user : User
    
    init(user: User) {
        self.user = user
    }
    
    @State var message: String = ""
    
    var body : some View {
        
        VStack {
            
            
            
            Spacer()
            
            TextField("Type a message", text: $message)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).stroke(Color.gray))
                .padding()
                
        }.toolbar {
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
    Chat(user: User(name: "Narendra Modi", desc: "Online"))
}
