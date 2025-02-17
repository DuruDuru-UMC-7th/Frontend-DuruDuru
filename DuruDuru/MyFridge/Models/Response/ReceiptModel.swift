//
//  ReceiptIngredientsModel.swift
//  DuruDuru
//
//  Created by 임효진 on 2/2/25.
//

import UIKit

struct ReceiptResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: ReceiptResult?
}

struct ReceiptResult: Codable {
    
    var count: Int
    var ingredients: [ReceiptIngredient]
}

struct ReceiptIngredient: Codable {
    
    let memberId: Int
    let fridgeId: Int
    let receiptId: Int
    let ingredientId: Int
    var ingredientName: String
    var count: Int
    var purchaseDate: String
    var expiryDate: String
    var storageType: String
    let majorCategory: String
    let minorCategory: String
    let ingredientImageUrl: String
    let createdAt: String
    let updatedAt: String
    
    mutating func setCount(newCount: Int) {
        self.count = newCount
    }
}

struct ReceiptIngredientEditResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: ReceiptIngredient
}
