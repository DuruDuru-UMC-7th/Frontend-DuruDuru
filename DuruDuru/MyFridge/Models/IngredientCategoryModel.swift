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
            IngredientCategoryModel(icon: .fruit, categoryName: "과일"),
            IngredientCategoryModel(icon: .meat, categoryName: "육류"),
            IngredientCategoryModel(icon: .fish, categoryName: "수산물"),
            IngredientCategoryModel(icon: .milk, categoryName: "달걀"),
            IngredientCategoryModel(icon: .milk, categoryName: "유제품"),
            IngredientCategoryModel(icon: .milk, categoryName: "채소"),
            IngredientCategoryModel(icon: .milk, categoryName: "버섯"),
            IngredientCategoryModel(icon: .milk, categoryName: "두부"),
            IngredientCategoryModel(icon: .dryFood, categoryName: "건조식품"),
            IngredientCategoryModel(icon: .milk, categoryName: "기타"),
]
    }
}
