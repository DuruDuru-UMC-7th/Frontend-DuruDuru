//
//  MyIngredientModel.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/26/25.
//

import UIKit
import Foundation

struct MyIngredientModel {
    let ingredientId: Int
    let ingredientName: String
    let ingredientImageUrl: String?

    init(from apiIngredient: MyIngredient) {
        self.ingredientId = apiIngredient.ingredientId
        self.ingredientName = apiIngredient.ingredientName
        self.ingredientImageUrl = apiIngredient.ingredientImageUrl
    }

    init(from ingredientModel: IngredientModel) {
        self.ingredientId = ingredientModel.ingredientId
        self.ingredientName = ingredientModel.name
        self.ingredientImageUrl = ingredientModel.imageUrl
    }
}
