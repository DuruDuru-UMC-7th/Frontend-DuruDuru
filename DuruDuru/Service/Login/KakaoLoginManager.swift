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
            // 무조건 loginWithKakaoAccount를 호출합니다.
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    print("loginWithKakaoAccount error: \(error)")
                } else if let oauthToken = oauthToken {
                    continuation.resume(returning: oauthToken.accessToken)
                    print("토큰 : \(oauthToken.accessToken)")
                }
            }
        }
    }
    
    // 로그아웃 함수: UserApi.shared.logout()을 호출하여 카카오 세션 삭제
    func logout(completion: @escaping (Bool) -> Void) {
        UserApi.shared.logout { error in
            if let error = error {
                print("카카오 로그아웃 실패: \(error.localizedDescription)")
                completion(false)
            } else {
                print("카카오 로그아웃 성공")
                completion(true)
            }
        }
    }
}
