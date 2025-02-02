//
//  ReceiptIngredientsModel.swift
//  DuruDuru
//
//  Created by 임효진 on 2/2/25.
//

import UIKit

struct ResponseReceiptIngredientsModel: Codable {
    
    let purchaseDate: String
    var ingredients: [ResponseIngredientModel]
}

struct ResponseIngredientModel: Codable {
    
    let memberId: Int
    let receiptId: Int
    let fridgeId: Int
    let ingredientId: Int
    let ingredientName: String
    var count: Int
    let majorCategory: String
    let minorCategory: String
    let storageType: String
    let expireDate: String
    
    mutating func setCount(newCount: Int) {
        self.count = newCount
    }
}
