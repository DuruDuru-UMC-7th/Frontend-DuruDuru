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
                    // 내 닉네임 저장
                    if let firstRoom = chatRooms.first {
                        UserDefaults.standard.set(firstRoom.myNickname, forKey: "myNickname")
                        print("✅ 내 닉네임 저장됨: \(firstRoom.myNickname)")
                    }
                case .failure(let error):
                    print("❌ 채팅방 불러오기 실패: \(error.localizedDescription)")
                }
            }
        }
    }
    
    /// 삭제 기능 추가
    func deleteChatRoom(_ chatRoomId: Int) {
        ChattingTabAPITarget.shared.deleteChatRoom(chatRoomId: chatRoomId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("✅ 채팅방 삭제 완료: \(chatRoomId)")
                    self.refreshChatRooms()
                case .failure(let error):
                    print("❌ 채팅방 삭제 실패: \(error.localizedDescription)")
                }
            }
        }
    }
    
    /// 새로고침 함수
    func refreshChatRooms() {
        print("🔄 채팅방 목록 새로고침")
        loadChatRooms()
    }
}
