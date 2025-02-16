//
//  TradeModel.swift
//  DuruDuru
//
//  Created by 임효진 on 2/2/25.
//

import Foundation

struct TradeResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: TradeResult?
}

struct TradeResult: Codable {
    let tradeId: Int
    let memberId: Int
    let nickName: String
    let ingredientId: Int
    let ingredientCount: Int
    let expiryDate: String
    let title: String
    let body: String
    let eupmyeondong: String
    let status: String
    let tradeType: String
    let likeCount: Int
    let createdAt: String
    let updatedAt: String
    let tradeImgs: [String]?
}

struct OtherTradeResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: OtherTradeResult
}

struct OtherTradeResult: Codable {
    let totalCount: Int
    let tradeList: [OtherTrade]
}

struct OtherTrade: Codable {
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
    let tradeImgs: String
}

struct LikeTradeResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: LikeTradeResult
}

struct LikeTradeResult: Codable {
    let memberId: Int
    let tradeId: Int
    let likeCount: Int
}

struct DeleteLikeTradeResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
}

struct TradeLikeCountResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: TradeLikeCountResult
}

struct TradeLikeCountResult: Codable {
    let tradeId: Int
    let likeCount: Int
}

