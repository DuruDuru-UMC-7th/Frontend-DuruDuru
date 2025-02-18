import Alamofire
import Foundation

class SignUpService {
    static let shared = SignUpService()
    
    private init() {}
    
    func signUp(nickname: String, email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        let parameters: [String: String] = [
            "nickname": nickname,
            "email": email,
            "password": password
        ]
        
        let url = "http://3.35.252.162:8080/member/register"
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: SignUpResponse.self) { response in
                switch response.result {
                case .success(let signUpResponse):
                    if signUpResponse.isSuccess {
                        completion(true, nil)
                    } else {
                        completion(false, signUpResponse.message)
                    }
                case .failure:
                    if let data = response.data,
                       let errorResponse = try? JSONDecoder().decode(SignUpResponse.self, from: data) {
                        completion(false, errorResponse.message)
                    } else {
                        completion(false, "네트워킹 오류가 발생했습니다.")
                    }
                }
            }
    }
}
