//
//  HomeRecipeModel.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/28/25.
//

import Foundation

struct HomeRecipeResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: HomeRecipeResult
}

struct HomeRecipeResult: Codable {
    let page: Int
    let size: Int
    let totalPages: Int
    let totalElements: Int
    let recipes: [HomeRecipeData]
}

struct HomeRecipeData: Codable {
    let recipeName: String
    let imageUrl: String
    let favoriteCount: Int
    let availableIngredients: [String]
    let missingIngredients: [String]
}

/// UI에서 사용할 모델 변환
struct HomeRecipeModel {
    let imageUrl: String
    let title: String
    let availableIngredients: [String]
    let missingIngredients: [String]
    
    init(from apiRecipe: HomeRecipeData) {
        self.imageUrl = apiRecipe.imageUrl
        self.title = apiRecipe.recipeName
        self.availableIngredients = apiRecipe.availableIngredients
        self.missingIngredients = apiRecipe.missingIngredients
    }
}
