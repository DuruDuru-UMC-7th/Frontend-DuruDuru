import SwiftUI
import Combine

/// 채팅 목록 화면
struct ChattingTabView: View {
    @StateObject private var viewModel = ChattingTabViewModel()
    @State private var isCreatingChatRoom = false

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    // 헤더
                    HStack {
                        Text("품앗이")
                            .foregroundColor(.green)
                            .bold()
                        Text("함께 먹자")
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .font(.title2)
                    .padding(.horizontal)

                    // 상단 배너 자리
                    Rectangle()
                        .fill(Color(UIColor.systemGray5))
                        .frame(height: 100)
                        .cornerRadius(10)
                        .padding()

                    // 채팅방 목록
                    List(viewModel.chatRooms) { chatRoom in
                        NavigationLink(destination: ChatView(
                            chatRoomId: chatRoom.id,
                            username: chatRoom.username
                        )) {
                            ChatRow(chatRoom: chatRoom)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .refreshable {
                        print("✅ ChattingTabView appeared!")
                        viewModel.loadChatRooms()
                    }
                    .onAppear {
                        print("✅ ChattingTabView appeared!")
                        viewModel.loadChatRooms()
                    }
                }
                .navigationBarHidden(true)

                // 채팅방 추가 버튼
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            createChatRoom()
                        }) {
                            Image(systemName: "plus.message.fill")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                        .padding()
                    }
                }

                // 로딩중
                if isCreatingChatRoom {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                    ProgressView("채팅방 생성 중...")
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 4)
                }
            }
        }
    }

    /// 새로운 채팅방 생성
    private func createChatRoom() {
        isCreatingChatRoom = true

        let tradeId = 1
        ChattingRoomMakeAPI.shared.createChatRoom(tradeId: tradeId) { result in
            DispatchQueue.main.async {
                isCreatingChatRoom = false
                switch result {
                case .success(let chattingRoomId):
                    print("✅ 채팅방 생성 성공: \(chattingRoomId)")
                    viewModel.loadChatRooms()
                case .failure(let error):
                    print("❌ 채팅방 생성 실패: \(error.localizedDescription)")
                }
            }
        }
    }
}
