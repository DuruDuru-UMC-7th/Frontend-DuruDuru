//
//  NearbyTradeModel.swift
//  DuruDuru
//
//  Created by 윤시진 on 2/15/25.
//


import Foundation

struct NearbyTradeResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: NearbyTradeResult
}

struct NearbyTradeResult: Codable {
    let totalCount: Int
    let tradeList: [NearbyTradeItem]
}

struct NearbyTradeItem: Codable {
    let tradeId: Int
    let memberId: Int
    let ingredientId: Int
    let ingredientCount: Int
    let expiryDate: String
    let title: String
    let eupmyeondong: String
    let status: String
    let tradeType: String
    let likeCount: Int?
    let createdAt: String
    let updatedAt: String
    let thumbnailImgURl: String?
}
