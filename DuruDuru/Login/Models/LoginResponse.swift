//
//  LoginResponse.swift
//  DuruDuru
//
//  Created by 이은찬 on 2/18/25.
//

struct LoginResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: LoginResult?
}

struct LoginResult: Codable {
    let accessToken: String
    let refreshToken: String
    let memberId: Int
}
