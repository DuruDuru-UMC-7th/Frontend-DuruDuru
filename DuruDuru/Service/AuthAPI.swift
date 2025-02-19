//
//  AuthAPI.swift
//  DuruDuru
//
//  Created by 임효진 on 2/19/25.
//

import Foundation
import Alamofire

class AuthAPI {
    static let shared = AuthAPI()
    
    func refreshAuthentication(completion: @escaping (Result<RefreshTokenResponse, Error>) -> Void) {
        let url = "http://3.35.252.162:8080/member/refresh"
        let parameters: [String: String] = [
            "refreshToken": TokenSave.shared.refreshToken ?? ""
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: RefreshTokenResponse.self) { response in
                switch response.result {
                case .success(let refreshResponse):
                    completion(.success(refreshResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

struct RefreshTokenResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: RefreshTokenResult
}

struct RefreshTokenResult: Codable {
    let accessToken: String
    let refreshToken: String
}
