//
//  EmailLoginService.swift
//  DuruDuru
//
//  Created by 이은찬 on 2/18/25.
//

import Alamofire
import Foundation

class EmailLoginService {
    static let shared = EmailLoginService()
    private init() {}
    
    func login(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        
        let url = "http://3.35.252.162:8080/member/login/email"
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: LoginResponse.self) { response in
                print("Login API Response: \(response)")
                switch response.result {
                case .success(let loginResponse):
                    if loginResponse.isSuccess {
                        print("로그인 성공: \(loginResponse)")
                        completion(true, nil)
                    } else {
                        print("로그인 실패: \(loginResponse)")
                        // 오류 코드에 따라 에러 메시지 출력
                        if loginResponse.code == "MEMBER_1007" {
                            completion(false, "이메일 형식이 올바르지 않습니다.")
                        } else if loginResponse.code == "MEMBER_1008" {
                            completion(false, "비밀번호 형식이 올바르지 않습니다.")
                        } else {
                            completion(false, loginResponse.message)
                        }
                    }
                case .failure(let error):
                    print("네트워킹 오류: \(error.localizedDescription)")
                    if let data = response.data, let errorString = String(data: data, encoding: .utf8) {
                        print("에러 응답 데이터: \(errorString)")
                    }
                    completion(false, "네트워킹 오류가 발생했습니다.")
                }
            }
    }
}
