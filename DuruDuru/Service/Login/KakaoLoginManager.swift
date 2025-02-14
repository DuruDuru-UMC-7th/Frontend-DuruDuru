//
//  KakaoLoginManager.swift
//  DuruDuru
//
//  Created by 이은찬 on 2/5/25.
//

import Foundation
import Alamofire
import KakaoSDKAuth
import KakaoSDKUser

@MainActor
class KakaoLoginManager {
    static let shared = KakaoLoginManager()
    
    func fetchAccessToken() async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            if UserApi.isKakaoTalkLoginAvailable() {
                UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                        print(error)
                    } else if let oauthToken = oauthToken {
                        continuation.resume(returning: oauthToken.accessToken)
                        print(oauthToken)
                    }
                }
            } else {
                UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else if let oauthToken = oauthToken {
                        continuation.resume(returning: oauthToken.accessToken)
                        print(oauthToken)
                    }
                }
            }
        }
    }
}
