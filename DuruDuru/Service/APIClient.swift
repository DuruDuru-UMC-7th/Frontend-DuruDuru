//
//  APIClient.swift
//  DuruDuru
//
//  Created by 임효진 on 2/2/25.
//

import Foundation
import Alamofire
final class APIClient {
    static let shared = APIClient()
    
    private let session: Session
    
    private init() {
        let interceptor = AuthorizationInterceptor(accessToken: TokenSave.shared.accessToken ?? "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MiwiaWF0IjoxNzM5ODg3MjA3LCJleHAiOjE3Mzk4OTA4MDd9.mF6nOY0SJBrFh7EsQTfM7UGdmCg6JCwsw3XXLdDN9Lw")
        session = Session(interceptor: interceptor)
    }
    
    public func request<T: Codable>(
        _ url: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        completion: @escaping (Result<T, Error>) -> Void) {
            var headers: HTTPHeaders = [:]
            headers["Content-Type"] = "application/json"
            
            session.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value))
                    case .failure(let error):
                        /// 에러 발생 시 추가 정보 출력
                        if let httpResponse = response.response {
                            print("Error: \(error.localizedDescription)")
                            print("Status Code: \(httpResponse.statusCode)")
                            if let data = response.data,
                               let errorMessage = String(data: data, encoding: .utf8) {
                                print("Response Data: \(errorMessage)")
                            }
                        }
                        completion(.failure(error))
                    }
                }
        }
    
    // multipart/form-data 전송
    public func upload<T: Codable>(
        url: String,
        imageData: Data,
        name: String,
        completion: @escaping (Result<T, Error>) -> Void) {
            
            let headers: HTTPHeaders = [
                "accept": "application/json",
                "Content-Type": "multipart/form-data"
            ]
            
            session.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: name, fileName: "image.png", mimeType: "image/png")
            }, to: url, method: .post, headers: headers)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    /// 에러 발생 시 추가 정보 출력
                    if let httpResponse = response.response {
                        print("Error: \(error.localizedDescription)")
                        print("Status Code: \(httpResponse.statusCode)")
                        if let data = response.data,
                           let errorMessage = String(data: data, encoding: .utf8) {
                            print("Response Data: \(errorMessage)")
                        }
                    }
                    completion(.failure(error))
                }
            }
        }
    
    /// 쿼리 문자열 생성 함수
    func createQueryString(from parameters: [String: Any]) -> String {
        var components: [String] = []
        
        for (key, value) in parameters {
            if let valueString = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                components.append("\(key)=\(valueString)")
            }
        }
        
        return components.joined(separator: "&")
    }
}
