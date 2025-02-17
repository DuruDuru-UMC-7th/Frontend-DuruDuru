//
//  TradeHistoryModel.swift
//  DuruDuru
//
//  Created by 윤시진 on 2/17/25.
//

import Foundation

struct TradeHistoryResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: TradeHistoryResult
}

struct TradeHistoryResult: Codable {
    let totalCount: Int
    let tradeList: [TradeItem]
}

struct TradeItem: Codable {
    let tradeId: Int
    let memberId: Int
    let ingredientId: Int
    let ingredientCount: Int
    let expiryDate: String
    let title: String
    let eupmyeondong: String
    let status: String
    let tradeType: String
    let likeCount: Int
    let createdAt: String
    let updatedAt: String
    let thumbnailImgUrl: String?
}
