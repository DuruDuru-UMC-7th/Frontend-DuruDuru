//
//  SetIngredientImageModel.swift
//  DuruDuru
//
//  Created by 임효진 on 2/11/25.
//

import Foundation

struct SetIngredientImageResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: SetIngredientImageResult?
}

struct SetIngredientImageResult: Codable {
    let memberId: Int
    let fridgeId: Int
    let ingredientId: Int
    let ingredientName: String
    let ingredientImageUrl: String
}
