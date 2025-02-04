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
    let result: TradeModel?
}

struct TradeModel: Codable {
    let tradeId: Int
    let memberId: Int
    let ingredientId: Int
    let ingredientCount: Int
    let expiryDate: String?
    let title: String
    let body: String
    let status: String
    let tradeType: String
    let createdAt: String
    let updatedAt: String
}
