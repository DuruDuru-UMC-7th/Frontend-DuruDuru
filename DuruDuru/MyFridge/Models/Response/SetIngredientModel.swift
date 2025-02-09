//
//  SetIngredientModel.swift
//  DuruDuru
//
//  Created by 임효진 on 2/9/25.
//

import Foundation

struct SetIngredientResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: SetIngredientResult?
}

struct SetIngredientResult: Codable {
    
    let ingredientId: Int
    let memberId: Int
    let fridgeId: Int
    let ingredientName: String
    let count: Int
    let createdAt: String
}
