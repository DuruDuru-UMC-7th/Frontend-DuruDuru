import SwiftUI

struct ChatRow: View {
    let chatRoom: ChatRoom
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            
            // 1) 왼쪽 프로필 이미지
            AsyncImage(url: URL(string: chatRoom.memberImgUrl ?? "")) { image in
                image.resizable()
            } placeholder: {
                Image("UserDefaultImage") // 기본 프로필 이미지
                    .resizable()
            }
            .frame(width: 56, height: 56)
            .clipShape(Circle())
            
            // 2) 중앙 텍스트 영역
            VStack(alignment: .leading, spacing: 4) {
                
                // 🔹 상대방 닉네임 표시
                HStack {
                    Text(chatRoom.otherNickname) // ✅ 상대방 닉네임만 표시
                        .font(.system(size: 13, weight: .semibold))
                    
                    Text("\(chatRoom.tradeTypeDisplay)·\(chatRoom.location ?? "")")
                        .font(.system(size: 10, weight: .regular))
                        .foregroundColor(.gray)
                }
                
                // 마지막 메시지
                Text(chatRoom.lastMessage ?? "아직 없음")
                    .font(.system(size: 11, weight: .regular))
                    .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.2, opacity: 0.88))
                    .lineLimit(1)
            }
            
            Spacer()
            
            // 3) 오른쪽 날짜 + 미확인 갯수
            VStack(alignment: .trailing, spacing: 4) {
                Text(chatRoom.formattedLastMessageDate)
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                
                if chatRoom.unreadCount > 0 {
                    Text(chatRoom.unreadCount > 99 ? "100+" : "\(chatRoom.unreadCount)")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 24, height: 24)
                        .background(Circle().fill(Color.green))
                }
            }
        }
        .padding(.vertical, 6)
        .frame(maxWidth: .infinity, minHeight: 76)
    }
}

// MARK: - Preview
#Preview {
    ChatRow(chatRoom: ChatRoom(
        id: 1,
        myNickname: "요청자닉네임",
        otherNickname: "등록자닉네임",
        tradeType: "SHARE",
        location: "공릉동",
        lastMessage: "품앗이를 요청했어요!",
        lastMessageDate: "2025-02-19T16:30:10.865Z",
        unreadCount: 1,
        memberImgUrl: "https://example.com/user.png"
    ))
}
