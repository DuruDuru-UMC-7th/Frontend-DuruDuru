//
//  IngredientsDataModel.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/28/25.
//

// IngredientsDataModel.swift
// IngredientsDataModel.swift
struct IngredientsDataModel {
    let category: IngredientCategoryModel
    var ingredients: [IngredientSimpleModel]
}

// daysRemaining이 없는 단순 모델
struct IngredientSimpleModel {
    let image: String
    let name: String
}

extension IngredientsDataModel {
    static func dummy() -> [IngredientsDataModel] {
        return [
            IngredientsDataModel(
                category: IngredientCategoryModel(icon: .fruits, categoryName: "과일"),
                ingredients: [
                    IngredientSimpleModel(image: "사과", name: "사과"),
                    IngredientSimpleModel(image: "배", name: "배"),
                    IngredientSimpleModel(image: "망고", name: "망고"),
                    IngredientSimpleModel(image: "멜론", name: "멜론"),
                    IngredientSimpleModel(image: "청포도", name: "청포도"),
                    IngredientSimpleModel(image: "삼겹살", name: "삼겹살"),
                    IngredientSimpleModel(image: "어묵", name: "어묵"),
                    IngredientSimpleModel(image: "우유", name: "우유"),
                    IngredientSimpleModel(image: "아이스크림", name: "아이스크림"),
                    IngredientSimpleModel(image: "버터", name: "버터"),
                    IngredientSimpleModel(image: "요거트", name: "요거트")
                ]
            ),
            IngredientsDataModel(
                category: IngredientCategoryModel(icon: .meat, categoryName: "육류"),
                ingredients: [
                    IngredientSimpleModel(image: "감겹살", name: "삼겹살")
                    ]
            ),
            IngredientsDataModel(
                category: IngredientCategoryModel(icon: .fish, categoryName: "수산물"),
                ingredients: [
                    IngredientSimpleModel(image: "어묵", name: "어묵")
                    ]
            ),
            IngredientsDataModel(
                category: IngredientCategoryModel(icon: .milk, categoryName: "유제품"),
                ingredients: [
                    IngredientSimpleModel(image: "우유", name: "우유"),
                    IngredientSimpleModel(image: "아이스크림", name: "아이스크림"),
                    IngredientSimpleModel(image: "버터", name: "버터"),
                    IngredientSimpleModel(image: "요거트", name: "요거트")
                ]
            ),
            IngredientsDataModel(
                category: IngredientCategoryModel(icon: .vegetable, categoryName: "채소"),
                ingredients: [
                    IngredientSimpleModel(image: "콩나물", name: "콩나물")
                ]
            ),
            IngredientsDataModel(
                category: IngredientCategoryModel(icon: .mushroom, categoryName: "건조식품"),
                ingredients: [
                    IngredientSimpleModel(image:"자른미역", name: "마른 미역")
                    ]
            ),
            IngredientsDataModel(
                category: IngredientCategoryModel(icon: .mushroom, categoryName: "계란"),
                ingredients: [
                    IngredientSimpleModel(image:"품앗이-계란 미역", name: "계란")
                    ]
            )
        ]
    }
}
