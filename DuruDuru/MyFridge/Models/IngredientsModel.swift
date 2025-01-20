//
//  IngredientModel.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/12/25.
//

struct IngredientsModel {
    let name: String
    let daysRemaining: String
}

extension IngredientsModel {
    static func dummy() -> [IngredientsModel] {
        return [
            IngredientsModel(name: "콩나물", daysRemaining: "D-3"),
            IngredientsModel(name: "어묵", daysRemaining: "D-4"),
            IngredientsModel(name: "삼겹살", daysRemaining: "D-5"),
            IngredientsModel(name: "대파", daysRemaining: "D-6"),
            IngredientsModel(name: "다진마늘", daysRemaining: "D-7"),
            IngredientsModel(name: "맛살", daysRemaining: "D-8"),
            IngredientsModel(name: "콩나물", daysRemaining: "D-3"),
            IngredientsModel(name: "어묵", daysRemaining: "D-4"),
            IngredientsModel(name: "삼겹살", daysRemaining: "D-5")
        ]
    }
}
