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

struct SetIngredientTypeResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: SetIngredientTypeResult
}

struct SetIngredientTypeResult: Codable {
    let memberId: Int
    let fridgeId: Int
    let ingredientId: Int
    var ingredientName: String
    let majorCategory: String
    let minorCategory: String
}


struct SetIngredientStorageTypeResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: SetIngredientStorageTypeResult
}

struct SetIngredientStorageTypeResult: Codable {
    let memberId: Int
    let fridgeId: Int
    let ingredientId: Int
    var ingredientName: String
    let storageType: String
}

struct SetIngredientPurchaseDateResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: SetIngredientPurchaseDateResult
}

struct SetIngredientPurchaseDateResult: Codable {
    let memberId: Int
    let fridgeId: Int
    let ingredientId: Int
    var ingredientName: String
    let purchaseDate: String?
}

struct SetIngredientExpiryDateResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: SetIngredientExpiryDateResult
}

struct SetIngredientExpiryDateResult: Codable {
    let memberId: Int
    let fridgeId: Int
    let ingredientId: Int
    var ingredientName: String
    let purchaseDate: String?
    let expiryDate: String?
}


/// 앱에서 사용할 식재료 모델
struct IngredientModel {
    let ingredientId: Int
    let name: String
    var recipes: [RecipeModel]

    init(from apiIngredient: MyIngredient) {
        self.ingredientId = apiIngredient.ingredientId 
        self.name = apiIngredient.ingredientName
        self.recipes = []
    }
}

