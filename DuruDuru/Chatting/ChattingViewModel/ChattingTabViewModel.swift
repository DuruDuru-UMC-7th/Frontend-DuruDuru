//
//  ChattingTabViewModel.swift
//  DuruDuru
//
//  Created by 한지강 on 2/18/25.
//

import Foundation
import Combine

/// 채팅방 목록을 관리하는 ViewModel
class ChattingTabViewModel: ObservableObject {
    @Published var chatRooms: [ChatRoom] = []

    func loadChatRooms() {
        print("🟢 loadChatRooms() 실행됨") 

        ChattingTabAPITarget.shared.fetchChatRooms { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let chatRooms):
                    print("✅ 채팅방 목록 업데이트됨: \(chatRooms.count)개")
                    self.chatRooms = chatRooms
                case .failure(let error):
                    print("❌ 채팅방 불러오기 실패: \(error.localizedDescription)")
                }
            }
        }
    }
}
