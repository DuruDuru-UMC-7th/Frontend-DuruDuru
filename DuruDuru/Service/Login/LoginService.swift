//
//  LoginService.swift
//  DuruDuru
//
//  Created by 이은찬 on 2/5/25.
//

import Foundation
import Alamofire

class LoginService {
    static var shared = LoginService()
    
    let baseURL = "http://3.35.252.162:8080/member/login/kakao"
    
    func kakaoLogin(completion: @escaping (Bool) -> Void) {
        Task {
            do {
                // Access Token 가져오기
                let accessToken = try await KakaoLoginManager.shared.fetchAccessToken()

                // 쿼리스트링으로 Access Token 전달
                let parameters: [String: String] = ["accessToken": accessToken]
                
                // GET 요청
                AF.request(baseURL, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                    .validate(statusCode: 200..<300)
                    .responseData { response in
                        switch response.result {
                        case .success(let data):
                            do {
                                let decodedResponse = try JSONDecoder().decode(KakaoResponse.self, from: data)
                                // 토큰 저장
                                TokenSave.shared.accessToken = decodedResponse.result.accessToken
                                TokenSave.shared.refreshToken = decodedResponse.result.refreshToken
                                completion(true)
                            } catch {
                                print("응답 디코딩 실패: \(error)")
                                completion(false)
                            }
                        case .failure(let error):
                            // 400 에러 발생 시 JSON 응답 내용 출력
                            if let data = response.data {
                                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                                    print("에러 응답 JSON: \(json)")
                                } else {
                                    print("에러 응답 데이터를 JSON으로 변환할 수 없음")
                                }
                            }
                            print("카카오 에러: \(error.localizedDescription)")
                            completion(false)
                        }
                    }
            } catch {
                print("Access Token 가져오기 실패: \(error)")
                completion(false)
            }
        }
    }
}
struct KakaoResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: KakaoResult
}

struct KakaoResult: Codable {
    let accessToken: String
    let refreshToken: String
    let memberId: Int
}
