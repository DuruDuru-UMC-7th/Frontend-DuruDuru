import SwiftUI

struct ChatView: View {
    @StateObject private var socketManager = ChatWebSocketManager()
    @StateObject private var viewModel = ChattingDetailViewModel()
    @State private var messageText: String = ""
    @State private var scrollViewProxy: ScrollViewProxy?
    @FocusState private var isKeyboardActive: Bool

    let chatRoomId: Int
    let username: String

    /// 과거 메시지 + 실시간 메시지를 합쳐서 오래된 순으로 정렬
    private var allMessages: [ChatMessageResponse] {
        let historical = viewModel.chatRoomDetail?.chatMessages ?? []
        let live = socketManager.messages
        return (historical + live).sorted { $0.sentTime ?? "" < $1.sentTime ?? "" }
    }

    var body: some View {
        VStack(spacing: 0) {
            if let chatRoom = viewModel.chatRoomDetail {
                
                // ✅ 네비게이션 바
                customNavigationBar(otherNickname: chatRoom.otherNickname)
                    .navigationBarHidden(true)
                
                Divider()
                
                topTradeInfoView(chatRoom: chatRoom)
                Divider()
                
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack{
                            Text(formatTimeString(viewModel.chatRoomDetail?.createdAt ?? "2025-02-20T09:12:00Z"))
                                    .font(.system(size: 11, weight: .regular))
                                    .foregroundColor(Color(red: 0.22, green: 0.22, blue: 0.24).opacity(0.61))
                            
                            Text("품앗이를 요청했어요!")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 13)
                                    .padding(.horizontal, 38)
                                    .background(Color(red: 0, green: 0.76, blue: 0.41))
                                    .clipShape(Capsule())
                        }
                        
                        VStack(spacing: 10) {
                            ForEach(allMessages, id: \.id) { message in
                                messageBubble(message: message)
                                    .id(message.id)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                        .onAppear {
                            self.scrollViewProxy = proxy
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                if let lastId = allMessages.last?.id {
                                    withAnimation {
                                        proxy.scrollTo(lastId, anchor: .bottom)
                                    }
                                }
                            }
                        }
                        .onChange(of: allMessages.count) { oldValue, newValue in
                            if newValue > oldValue, let lastId = allMessages.last?.id {
                                withAnimation {
                                    proxy.scrollTo(lastId, anchor: .bottom)
                                }
                            }
                        }
                    }
                }
                
                Divider()
                bottomInputBar
                                    .padding(.bottom, isKeyboardActive ? 10 : 0)
                                    .animation(.easeInOut, value: isKeyboardActive)
                                    .ignoresSafeArea(.keyboard, edges: .bottom)
            } else {
                ProgressView("채팅방 정보를 불러오는 중...")
                    .onAppear {
                        viewModel.fetchChatRoomDetail(chatRoomId: chatRoomId)
                    }
            }
        }
        
        .onAppear {
            setupWebSocket()
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onDisappear {
            socketManager.disconnect()
        }
    }

    // MARK: - ✅ 네비게이션 바
    @Environment(\.dismiss) private var dismiss

    @ViewBuilder
    private func customNavigationBar(otherNickname: String) -> some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold))
            }

            Spacer()
            
            Text(otherNickname)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)

            Spacer()

            Button(action: {
                // 옵션 동작 추가
            }) {
                Image(systemName: "ellipsis")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold))
            }
        }
        .padding()
    }

    // MARK: - ✅ 거래 정보 UI
    @ViewBuilder
    private func topTradeInfoView(chatRoom: ChattingRoomDetailResult) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top, spacing: 12) {
                AsyncImage(url: URL(string: chatRoom.tradeImgUrl ?? "")) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: 80, height: 80)
                .cornerRadius(8)

                VStack(alignment: .leading, spacing: 4) {
                    Text(chatRoom.tradeTitle)
                        .font(.headline)
                        .foregroundColor(.black)

                    HStack {
                        Text(chatRoom.tradeType)
                            .font(.caption)
                            .foregroundColor(Color(red: 0, green: 0.76, blue: 0.41))
                        if let loc = chatRoom.otherLocation, !loc.isEmpty {
                            Text("· \(loc)")
                                .font(.caption)
                                .foregroundColor(Color(red: 0.22, green: 0.22, blue: 0.24).opacity(0.61))
                        }
                    }

                    Text("수량 \(chatRoom.ingredientCount ?? 0)알 · 남은 소비기한 \(chatRoom.expirationDate ?? "10")일")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }

                Spacer()
            }
            .padding(.horizontal)

        }
        .padding(.vertical, 10)
    }

    // MARK: - ✅ 메시지 UI
    @ViewBuilder
    private func messageBubble(message: ChatMessageResponse) -> some View {
        HStack(alignment: .bottom, spacing: 6) {
            if message.username == username {
                Spacer()
                
                HStack(alignment: .bottom, spacing: 4) {
                    Text(formatTimeString(message.sentTime ?? ""))
                        .font(.system(size: 11, weight: .regular))       .foregroundColor(Color(red: 0.22, green: 0.22, blue: 0.24).opacity(0.61))
                    Text(message.content)
                        .font(.system(size: 12, weight: .regular))
                        .padding()
                        .background(Color(red: 0, green: 0.76, blue: 0.41))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                
                }
            } else {
                AsyncImage(url: URL(string: viewModel.chatRoomDetail?.otherMemberImgUrl ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Image("UserDefaultImage")
                        .resizable()
                }
                .frame(width: 36, height: 36)
                .clipShape(Circle())

                HStack(alignment: .bottom, spacing: 4) {
                    Text(message.content)
                        .font(.system(size: 12, weight: .regular))
                        .padding()
                        .background(Color(red: 0.92, green: 0.92, blue: 0.93))
                        .foregroundColor(.black)
                        .cornerRadius(20)
                    
                    Text(formatTimeString(message.sentTime ?? ""))
                        .font(.system(size: 11, weight: .regular))
                        .foregroundColor(Color(red: 0.22, green: 0.22, blue: 0.24).opacity(0.61))
                }
                
                Spacer()
            }
        }
        .padding(.horizontal)
    }

    // MARK: - ✅ 메시지 입력창
    private var bottomInputBar: some View {
        HStack {
            TextField("텍스트를 입력하세요", text: $messageText)
                .focused($isKeyboardActive)
                .padding(12)
                .background(Color.white)
                .cornerRadius(20)
                .overlay(
                RoundedRectangle(cornerRadius: 10)
                .inset(by: 0.5)
                .stroke(lineWidth: 1)
                .foregroundColor(Color(red: 0.44, green: 0.45, blue: 0.49).opacity(0.22))
                )
            
            Button(action: sendMessage) {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .frame(width: 32, height: 32)
                    .background(Color(red: 0, green: 0.76, blue: 0.41))
                    .clipShape(Circle())
            }
        }
        .padding()
    }

    // MARK: - ✅ WebSocket 연결
    private func setupWebSocket() {
        socketManager.connect(to: chatRoomId)
    }

    private func sendMessage() {
        guard !messageText.isEmpty else { return }
        socketManager.sendMessage(username: username, content: messageText)
        messageText = ""
    }

    // MARK: - ✅ 날짜 포맷 변환
    private func formatTimeString(_ isoDateString: String) -> String {
            let isoFormatter = ISO8601DateFormatter()
            isoFormatter.formatOptions = [.withFullDate, .withTime, .withFractionalSeconds, .withDashSeparatorInDate, .withColonSeparatorInTime]

            if let date = isoFormatter.date(from: isoDateString) {
                let formatter = DateFormatter()
                formatter.dateFormat = "a h:mm" // 오전/오후 h:mm 형식
                formatter.locale = Locale(identifier: "ko_KR") // 한국 시간 설정
                return formatter.string(from: date)
            }
            return isoDateString
        }

}
