//
//  ChattingTabRow.swift
//  DuruDuru
//
//  Created by 한지강 on 2/14/25.
//

import SwiftUI

/// 개별 채팅방 UI 컴포넌트
struct ChatRow: View {
    let chatRoom: ChatRoom

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: chatRoom.tradeImgUrl ?? "")) { image in
                image.resizable()
            } placeholder: {
                Image(systemName: "person.circle.fill")
                    .resizable()
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(chatRoom.username)
                    .fontWeight(.bold)
                Text(chatRoom.lastMessage ?? "아직 없음")
                    .foregroundColor(.gray)
                    .font(.subheadline)
            }
            Spacer()

            VStack {
                Text(chatRoom.lastMessageDate ?? "날짜 없음")
                    .font(.footnote)
                    .foregroundColor(.gray)
                if chatRoom.unreadCount > 0 {
                    Text("\(chatRoom.unreadCount)+") 
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.white)
                        .padding(6)
                        .background(Color.green)
                        .clipShape(Circle())
                }
            }
        }
        .padding(.vertical, 8)
    }
}
