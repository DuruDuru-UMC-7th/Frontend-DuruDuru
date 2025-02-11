//
//  SignUpResponse.swift
//  DuruDuru
//
//  Created by 이은찬 on 2/11/25.
//

import Foundation

struct SignUpResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: String?
}
