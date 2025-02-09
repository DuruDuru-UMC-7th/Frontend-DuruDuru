//
//  SetIngredientRequest.swift
//  DuruDuru
//
//  Created by 임효진 on 2/9/25.
//

import Foundation

struct SetIngredientRequest: Codable {
    let ingredientName: String
    let count: Int
}
