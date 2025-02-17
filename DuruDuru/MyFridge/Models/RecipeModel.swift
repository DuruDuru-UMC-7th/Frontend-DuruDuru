//
//  RecipeModel.swift
//  DuruDuru
//
//  Created by 임효진 on 1/13/25.
//

import UIKit
import Foundation


/// API 응답을 위한 레시피 데이터 모델
struct RecipeResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: RecipeResult
}

/// 레시피 리스트의 페이지네이션 데이터 포함
struct RecipeResult: Codable {
    let page: Int
    let size: Int
    let totalPages: Int
    let totalElements: Int
    let recipes: [RecipeData]
}

/// 개별 레시피 데이터
struct RecipeData: Codable {
    let recipeName: String
    let imageUrl: String
    let favoriteCount: Int
}


/// 앱에서 사용할 레시피 모델
struct RecipeModel {
let titleImage: String
let recipeName: String
let favoriteCount: Int
let tags: [String]

init(from apiRecipe: RecipeData) {
    self.titleImage = apiRecipe.imageUrl
    self.recipeName = apiRecipe.recipeName
    self.favoriteCount = apiRecipe.favoriteCount
    self.tags = RecipeModel.generateTags(from: apiRecipe.recipeName)
}

/// 태그를 생성하는 함수
static func generateTags(from recipeName: String) -> [String] {
    let keywords = ["찜", "국", "샐러드", "볶음", "구이", "김치"] // 대표적인 요리 키워드
    var tags: [String] = []
    
    for keyword in keywords {
        if recipeName.contains(keyword) {
            tags.append("#\(keyword)")
        }
    }
    
    return tags.isEmpty ? ["#요리"] : tags // 기본 태그 제공
}
}

