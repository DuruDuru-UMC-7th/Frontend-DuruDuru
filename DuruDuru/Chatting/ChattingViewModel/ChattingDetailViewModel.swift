//
//  ChattingDetailViewModel.swift
//  DuruDuru
//
//  Created by 한지강 on 2/19/25.
//

import Foundation
import Combine

class ChattingDetailViewModel: ObservableObject {
    @Published var chatRoomDetail: ChattingRoomDetailResult?
    @Published var messages: [ChatMessageResponse] = []

    private var cancellables = Set<AnyCancellable>()

    /// 채팅방 상세 정보 가져오기
    func fetchChatRoomDetail(chatRoomId: Int) {
        ChattingRoomDetailAPI.shared.getChatRoomDetail(chatRoomId: chatRoomId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let detail):
                    self.chatRoomDetail = detail
                    self.messages = detail.chatMessages
                case .failure(let error):
                    print("❌ 채팅방 상세조회 실패: \(error.localizedDescription)")
                }
            }
        }
    }
}
