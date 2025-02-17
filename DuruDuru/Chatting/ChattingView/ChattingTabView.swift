//
//  ChattingTabView.swift
//  DuruDuru
//
//  Created by 한지강 on 2/14/25.
//
import SwiftUI
import Combine

/// 채팅방 목록 화면
import SwiftUI

/// 채팅 목록 화면
struct ChattingTabView: View {
    @StateObject private var viewModel = ChatViewModel()

    var body: some View {
        NavigationView {
            VStack {
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

                Rectangle()
                    .fill(Color(UIColor.systemGray5))
                    .frame(height: 100)
                    .cornerRadius(10)
                    .padding()

                List(viewModel.chatRooms) { chatRoom in
                    NavigationLink(destination: Text("채팅방 상세 화면")) {
                        ChatRow(chatRoom: chatRoom)
                    }
                }
                .listStyle(PlainListStyle())
                .onAppear {
                    viewModel.loadChatRooms(memberId: 1)
                }
            }
            .navigationBarHidden(true)
        }
    }
}
#Preview {
    ChattingTabView()
}
