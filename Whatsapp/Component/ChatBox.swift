//
//  ChatBox.swift
//  weather-app
//
//  Created by Utsav Hitendrabhai Pandya on 15/03/26.
//

import SwiftUI

enum chatType {
    case status
    case message
    
}

struct ChatBox: View {
    
    let userName: String
    let userDesc: String
    let imageURL : URL
    let chatType: chatType
    
    
    var body: some View {
        HStack {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        
                @unknown default:
                    EmptyView()
                }
            }
            
            
            VStack(alignment: .leading) {
                Text(userName)
                    .font(.subheadline)
                    .foregroundStyle(Color.white)
                    .truncationMode(.middle)
                
                
                switch chatType {
                case .status:
                    Text(userDesc)
                        .font(.caption2)
                        .lineLimit(1)
                        .foregroundStyle(.green)
                case .message:
                    Text(userDesc)
                        .font(.caption2)
                        .lineLimit(1)
                        .foregroundStyle(.gray)
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 2)
            .padding(.vertical, 8)
        }
    }
}

//#Preview {
//    ChatBox(userName: "Jane Doe", userDesc: "Sunny with a chance of code", imageName: .narendraModi, chatType: .message)
//}
