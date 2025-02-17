//
//  RecipeModel.swift
//  DuruDuru
//
//  Created by 임효진 on 1/13/25.
//

import UIKit

///// 재료
//struct IngredientModel {
//    
//    let name: String
//    let recipes: [RecipeModel]
//}

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

    /// API 응답을 변환하여 모델에 저장
    init(from apiRecipe: RecipeData) {
        self.titleImage = apiRecipe.imageUrl
        self.recipeName = apiRecipe.recipeName
        self.favoriteCount = apiRecipe.favoriteCount
    }
}



//extension IngredientModel{
//    static func dummy() ->[IngredientModel]{
//        return[
//            IngredientModel(name:"계란", recipes: [
//                RecipeModel(titleImage: "계란 레시피1", recipeName: "황금계란볶음밥"
//                            ,tags: ["#초보", "#왕초보", "쉬운요리", "한식"]),
//                RecipeModel(titleImage: "계란 레시피2", recipeName: "계란조림"
//                            ,tags: ["#계란", "#양식", "쉬운요리", "한식"]),
//                RecipeModel(titleImage: "_계란 레시피3", recipeName: "폭탄계란찜"
//                            ,tags: ["#계란", "#양식", "쉬운요리", "한식"])
//            ]),
//            IngredientModel(name:"사과", recipes: [
//                RecipeModel(titleImage: "사과 레 1", recipeName: "사과 샌드위치"
//                            ,tags: ["#양식", "쉬운요리"]),
//                RecipeModel(titleImage: "사과 레 2", recipeName: "사과 토스트"
//                            ,tags: ["#양식", "쉬운요리"]),
//            ]),
//            IngredientModel(name:"돼지고기", recipes: [
//                RecipeModel(titleImage: "돼지 레 1", recipeName: "동파육"
//                            ,tags: ["#돼지", "#중식", "초보"]),
//                RecipeModel(titleImage: "돼지 레 2", recipeName: "삼겹살 덮밥"
//                            ,tags: ["#돼지", "한식"]),
//                RecipeModel(titleImage: "제육볶음", recipeName: "제육볶음"
//                            ,tags: ["#돼지", "제육볶음"])
//            ])
//
//        ]
//    }
//}
