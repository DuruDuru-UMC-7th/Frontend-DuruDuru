import SwiftUI

struct ChatView: View {
    // 기존
    @StateObject private var socketManager = ChatWebSocketManager()
    @StateObject private var viewModel = ChattingDetailViewModel()
    
    // 키보드 높이 관찰용
    @StateObject private var keyboardHelper = KeyboardHeightHelper()
    
    @State private var messageText: String = ""
    @State private var scrollViewProxy: ScrollViewProxy?
    
    // iOS 15+ FocusState (TextField용)
    @FocusState private var isKeyboardActive: Bool

    let chatRoomId: Int
    let username: String

    /// 과거 메시지 + 실시간 메시지를 모두 합쳐서 오래된 순으로 정렬
    private var allMessages: [ChatMessageResponse] {
        let historical = viewModel.chatRoomDetail?.chatMessages ?? []
        let live = socketManager.messages
        return (historical + live).sorted { $0.sentTime ?? "" < $1.sentTime ?? "" }
    }

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                if let chatRoom = viewModel.chatRoomDetail {
                    
                    // 네비게이션 바
                    customNavigationBar(otherNickname: chatRoom.otherNickname)
                        .navigationBarHidden(true)
                    
                    Divider()
                    
                    // 거래 정보
                    topTradeInfoView(chatRoom: chatRoom)
                    Divider()
                    
                    // 메시지 목록
                    ScrollViewReader { proxy in
                        ScrollView {
                            VStack {
                                // 안내 메시지
                                Text(formatToAmPmTime(chatRoom.createdAt))
                                    .font(.system(size: 11, weight: .regular))
                                    .foregroundColor(Color(red: 0.22, green: 0.22, blue: 0.24).opacity(0.61))
                                    .padding(.top, 20)
                                    .padding(.bottom, 10)
                                
                                Text("품앗이를 요청했어요!")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 13)
                                    .padding(.horizontal, 34)
                                    .background(Color(red: 0, green: 0.76, blue: 0.41))
                                    .clipShape(Capsule())
                            }
                            
                            // 실제 메시지들
                            VStack(spacing: 10) {
                                ForEach(allMessages, id: \.id) { message in
                                    messageBubble(message: message)
                                        .id(message.id)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .onAppear {
                                self.scrollViewProxy = proxy
                                // 화면 나타난 직후 마지막 메시지로 스크롤
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    scrollToLastMessage(proxy)
                                }
                            }
                            .onChange(of: allMessages.count) { _ in
                                // 새 메시지 생길 때마다 마지막으로 스크롤
                                scrollToLastMessage(proxy)
                            }
                        }
                    }
                    
                    Divider()
                    
                    // 입력창
                    bottomInputBar
                } else {
                    // 채팅방 정보 불러오는 중
                    ProgressView("채팅방 정보를 불러오는 중...")
                        .onAppear {
                            viewModel.fetchChatRoomDetail(chatRoomId: chatRoomId)
                        }
                }
            }
            // 키보드 높이만큼 하단 여백
            .padding(.bottom, keyboardHelper.keyboardHeight/34)
            
            // 배경 탭 시 키보드 내리기
            .contentShape(Rectangle())
            .onTapGesture {
                UIApplication.shared.endEditing(true)
                isKeyboardActive = false
            }
        }
        .onAppear {
            setupWebSocket()
        }
        .onDisappear {
            socketManager.disconnect()
        }
    }

    // MARK: - 네비게이션 바
    @Environment(\.dismiss) private var dismiss

    @ViewBuilder
    private func customNavigationBar(otherNickname: String) -> some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold))
            }
            Spacer()
            Text(otherNickname)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
            Spacer()
            Button(action: {}) {
                Image(systemName: "ellipsis")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold))
            }
        }
        .padding()
    }

    // MARK: - 거래 정보
    @ViewBuilder
    private func topTradeInfoView(chatRoom: ChattingRoomDetailResult) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top, spacing: 12) {
                AsyncImage(url: URL(string: chatRoom.tradeImgUrl ?? "")) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: 100, height: 100)
                .cornerRadius(8)

                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 5){
                        Text("품앗이중")
                            .font(.system(size: 9, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.vertical,4)
                            .padding(.horizontal,6)
                            .background(Color(red: 0, green: 0.76, blue: 0.41))
                            .clipShape(Capsule())
                            
                        Text(chatRoom.tradeTitle)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    .padding(.top,3)
                    
                    HStack {
                        if let loc = chatRoom.otherLocation, !loc.isEmpty {
                            Text("\(loc)·오늘")
                                .font(.system(size: 10, weight: .regular))
                                .foregroundColor(.gray)
//                            Text("오늘")
//                                .font(.system(size: 10, weight: .regular))
//                                .foregroundColor(.gray)
                        }
                        
                        
                        
                       
                        
                    }
                    Text(displayTradeType(chatRoom.tradeType))                        .font(.system(size: 14,weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.vertical,2)
                    
                    
                    Text(
                        """
                        수량   \(chatRoom.ingredientCount ?? 0)
                        남은 소비기한   \(daysUntilExpiration(chatRoom.expirationDate ?? "10") ?? 10)일
                        """
                    )
                        .font(.system(size: 11, weight: .regular))
                        .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.2).opacity(0.88))
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 10)
    }

    // MARK: - 메시지 셀
    @ViewBuilder
    private func messageBubble(message: ChatMessageResponse) -> some View {
        HStack(alignment: .bottom, spacing: 6) {
            if message.username == username {
                // 내 메시지
                Spacer()
                HStack(alignment: .bottom, spacing: 4) {
                    Text(formatTimeString(message.sentTime ?? ""))
                        .font(.system(size: 11, weight: .regular))
                        .foregroundColor(Color(red: 0.22, green: 0.22, blue: 0.24).opacity(0.61))
                    Text(message.content)
                        .font(.system(size: 12, weight: .regular))
                        .padding()
                        .background(Color(red: 0, green: 0.76, blue: 0.41))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                    
                }
            } else {
                // 상대 메시지
                AsyncImage(url: URL(string: viewModel.chatRoomDetail?.otherMemberImgUrl ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Image("UserDefaultImage").resizable()
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

    // MARK: - 입력창
    private var bottomInputBar: some View {
        HStack {
            TextField("텍스트를 입력해 주세요.", text: $messageText)
                .padding(12)
                .background(Color.white)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                        .foregroundColor(Color.gray.opacity(0.2))
                )
                // iOS 15+ FocusState
                .focused($isKeyboardActive)
            
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

    // MARK: - 메시지 전송
    private func sendMessage() {
        guard !messageText.isEmpty else { return }
        socketManager.sendMessage(username: username, content: messageText)
        messageText = ""
    }

    // MARK: - 마지막 메시지로 스크롤
    private func scrollToLastMessage(_ proxy: ScrollViewProxy) {
        if let lastId = allMessages.last?.id {
            withAnimation {
                proxy.scrollTo(lastId, anchor: .bottom)
            }
        }
    }

    // MARK: - WebSocket
    private func setupWebSocket() {
        socketManager.connect(to: chatRoomId)
    }

    // MARK: - "SHARE"/"EXCHANGE" -> "나눔"/"교환"
    private func displayTradeType(_ type: String) -> String {
        switch type {
        case "SHARE":
            return "나눔"
        case "EXCHANGE":
            return "교환"
        default:
            return type
        }
    }

    // MARK: - 날짜 포맷
    /// "2025-02-20T16:42:20" -> "오후 4:42"
    private func formatToAmPmTime(_ isoString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.locale = Locale(identifier: "ko_KR")
        inputFormatter.timeZone = TimeZone(abbreviation: "UTC")
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        guard let date = inputFormatter.date(from: isoString) else {
            return isoString
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "ko_KR")
        outputFormatter.dateFormat = "a h:mm"
        
        return outputFormatter.string(from: date)
    }

    /// sentTime 포맷 (오전/오후 h:mm)
    private func formatTimeString(_ isoDateString: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withFullDate,
                                      .withTime,
                                      .withFractionalSeconds,
                                      .withDashSeparatorInDate,
                                      .withColonSeparatorInTime]
        if let date = isoFormatter.date(from: isoDateString) {
            let formatter = DateFormatter()
            formatter.dateFormat = "a h:mm"
            formatter.locale = Locale(identifier: "ko_KR")
            return formatter.string(from: date)
        }
        return isoDateString
    }
    func daysUntilExpiration(_ dateString: String) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let expirationDate = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        let now = Date()
        let diffComponents = Calendar.current.dateComponents([.day], from: now, to: expirationDate)
        
        // 4) 남은 일 수 반환
        return diffComponents.day
    }
}
