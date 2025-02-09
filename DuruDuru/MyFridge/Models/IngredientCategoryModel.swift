//
//  IngredientCategoryModel.swift
//  DuruDuru
//
//  Created by 임효진 on 1/9/25.
//

import UIKit

struct IngredientCategoryModel {
    
    let icon: UIImage
    let categoryName: String
}

extension IngredientCategoryModel{
    static func dummy() ->[IngredientCategoryModel]{
        return[
            IngredientCategoryModel(icon: .fruits, categoryName: "과일"),
            IngredientCategoryModel(icon: .meat, categoryName: "육류"),
            IngredientCategoryModel(icon: .fish, categoryName: "수산물"),
            IngredientCategoryModel(icon: .egg, categoryName: "달걀"),
            IngredientCategoryModel(icon: .milk, categoryName: "유제품"),
            IngredientCategoryModel(icon: .vegetable, categoryName: "채소"),
            IngredientCategoryModel(icon: .mushroom, categoryName: "버섯"),
            IngredientCategoryModel(icon: .tofu, categoryName: "두부"),
            IngredientCategoryModel(icon: .driedfood, categoryName: "건조식품"),
            IngredientCategoryModel(icon: .pizza, categoryName: "기타"),
]
    }
}
