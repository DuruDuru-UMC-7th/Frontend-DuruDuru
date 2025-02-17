//
//  CategoryModel.swift
//  DuruDuru
//
//  Created by 윤시진 on 2/3/25.
//

import UIKit

struct CategoryResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: CategoryResult
}

struct CategoryResult: Codable {
    let majorCategory: String
    var minorCategoryList: [MinorCategoryResult]
}

struct MinorCategoryResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: [MinorCategoryResult]
}

struct MinorCategoryResult: Codable {
    let majorCategory: String
    let minorCategory: String
    var categoryImageUrl: String
}

