//
//  AuthService.swift
//  DuruDuru
//
//  Created by 이은찬 on 2/11/25.
//

import Alamofire

class AuthService {
    
    static let shared = AuthService() // 싱글톤 인스턴스
    
    private init() {}
    
    /// 회원가입 API 호출
    func registerUser(_ request: SignUpRequest, completion: @escaping (Result<SignUpResponse, APIError>) -> Void) {
        let url = "http://3.35.252.162:8080/member/register"
        
        AF.request(url, method: .post, parameters: request, encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: SignUpResponse.self) { response in
                switch response.result {
                case .success(let data):
                    if data.isSuccess {
                        completion(.success(data))
                    } else {
                        completion(.failure(.serverError(code: data.code, message: data.message)))
                    }
                case .failure:
                    completion(.failure(.networkError))
                }
            }
    }
}
