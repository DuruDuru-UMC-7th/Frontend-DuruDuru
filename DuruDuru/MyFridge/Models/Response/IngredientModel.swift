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
    let result: IngredientResult?
}

struct IngredientResult: Codable {
    
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
