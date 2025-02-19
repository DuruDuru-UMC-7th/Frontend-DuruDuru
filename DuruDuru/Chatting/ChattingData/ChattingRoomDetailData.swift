//
//  ChattingDetailData.swift
//  DuruDuru
//
//  Created by 한지강 on 2/18/25.
//

import Foundation

/// 채팅방 상세조회 응답 모델
struct ChattingRoomDetailResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: ChattingRoomDetailResult
}

/// 채팅방 상세조회 결과 모델
struct ChattingRoomDetailResult: Codable {
    let chattingRoomId: Int
    let otherNickname: String
    let tradeImgUrl: String?
    let tradeType: String
    let tradeTitle: String
    let createdAt: String
    let otherMemberImgUrl: String?
    let otherLocation: String?
    let tradeStatus: String
    let ingredientCount: Int?
    let expirationDate: String?
    let chatMessages: [ChatMessageResponse]
}

