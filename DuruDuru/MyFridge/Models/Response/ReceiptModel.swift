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
    
    var purchaseDate: String?
    var ingredients: [ReceiptIngredient]
}

struct ReceiptIngredient: Codable {
    
    let memberId: Int
    let receiptId: Int
    let fridgeId: Int
    let ingredientId: Int
    var ingredientName: String
    var count: Int
    let majorCategory: String
    let minorCategory: String
    let storageType: String
    var expireDate: String
    
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
