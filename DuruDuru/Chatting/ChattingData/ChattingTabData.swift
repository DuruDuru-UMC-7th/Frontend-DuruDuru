//
//  ChattingTabData.swift
//  DuruDuru
//
//  Created by 한지강 on 2/14/25.
//

import Foundation

// MARK: - 서버 응답 모델
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

// MARK: - 채팅방 목록 조회용 모델
struct ChatRoom: Codable, Identifiable {
    let id: Int
    let myNickname: String
    let otherNickname: String        
    let tradeType: String?
    let location: String?
    let lastMessage: String?
    let lastMessageDate: String?
    let unreadCount: Int
    let sentTime: String?
    let memberImgUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "chatRoomId"
        case myNickname
        case otherNickname
        case tradeType
        case location
        case lastMessage
        case lastMessageDate
        case unreadCount
        case sentTime
        case memberImgUrl
    }
    
    // JSON 디코딩용 (옵셔널 필드에 기본값 할당)
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        myNickname = try container.decodeIfPresent(String.self, forKey: .myNickname) ?? "알 수 없음"
        otherNickname = try container.decodeIfPresent(String.self, forKey: .otherNickname) ?? "알 수 없음"
        tradeType = try container.decodeIfPresent(String.self, forKey: .tradeType) ?? "알 수 없음"
        location = try container.decodeIfPresent(String.self, forKey: .location)
        lastMessage = try container.decodeIfPresent(String.self, forKey: .lastMessage) ?? "아직 없음"
        lastMessageDate = try container.decodeIfPresent(String.self, forKey: .lastMessageDate)
        unreadCount = try container.decodeIfPresent(Int.self, forKey: .unreadCount) ?? 0
        sentTime = try container.decodeIfPresent(String.self, forKey: .sentTime)
        memberImgUrl = try container.decodeIfPresent(String.self, forKey: .memberImgUrl)
    }
    
    // Preview/테스트용 이니셜라이저
    init(
        id: Int,
        myNickname: String,
        otherNickname: String,
        tradeType: String? = nil,
        location: String? = nil,
        lastMessage: String? = nil,
        lastMessageDate: String? = nil,
        unreadCount: Int = 0,
        sentTime: String? = nil,
        memberImgUrl: String? = nil
    ) {
        self.id = id
        self.myNickname = myNickname
        self.otherNickname = otherNickname
        self.tradeType = tradeType ?? "알 수 없음"
        self.location = location
        self.lastMessage = lastMessage ?? "아직 없음"
        self.lastMessageDate = lastMessageDate
        self.unreadCount = unreadCount
        self.sentTime = sentTime
        self.memberImgUrl = memberImgUrl
    }
    
   
    var tradeTypeDisplay: String {
        switch tradeType {
        case "SHARE":
            return "나눔"
        case "EXCHANGE":
            return "교환"
        default:
            return "알 수 없음"
        }
    }
    
    // 날짜 포맷팅: ISO8601 문자열 → "M/d" 형식
    var formattedLastMessageDate: String {
        guard let dateString = lastMessageDate else { return "날짜 없음" }
        return formatDateString(dateString)
    }
    
    private func formatDateString(_ dateString: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withFullDate, .withTime, .withFractionalSeconds, .withDashSeparatorInDate, .withColonSeparatorInTime]
        if let date = isoFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "M/d"
            outputFormatter.locale = Locale(identifier: "ko_KR")
            return outputFormatter.string(from: date)
        }
        return "2/21"
    }
}
