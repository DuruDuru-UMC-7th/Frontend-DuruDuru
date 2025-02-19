//
//  ChattingTabRow.swift
//  DuruDuru
//
//  Created by 한지강 on 2/14/25.
//

import SwiftUI

struct ChatRow: View {
    let chatRoom: ChatRoom
    
    var body: some View {
        HStack(alignment: .center, spacing: 7) {
            // 프로필 이미지
            AsyncImage(url: URL(string: chatRoom.tradeImgUrl ?? "")) { image in
                image.resizable()
            } placeholder: {
                Image("UserDefaultImage")
                    .resizable()
                    .frame(width: 56, height: 56)
            }
            .frame(width: 56, height: 56)
            .clipShape(Circle())

            // 중앙 텍스트 영역
            chatInformation
            
            Spacer()
            
            // 오른쪽 날짜 + 미확인 갯수
            dayAndUnreadCount
        }
        .frame(width: 370, height: 76)
        .padding(.vertical, 10)
    }
    
    /// 채팅방 정보 (이름 + 거래 유형 + 메시지)
    private var chatInformation: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(chatRoom.username)
                    .font(.system(size: 13, weight: .semibold))
                Text(chatRoom.tradeType ?? "알 수 없음")
                    .font(.system(size: 10, weight: .regular))
                    .foregroundColor(.gray)
            }

            Text(chatRoom.lastMessage ?? "아직 없음")
                .font(.system(size: 11, weight: .regular))
                .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.2, opacity: 0.88))
                .lineLimit(1) 
        }
    }

    /// 오른쪽 날짜 + 미확인 메시지 개수
    private var dayAndUnreadCount: some View {
        VStack(alignment: .center, spacing: 4) {
            Text(chatRoom.formattedLastMessageDate)
                .font(.system(size: 10))
                .foregroundColor(.gray)
                .padding(.trailing, 4)

            if chatRoom.unreadCount > 0 {
                Text(chatRoom.unreadCount > 99 ? "100+" : "\(chatRoom.unreadCount)")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 24, height: 24)
                    .background(Circle().fill(Color.green))
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 1)
                    )
                    .padding(.trailing, 4)
            }
        }
    }
}

#Preview {
    ChatRow(chatRoom: ChatRoom(
        id: 1,
        username: "냥냥곰",
        tradeImgUrl: "https://example.com/cat.png",
        tradeType: "나눔",
        lastMessage: "오후 5시에 뵈요",
        lastMessageDate: "2025-02-19T16:30:10.865Z",
        unreadCount: 100,
        sentTime: "2025-02-19T16:30:10.865Z"
    ))
}
