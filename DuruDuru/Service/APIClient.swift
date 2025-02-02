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
//        let interceptor = AuthorizationInterceptor(accessToken: "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6NSwiaWF0IjoxNzM4NDk0OTc4LCJleHAiOjE3Mzg0OTg1Nzh9.bj3DkGLnDRtWHgvUvH3IQJePUbiWgoeeo2iOxtd6Vf8")
        session = Session()
    }
    
    public func request<T: Codable>(
        _ url: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        completion: @escaping (Result<T, Error>) -> Void) {
            session.request(url, method: method, parameters: parameters)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    /// OCR을 위한 multipart/form-data 전송
    public func upload<T: Codable>(
        url: String,
        memberId: Int,
        imageData: Data,
        completion: @escaping (Result<T, Error>) -> Void) {
            
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "multipart/form-data"
        ]
        
        session.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(Data(String(memberId).utf8),
                                     withName: "memberId")
            multipartFormData.append(imageData, withName: "file", fileName: "image.png", mimeType: "image/png")
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
}
