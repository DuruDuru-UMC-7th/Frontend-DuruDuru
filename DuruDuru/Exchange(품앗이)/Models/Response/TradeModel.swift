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
