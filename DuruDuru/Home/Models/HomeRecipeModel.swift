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
                imageName: "Kevin",
                title: "폭탄계란찜",
                ingredients: ["계란", "대파", "우유", "치즈", "버터"]
            ),
            HomeRecipeModel(
                imageName: "Kevin",
                title: "샐러드",
                ingredients: ["연근", "감자", "오이", "가지", "연어"]
            ),
            HomeRecipeModel(
                imageName: "Kevin",
                title: "크림파스타",
                ingredients: ["파스타", "크림", "치즈", "버섯",]
            ),
            HomeRecipeModel(
                imageName: "Kevin",
                title: "카레",
                ingredients: ["강황", "소금", "감자", "당근"]),
            HomeRecipeModel(
                imageName: "Kevin",
                title: "마라탕후루",
                ingredients: ["마라", "라탕", "탕후", "후루", "루"]),
        ]
    }
}
