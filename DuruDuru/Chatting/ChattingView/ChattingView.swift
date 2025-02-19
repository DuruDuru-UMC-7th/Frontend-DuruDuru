import SwiftUI

struct ChatView: View {
    @StateObject private var socketManager = ChatWebSocketManager()
    @StateObject private var viewModel = ChattingDetailViewModel()
    @State private var messageText: String = ""
    
    let chatRoomId: Int
    let username: String
    
    /// 과거 메시지와 실시간 메시지를 모두 합친 배열
    private var allMessages: [ChatMessageResponse] {
        let historical = viewModel.chatRoomDetail?.chatMessages ?? []
        let live = socketManager.messages
        return (historical + live).sorted { $0.sentTime ?? "" < $1.sentTime ?? "" }
    }
    
    var body: some View {
        VStack {
            if let chatRoom = viewModel.chatRoomDetail {
                VStack {
                    Text(chatRoom.tradeTitle)
                        .font(.title2)
                        .bold()
                    if let tradeImgUrl = chatRoom.tradeImgUrl,
                       let url = URL(string: tradeImgUrl) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                    }
                    Text(chatRoom.otherNickname)
                        .foregroundColor(.gray)
                }
                .padding()
                
                Divider()
                
                ScrollView {
                    VStack {
                        ForEach(allMessages, id: \.id) { message in
                            HStack {
                                if message.username == username {
                                    Spacer()
                                    Text(message.content)
                                        .padding()
                                        .background(Color.green.opacity(0.8))
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                } else {
                                    VStack(alignment: .leading) {
                                        Text(message.username)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        Text(message.content)
                                            .padding()
                                            .background(Color.gray.opacity(0.2))
                                            .foregroundColor(.black)
                                            .cornerRadius(10)
                                    }
                                    Spacer()
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                
                HStack {
                    TextField("메시지를 입력하세요", text: $messageText)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(20)
                    
                    Button(action: {
                        sendMessage()
                    }) {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .clipShape(Circle())
                    }
                }
                .padding()
            } else {
                ProgressView("채팅방 정보를 불러오는 중...")
                    .onAppear {
                        viewModel.fetchChatRoomDetail(chatRoomId: chatRoomId)
                    }
            }
        }
        .onAppear {
            print("ChatView onAppear triggered for chatRoomId: \(chatRoomId)")
            setupWebSocket()
        }
        .onDisappear {
            print("ChatView onDisappear triggered")
            socketManager.disconnect()
        }

    }
    
    /// WebSocket 연결: 채팅방 ID에 맞게 연결
    private func setupWebSocket() {
        socketManager.connect(to: chatRoomId)
    }
    
    /// 메시지 전송 함수
    private func sendMessage() {
        guard !messageText.isEmpty else { return }
        socketManager.sendMessage(username: username, content: messageText)
        messageText = ""
    }
}
