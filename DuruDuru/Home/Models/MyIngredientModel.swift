//
//  MyIngredientModel.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/26/25.
//

import UIKit

//struct MyIngredientModel {
//    let ingredientImage: UIImage
//    let ingredientName: String
//}
//
//
//extension MyIngredientModel {
//    static func dummyIngredient() -> [MyIngredientModel] {
//        return [
//            MyIngredientModel(ingredientImage: UIImage(named: "다진마늘") ?? UIImage(), ingredientName: "다진마늘"),
//            MyIngredientModel(ingredientImage: UIImage(named: "콩나물") ?? UIImage(), ingredientName: "콩나물"),
//            MyIngredientModel(ingredientImage: UIImage(named: "우유") ?? UIImage(), ingredientName: "우유"),
//            MyIngredientModel(ingredientImage: UIImage(named: "삼겹살") ?? UIImage(), ingredientName: "삼겹살"),
//            MyIngredientModel(ingredientImage: UIImage(named: "가래떡") ?? UIImage(), ingredientName: "가래떡")
//        ]
//    }
//}

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
        self.ingredientImageUrl = nil // IngredientModel에는 이미지 URL이 없으므로 기본값 설정
    }
}
