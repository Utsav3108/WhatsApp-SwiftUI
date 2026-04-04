//
//  Message.swift
//  weather-app
//
//  Created by Utsav Hitendrabhai Pandya on 04/04/26.
//

import SwiftUI

struct MessageView: View {
    
    let message: String
    let time: String
    let isRead: Bool
    let isUser : Bool
    var messageBgColor: Color = .green

    var body: some View {
        
        VStack(alignment: .trailing, spacing: 4) {
            
            Text(message)
                .font(.subheadline)
                .foregroundStyle(.primary)
                .fixedSize(horizontal: false, vertical: true)
            
            HStack(spacing: 4) {
                
                
                Text(time)
                    .font(.caption)
                
                if isUser {
                    Image(systemName: "checkmark")
                        .foregroundStyle(.blue)
                }
            }
        }
        .padding(8)
        .background(messageBgColor)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .frame(maxWidth: .infinity, alignment: isUser ? .trailing : .leading)
    }
}

#Preview {
    MessageView(message: "Hey bro", time: "22:33", isRead: true, isUser: true)
}
