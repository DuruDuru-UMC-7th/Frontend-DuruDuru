//
//  HomeRecipeModel.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/28/25.
//

import Foundation

struct HomeRecipeModel {
    let imageName: String      // 음식 이미지 이름
    let title: String          // 음식 제목
    let ingredients: [String] // 재료 리스트
}

extension HomeRecipeModel {
    static func dummyRecipe() -> [HomeRecipeModel] {
        return [
            HomeRecipeModel(
                imageName: "_계란 레시피3",
                title: "폭탄계란찜",
                ingredients: ["계란", "대파", "우유", "치즈", "버터"]
            ),
            HomeRecipeModel(
                imageName: "계란 레시피1",
                title: "양파덮밥",
                ingredients: ["양파", "계란", "대파", "연어"]
            ),
            HomeRecipeModel(
                imageName: "어묵우동",
                title: "어묵우동",
                ingredients: ["어묵", "우동사리", "버섯",]
            )
        ]
    }
}
