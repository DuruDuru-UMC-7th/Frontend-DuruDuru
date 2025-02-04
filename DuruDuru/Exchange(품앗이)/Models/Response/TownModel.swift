//
//  TownModel.swift
//  DuruDuru
//
//  Created by 임효진 on 2/5/25.
//

import Foundation

struct TownResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: TownModel?
}

struct TownModel: Codable {
    let townId: Int
    let memberId: Int
    let latitude: Double
    let longitude: Double
    let sido: String
    let sigungu: String
    let eupmyeondong: String
}
