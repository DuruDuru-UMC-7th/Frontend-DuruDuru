//
//  SignUpRequest.swift
//  DuruDuru
//
//  Created by 이은찬 on 2/11/25.
//

import Foundation

struct SignUpRequest: Encodable {
    let email: String
    let password: String
    let name: String
    let phone: String
}
