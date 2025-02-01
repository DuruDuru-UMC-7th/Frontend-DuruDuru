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
    let name: String
}

extension IngredientsDataModel {
    static func dummy() -> [IngredientsDataModel] {
        return [
            IngredientsDataModel(
                category: IngredientCategoryModel(icon: .fruit, categoryName: "과일"),
                ingredients: [
                    IngredientSimpleModel(name: "사과"),
                    IngredientSimpleModel(name: "배"),
                    IngredientSimpleModel(name: "포도"),
                    IngredientSimpleModel(name: "감")
                ]
            ),
            IngredientsDataModel(
                category: IngredientCategoryModel(icon: .meat, categoryName: "육류"),
                ingredients: [
                    IngredientSimpleModel(name: "소고기"),
                    IngredientSimpleModel(name: "돼지고기"),
                    IngredientSimpleModel(name: "닭고기"),
                    IngredientSimpleModel(name: "가공육") // (베이컨, 햄 등 가공육 포함)
                ]
            ),
            IngredientsDataModel(
                category: IngredientCategoryModel(icon: .fish, categoryName: "수산물"),
                ingredients: [
                    IngredientSimpleModel(name: "대구"),
                    IngredientSimpleModel(name: "명태"),
                    IngredientSimpleModel(name: "참치")
                ]
            ),
            IngredientsDataModel(
                category: IngredientCategoryModel(icon: .milk, categoryName: "유제품"),
                ingredients: [
                    IngredientSimpleModel(name: "우유"),
                    IngredientSimpleModel(name: "버터"),
                    IngredientSimpleModel(name: "요거트")
                ]
            ),
            IngredientsDataModel(
                category: IngredientCategoryModel(icon: .milk, categoryName: "채소"),
                ingredients: [
                    IngredientSimpleModel(name: "상추"),
                    IngredientSimpleModel(name: "깻잎"),
                    IngredientSimpleModel(name: "오이"),
                    IngredientSimpleModel(name: "다진마늘")
                ]
            ),
            IngredientsDataModel(
                category: IngredientCategoryModel(icon: .milk, categoryName: "버섯"),
                ingredients: [
                    IngredientSimpleModel(name: "팽이버섯"),
                    IngredientSimpleModel(name: "새송이버섯")
                ]
            )
        ]
    }
}
