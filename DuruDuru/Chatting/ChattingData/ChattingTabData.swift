//
//  ChattingTabData.swift
//  DuruDuru
//
//  Created by 한지강 on 2/14/25.
//

import Foundation

/// 채팅방 목록 응답 모델
struct ChatRoomListResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: ChatRoomListResult
}

struct ChatRoomListResult: Codable {
    let count: Int
    let chatRooms: [ChatRoom]
}

struct ChatRoom: Codable, Identifiable {
    let id: Int
    let username: String
    let tradeImgUrl: String?
    let tradeType: String?
    let lastMessage: String?
    let lastMessageDate: String?
    let unreadCount: Int
    let sentTime: String?

    enum CodingKeys: String, CodingKey {
        case id = "chatRoomId"  
        case username, tradeImgUrl, tradeType, lastMessage, lastMessageDate, unreadCount, sentTime
    }

    // 디코딩할 때 기본값 처리
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        username = try container.decode(String.self, forKey: .username)
        tradeImgUrl = try container.decodeIfPresent(String.self, forKey: .tradeImgUrl)
        tradeType = try container.decodeIfPresent(String.self, forKey: .tradeType)
        lastMessage = try container.decodeIfPresent(String.self, forKey: .lastMessage) ?? "아직 없음"
        lastMessageDate = try container.decodeIfPresent(String.self, forKey: .lastMessageDate) ?? "날짜 없음"
        unreadCount = try container.decodeIfPresent(Int.self, forKey: .unreadCount) ?? 0
        sentTime = try container.decodeIfPresent(String.self, forKey: .sentTime)
    }
}
