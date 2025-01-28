//
//  IngredientsDataModel.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/28/25.
//

// IngredientsDataModel.swift
struct IngredientData {
    let category: IngredientCategoryModel
    let ingredients: [IngredientSimpleModel]
}

// daysRemaining이 없는 단순 모델
struct IngredientSimpleModel {
    let name: String
}

extension IngredientData {
    static func dummy() -> [IngredientData] {
        return [
            IngredientData(
                category: IngredientCategoryModel(icon: .milk, categoryName: "유제품"),
                ingredients: [
                    IngredientSimpleModel(name: "우유"),
                    IngredientSimpleModel(name: "버터"),
                    IngredientSimpleModel(name: "요구르트")
                ]
            ),
            IngredientData(
                category: IngredientCategoryModel(icon: .fruit, categoryName: "과일"),
                ingredients: [
                    IngredientSimpleModel(name: "사과"),
                    IngredientSimpleModel(name: "배"),
                    IngredientSimpleModel(name: "귤")
                ]
            )
        ]
    }
}
