//
//  RecommandedRecipeModel.swift
//  DuruDuru
//
//  Created by 임효진 on 2/20/25.
//

import Foundation

struct RecommandedRecipeResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: RecommandedRecipeResult
}

struct RecommandedRecipeResult: Codable {
    let page: Int
    let size: Int
    let totalPages: Int
    let totalElements: Int
    let recipes: [Recipe]
}

struct Recipe: Codable {
    let recipeName: String
    let imageUrl: String
    let favoriteCount: Int
    let availableIngredients: [String]?
    let missingIngredients: [String]?
}
