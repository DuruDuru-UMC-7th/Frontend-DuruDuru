//
//  IngredientModel.swift
//  DuruDuru
//
//  Created by 임효진 on 2/4/25.
//

import Foundation

struct IngredientResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: IngredientResult
}

struct IngredientResult: Codable {
    let count: Int
    let ingredients: [MyIngredient]
}

struct MyIngredient: Codable {
    
    let memberId: Int
    let fridgeId: Int
    let ingredientId: Int
    var ingredientName: String
    var count: Int
    var purchaseDate: String
    var expiryDate: String
    let storageType: String
    let majorCategory: String
    let minorCategory: String
    let ingredientImageUrl: String?
    let createdAt: String
    let updatedAt: String
}

struct DeleteIngredientResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
}
