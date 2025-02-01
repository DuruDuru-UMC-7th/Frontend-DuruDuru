//
//  ReceiptModel.swift
//  DuruDuru
//
//  Created by 임효진 on 2/1/25.
//

import UIKit

struct ReceiptModel {
    
    let purchaseDate: String
    let week: String
    var ingredients: [ReceiptIngredients]
}

struct ReceiptIngredients {
    let ingredientName: String
    var count: Int
    
    mutating func setCount(newCount: Int) {
        self.count = newCount
    }
    
}

extension ReceiptModel {
    static func dummy() -> ReceiptModel {
        return ReceiptModel(
            purchaseDate: "2025-04-01",
            week: "화요일",
            ingredients: [
                ReceiptIngredients(ingredientName: "동물복지 IFF 한입쏙 닭가슴살 청양고추", count: 1),
                ReceiptIngredients(ingredientName: "액티비아 플레인 화이트", count: 1),
                ReceiptIngredients(ingredientName: "만능 마라소스", count: 1),
                ReceiptIngredients(ingredientName: "버섯", count: 1),
                ReceiptIngredients(ingredientName: "당근", count: 1),
                ReceiptIngredients(ingredientName: "상추", count: 1),
                ReceiptIngredients(ingredientName: "딸기", count: 1),
                ReceiptIngredients(ingredientName: "토마토", count: 1),
                ReceiptIngredients(ingredientName: "계란", count: 1)
            ]
        )
    }
}



