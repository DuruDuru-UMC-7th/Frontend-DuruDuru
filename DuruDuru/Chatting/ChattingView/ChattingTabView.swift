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
                    
                    // 채팅방 목록
                    List {
                        // MARK: - ForEach + onDelete
                        ForEach(viewModel.chatRooms) { chatRoom in
                            NavigationLink(destination: ChatView(
                                chatRoomId: chatRoom.id,
                                username: UserDefaults.standard.string(forKey: "myNickname") ?? "알 수 없음"
                            )) {
                                ChatRow(chatRoom: chatRoom)
                            }
                            .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: deleteChatRooms)
                    }
                    .listStyle(.plain)
                    .refreshable {
                        refreshChatRooms()
                    }
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
                refreshChatRooms()
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    // MARK: - 헤더 + 배너
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
    
    // MARK: - 닉네임/목록 새로고침
    private func refreshChatRooms() {
        loadMyNickname()
        viewModel.loadChatRooms()
        print("🔄 채팅 목록과 닉네임을 새로고침 완료!")
    }
    
    private func loadMyNickname() {
        if let savedNickname = UserDefaults.standard.string(forKey: "myNickname") {
            myNickname = savedNickname
        } else {
            myNickname = "공릉심청이"
        }
        print("🔹 닉네임 설정 완료: \(myNickname)")
    }
    
    // MARK: - 스와이프 삭제 동작
    private func deleteChatRooms(offsets: IndexSet) {
        // offsets에는 사용자가 스와이프한 셀의 인덱스가 들어옵니다.
        offsets.forEach { index in
            let chatRoom = viewModel.chatRooms[index]
            viewModel.deleteChatRoom(chatRoom.id)
        }
    }
}
