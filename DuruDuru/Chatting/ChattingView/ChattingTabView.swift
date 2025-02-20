import SwiftUI
import Combine

struct ChattingTabView: View {
    @StateObject private var viewModel = ChattingTabViewModel()
    @State private var isCreatingChatRoom = false
    @State private var myNickname: String = UserDefaults.standard.string(forKey: "myNickname") ?? "알 수 없음"
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    // 헤더 + 배너
                    headerAndBanner
                    
                    // 채팅방 목록 (Pull-to-Refresh 추가)
                    List(viewModel.chatRooms) { chatRoom in
                        NavigationLink(destination: ChatView(
                            chatRoomId: chatRoom.id,
                            username: UserDefaults.standard.string(forKey: "myNickname") ?? "알 수 없음"
                        )) {
                            ChatRow(chatRoom: chatRoom)
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .refreshable { // Pull-to-Refresh 추가
                        refreshChatRooms()
                    }
                    .frame(maxHeight: UIScreen.main.bounds.height * 0.8)
                    .onAppear {
                        refreshChatRooms()
                    }
                    Spacer()
                }
                .navigationBarHidden(true)
                
                // 로딩 중이면 Overlay
                if isCreatingChatRoom {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    ProgressView("채팅방 생성 중...")
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("ChattingTabViewRefresh"))) { _ in
                refreshChatRooms() // ✅ ViewController에서 새로고침 요청 시 동작
            }
        }
    }
    
    private var headerAndBanner: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                Text("품앗이")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold))
                
                Text("함께 먹자")
                    .foregroundColor(.gray)
                    .font(.system(size: 20, weight: .bold))
            }
            .padding(.top, 16)
            .padding(.bottom, 8)
            
            Image("BannerImage")
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width: 370, height: 90)
        }
    }
    
    /// ✅ 닉네임과 채팅 목록 새로고침
    private func refreshChatRooms() {
        loadMyNickname()
        viewModel.loadChatRooms()
        print("🔄 채팅 목록과 닉네임을 새로고침 완료!")
    }
    
    /// ✅ `UserDefaults`에서 닉네임을 가져오거나 기본값 설정
    private func loadMyNickname() {
        if let savedNickname = UserDefaults.standard.string(forKey: "myNickname") {
            myNickname = savedNickname
        } else {
            myNickname = "알 수 없음" // 기본값 설정
        }
        print("🔹 닉네임 설정 완료: \(myNickname)")
    }
}
