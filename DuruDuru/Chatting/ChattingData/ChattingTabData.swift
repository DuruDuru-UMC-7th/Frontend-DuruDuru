//
//  ChattingTabData.swift
//  DuruDuru
//
//  Created by 한지강 on 2/14/25.
//

import Foundation

/// 채팅방 목록 응답 모델
struct ChatRoomListResponse: Codable {
    let count: Int
    let chatRooms: [ChatRoom]
}

/// 개별 채팅방 정보 모델
struct ChatRoom: Codable, Identifiable {
    let id: Int
    let otherNickname: String
    let tradeImgUrl: String?
    let tradeType: String
    let lastMessage: String
    let lastMessageDate: String
    let unreadCount: Int

    // JSON 키와 객체 매핑
    enum CodingKeys: String, CodingKey {
        case id = "chattingRoomId"
        case otherNickname, tradeImgUrl, tradeType, lastMessage, lastMessageDate, unreadCount
    }
}
