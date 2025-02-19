import SwiftUI
import Combine

/// 채팅 목록 화면
struct ChattingTabView: View {
    @StateObject private var viewModel = ChattingTabViewModel()
    @State private var isCreatingChatRoom = false

    var body: some View {
        NavigationView {
                VStack {
                    // 헤더
                    headerAndBanner

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
    ///헤더와 배너 Vstack
    private var headerAndBanner: some View {
           VStack(alignment: .leading, spacing: 10) {
               
               // 헤더 영역 (HStack)
               HStack(spacing: 8) {
                   Text("품앗이")
                       .foregroundColor(.black)
                       .font(.system(size: 20, weight: .bold))
                   
                   Text("함께 먹자")
                       .foregroundColor(.gray)
                       .font(.system(size: 20, weight: .bold))
               }
               .padding(.top, 16)
               .padding(.bottom, 8) // 헤더 아래 여백
               
               // 배너 영역
               Image("BannerImage")
                   .resizable()
                   .renderingMode(.original) // 템플릿 모드 해제
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 370, height: 90)
                   
           }
       }
    
    ///List로 채팅방 나열하기
    
    
}


#Preview {
    ChattingTabView()
}
