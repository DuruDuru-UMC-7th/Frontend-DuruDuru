//
//  TradeRequest.swift
//  DuruDuru
//
//  Created by 윤시진 on 2/17/25.
//

import Foundation

struct TradeRequest: Codable {
    let ingredientId: Int
    let ingredientCount: Int
    let body: String
    let tradeType: String
    let tradeImgUrl: [String]
}
