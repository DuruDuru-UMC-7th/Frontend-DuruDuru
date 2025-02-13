//
//  ActiveTradeModel.swift
//  DuruDuru
//
//  Created by 윤시진 on 2/14/25.
//

import Foundation

// 품앗이 리스트 조회 응답 모델
struct ActiveTradeResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: ActiveTradeResult?
}

// 품앗이 리스트 조회 결과
struct ActiveTradeResult: Codable {
    let totalCount: Int
    let tradeList: [ActiveTradeItem]?
}

// 개별 품앗이 아이템
struct ActiveTradeItem: Codable {
    let tradeId: Int
    let memberId: Int
    let ingredientId: Int
    let ingredientCount: Int
    let expiryDate: String?
    let title: String
    let eupmyeondong: String
    let status: String
    let tradeType: String
    let likeCount: Int
    let createdAt: String
    let updatedAt: String
    let thumbnailImgUrl: String?

    enum CodingKeys: String, CodingKey {
        case tradeId, memberId, ingredientId, ingredientCount, expiryDate, title, eupmyeondong, status, tradeType, likeCount, createdAt, updatedAt
        case thumbnailImgUrl = "thumbnailImgUrl" 
    }
}
