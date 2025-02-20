//
//  ChattingRoomMakeData.swift
//  DuruDuru
//
//  Created by 한지강 on 2/17/25.
//

import Foundation

/// 채팅방 생성 응답 모델
struct ChattingRoomMakeResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: ChattingRoomMakeResult
}

/// 채팅방 생성 결과 모델
struct ChattingRoomMakeResult: Codable {
    let chattingRoomId: Int
    let myNickname: String
    let otherNickname: String
    let tradeImgUrl: String?
    let tradeType: String
    let createdAt: String
    let otherMemberImgUrl: String?
    let otherLocation: String?
    let tradeStatus: String?
    let tradeTitle: String
    let ingredientCount: Int?
    let expirationDate: String?
    let chatMessages: [ChatMessageResponse]?
}

