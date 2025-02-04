//
//  SetTownRequest.swift
//  DuruDuru
//
//  Created by 임효진 on 2/5/25.
//

import Foundation

struct SetTownRequest: Codable {
    var latitude: Double
    var longitude: Double
    var sido: String
    var sigungu: String
    var eupmyeondong: String
}
