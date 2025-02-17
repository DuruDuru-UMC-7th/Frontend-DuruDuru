//
//  HomeIngredientModel.swift
//  DuruDuru
//
//  Created by 윤시진 on 2/17/25.
//

import Foundation

// 개별 식재료 정보
struct HomeIngredient: Codable {
    let memberId: Int
    let fridgeId: Int
    let ingredientId: Int
    let ingredientName: String
    let count: Int
    let purchaseDate: String
    let expiryDate: String
    let storageType: String
    let majorCategory: String
    let minorCategory: String
    let ingredientImageUrl: String?
    let createdAt: String
    let updatedAt: String
    let ddayFormatted: String
    let dday: Int
}

struct HomeIngredientResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: HomeIngredientResult
}

struct HomeIngredientResult: Codable {
    let count: Int
    let ingredients: [HomeIngredient]
}
