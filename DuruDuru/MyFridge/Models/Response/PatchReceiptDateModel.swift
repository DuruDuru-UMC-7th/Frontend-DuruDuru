//
//  PatchReceiptDateModel.swift
//  DuruDuru
//
//  Created by 임효진 on 2/9/25.
//

import Foundation

struct PatchReceiptDateResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: PatchReceiptDateResult?
}

struct PatchReceiptDateResult: Codable {
    let memberId: Int
    let fridgeId: Int
    let receiptId: Int
    var purchaseDate: String
}
