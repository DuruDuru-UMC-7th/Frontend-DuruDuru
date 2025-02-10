//
//  RecipeModel.swift
//  DuruDuru
//
//  Created by 임효진 on 1/13/25.
//

import UIKit

/// 재료
struct IngredientModel {
    
    let name: String
    let recipes: [RecipeModel]
}

/// 레시피
struct RecipeModel {
    
    let titleImage: String
    let recipeName: String
    let tags: [String]
}

extension IngredientModel{
    static func dummy() ->[IngredientModel]{
        return[
            IngredientModel(name:"계란", recipes: [
                RecipeModel(titleImage: "계란 레시피1", recipeName: "황금계란볶음밥"
                            ,tags: ["#초보", "#왕초보", "쉬운요리", "한식"]),
                RecipeModel(titleImage: "계란 레시피2", recipeName: "계란조림"
                            ,tags: ["#계란", "#양식", "쉬운요리", "한식"]),
                RecipeModel(titleImage: "_계란 레시피3", recipeName: "폭탄계란찜"
                            ,tags: ["#계란", "#양식", "쉬운요리", "한식"])
            ]),
            IngredientModel(name:"사과", recipes: [
                RecipeModel(titleImage: "사과 레 1", recipeName: "사과 샌드위치"
                            ,tags: ["#양식", "쉬운요리"]),
                RecipeModel(titleImage: "사과 레 2", recipeName: "사과 토스트"
                            ,tags: ["#양식", "쉬운요리"]),
            ]),
            IngredientModel(name:"돼지고기", recipes: [
                RecipeModel(titleImage: "돼지 레 1", recipeName: "동파육"
                            ,tags: ["#돼지", "#중식", "초보"]),
                RecipeModel(titleImage: "돼지 레 2", recipeName: "삼겹살 덮밥"
                            ,tags: ["#돼지", "한식"]),
                RecipeModel(titleImage: "제육볶음", recipeName: "제육볶음"
                            ,tags: ["#돼지", "제육볶음"])
            ])

        ]
    }
}
