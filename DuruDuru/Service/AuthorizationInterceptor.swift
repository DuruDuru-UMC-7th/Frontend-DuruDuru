//
//  AuthorizationInterceptor.swift
//  DuruDuru
//
//  Created by 임효진 on 2/2/25.
//

import Foundation
import Alamofire

class AuthorizationInterceptor: RequestInterceptor {
    private var accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        switch response.statusCode {
        case 401: // Unauthorized
            AuthAPI.shared.refreshAuthentication { result in
                switch result {
                case .success(let refreshResponse):
                    // 새로운 accessToken 저장
                    TokenSave.shared.accessToken = refreshResponse.result.accessToken
                    TokenSave.shared.accessToken = refreshResponse.result.refreshToken
                    
                    // AuthorizationInterceptor 업데이트
                    let interceptor = AuthorizationInterceptor(accessToken: TokenSave.shared.accessToken!)
                    APIClient.shared.updateAuthorizationToken(interceptor: interceptor)
                    
                    print("Access Token이 성공적으로 갱신되었습니다.")
                    
                case .failure(let error):
                    print("Error refreshing token: \(error.localizedDescription)")
                }
            }
        default:
            completion(.doNotRetry)
        }
    }
    
}
