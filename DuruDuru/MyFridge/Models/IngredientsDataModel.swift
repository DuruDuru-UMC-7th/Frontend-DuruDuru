//
//  IngredientsDataModel.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/28/25.
//

// IngredientsDataModel.swift
struct IngredientsDataModel {
    let category: IngredientCategoryModel
    var ingredients: [IngredientSimpleModel]
}

// daysRemaining이 없는 단순 모델
struct IngredientSimpleModel {
    let name: String
}

extension IngredientsDataModel {
    static func dummy() -> [IngredientsDataModel] {
        return [
            IngredientsDataModel(
                category: IngredientCategoryModel(icon: .milk, categoryName: "유제품"),
                ingredients: [
                    IngredientSimpleModel(name: "우유"),
                    IngredientSimpleModel(name: "버터"),
                    IngredientSimpleModel(name: "요거트")
                ]
            ),
            IngredientsDataModel(
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
