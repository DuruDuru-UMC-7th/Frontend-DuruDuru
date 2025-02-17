//
//  ChattingTabViewModel.swift
//  DuruDuru
//
//  Created by 한지강 on 2/14/25.
//

import Foundation
import Combine

/// 채팅방 목록을 관리하는 ViewModel
class ChatViewModel: ObservableObject {
    @Published var chatRooms: [ChatRoom] = []
    private var cancellables = Set<AnyCancellable>()

    func loadChatRooms(memberId: Int) {
        ChattingTabAPITarget.shared.fetchChatRooms(memberId: memberId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let chatRooms):
                    self.chatRooms = chatRooms
                case .failure(let error):
                    print("채팅방 목록 불러오기 실패: \(error)")
                }
            }
        }
    }
}
