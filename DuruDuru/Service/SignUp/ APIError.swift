//
//   APIError.swift
//  DuruDuru
//
//  Created by 이은찬 on 2/11/25.
//

import Foundation

enum APIError: Error {
    case networkError
    case invalidURL
    case encodingError
    case serverError(code: String, message: String)
    
    var localizedDescription: String {
        switch self {
        case .networkError:
            return "네트워크 오류가 발생했습니다."
        case .invalidURL:
            return "유효하지 않은 URL입니다."
        case .encodingError:
            return "요청 데이터를 인코딩할 수 없습니다."
        case .serverError(let code, let message):
            return "[\(code)] \(message)"
        }
    }
}
