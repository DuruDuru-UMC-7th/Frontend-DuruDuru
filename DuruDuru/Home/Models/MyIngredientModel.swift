//
//  MyIngredientModel.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/26/25.
//

import UIKit

struct MyIngredientModel {
    let ingredientImage: UIImage
    let ingredientName: String
}


extension MyIngredientModel {
    static func dummyIngredient() -> [MyIngredientModel] {
        return [
            MyIngredientModel(ingredientImage: UIImage(named: "Kevin") ?? UIImage(), ingredientName: "두부"),
            MyIngredientModel(ingredientImage: UIImage(named: "Kevin") ?? UIImage(), ingredientName: "소고기"),
            MyIngredientModel(ingredientImage: UIImage(named: "Kevin") ?? UIImage(), ingredientName: "돼지고기"),
            MyIngredientModel(ingredientImage: UIImage(named: "Kevin") ?? UIImage(), ingredientName: "연근"),
            MyIngredientModel(ingredientImage: UIImage(named: "Kevin") ?? UIImage(), ingredientName: "오이"),
            MyIngredientModel(ingredientImage: UIImage(named: "Kevin") ?? UIImage(), ingredientName: "가지"),
            MyIngredientModel(ingredientImage: UIImage(named: "Kevin") ?? UIImage(), ingredientName: "올리브오일"),
            MyIngredientModel(ingredientImage: UIImage(named: "Kevin") ?? UIImage(), ingredientName: "광어"),
            MyIngredientModel(ingredientImage: UIImage(named: "Kevin") ?? UIImage(), ingredientName: "방어"),
            MyIngredientModel(ingredientImage: UIImage(named: "Kevin") ?? UIImage(), ingredientName: "커피"),
            MyIngredientModel(ingredientImage: UIImage(named: "Kevin") ?? UIImage(), ingredientName: "밀가루")
            
        ]
    }
}
