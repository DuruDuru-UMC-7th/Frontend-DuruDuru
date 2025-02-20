//
//  RecipeDetailModel.swift
//  DuruDuru
//
//  Created by 윤시진 on 2/17/25.
//

import Foundation

/// 특정 레시피 조회 응답 모델
struct RecipeDetailResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: RecipeDetail
}

/// 특정 레시피 상세 정보
struct RecipeDetail: Codable {
    let favoriteCount: Int
    let recipeName: String
    let cookingMethod: String
    let recipeType: String
    let ingredients: String
    let imageUrl: String
    let manualSteps: [String]
    
    var ingredientList: [String] {
        return ingredients.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
    }
}

// 레시피 즐겨찾기 결과
struct LikeRecipeResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: String?
}
