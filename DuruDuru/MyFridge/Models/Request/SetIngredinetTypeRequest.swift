//
//  SetIngredinetTypeRequest.swift
//  DuruDuru
//
//  Created by 임효진 on 2/14/25.
//

import Foundation

struct SetIngredientTypeRequest: Codable {
    let majorCategory: String
    let minorCategory: String
}
