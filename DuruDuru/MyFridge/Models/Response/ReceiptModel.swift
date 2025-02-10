//
//  ReceiptIngredientsModel.swift
//  DuruDuru
//
//  Created by 임효진 on 2/2/25.
//

import UIKit

struct ReceiptResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: ReceiptResult?
}

struct ReceiptResult: Codable {
    
    var purchaseDate: String?
    var ingredients: [IngredientResult]
}
