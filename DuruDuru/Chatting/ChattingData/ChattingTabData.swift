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

    // MARK: - JSON 디코딩용
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        username = try container.decode(String.self, forKey: .username)
        tradeImgUrl = try container.decodeIfPresent(String.self, forKey: .tradeImgUrl)
        tradeType = try container.decodeIfPresent(String.self, forKey: .tradeType) ?? "알 수 없음"
        lastMessage = try container.decodeIfPresent(String.self, forKey: .lastMessage) ?? "아직 없음"
        lastMessageDate = try container.decodeIfPresent(String.self, forKey: .lastMessageDate)
        unreadCount = try container.decodeIfPresent(Int.self, forKey: .unreadCount) ?? 0
        sentTime = try container.decodeIfPresent(String.self, forKey: .sentTime)
    }

    // MARK: - Preview 등을 위한 편의 이니셜라이저
    init(
        id: Int,
        username: String,
        tradeImgUrl: String? = nil,
        tradeType: String? = nil,
        lastMessage: String? = nil,
        lastMessageDate: String? = nil,
        unreadCount: Int = 0,
        sentTime: String? = nil
    ) {
        self.id = id
        self.username = username
        self.tradeImgUrl = tradeImgUrl
        self.tradeType = tradeType ?? "알 수 없음"
        self.lastMessage = lastMessage ?? "아직 없음"
        self.lastMessageDate = lastMessageDate
        self.unreadCount = unreadCount
        self.sentTime = sentTime
    }

    /// API에서 받은 날짜 문자열을 `M/d` 형식으로 변환
    var formattedLastMessageDate: String {
        guard let lastMessageDate = lastMessageDate else { return "날짜 없음" }
        return formatDateString(lastMessageDate)
    }

    /// 날짜 변환 함수
    private func formatDateString(_ dateString: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        if let date = isoFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "M/d"
            return outputFormatter.string(from: date)
        }

        return "날짜 없음"
    }
}
