//
//  IngredientModel.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/12/25.
//

struct IngredientModel {
    let name: String
    let daysRemaining: String
}

extension IngredientModel {
    static func dummy() -> [IngredientModel] {
        return [
            IngredientModel(name: "콩나물", daysRemaining: "D-3"),
            IngredientModel(name: "어묵", daysRemaining: "D-4"),
            IngredientModel(name: "삼겹살", daysRemaining: "D-5"),
            IngredientModel(name: "대파", daysRemaining: "D-6"),
            IngredientModel(name: "다진마늘", daysRemaining: "D-7"),
            IngredientModel(name: "맛살", daysRemaining: "D-8"),
            IngredientModel(name: "콩나물", daysRemaining: "D-3"),
            IngredientModel(name: "어묵", daysRemaining: "D-4"),
            IngredientModel(name: "삼겹살", daysRemaining: "D-5")
        ]
    }
}
