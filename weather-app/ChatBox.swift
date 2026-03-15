//
//  ChatBox.swift
//  weather-app
//
//  Created by Utsav Hitendrabhai Pandya on 15/03/26.
//

import SwiftUI

struct ChatBox: View {
    
    let userName: String
    let userDesc: String
    let imageName : ImageResource
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(userName)
                    .foregroundStyle(Color.white)
                Text(userDesc)
                    .foregroundStyle(.gray)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
    }
}

#Preview {
    ChatBox(userName: "Jane Doe", userDesc: "Sunny with a chance of code", imageName: .narendraModi)
}
