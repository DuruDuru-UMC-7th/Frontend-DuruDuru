//
//  ChattingRoomDetailAPI.swift
//  DuruDuru
//
//  Created by 한지강 on 2/18/25.
//

import Foundation
import Alamofire

class ChattingRoomDetailAPI {
    static let shared = ChattingRoomDetailAPI()
    private let baseURL = "http://3.35.252.162:8080"
    
    /// 특정 채팅방의 상세정보와 메시지 내역을 조회하는 API
    func getChatRoomDetail(chatRoomId: Int, completion: @escaping (Result<ChattingRoomDetailResult, Error>) -> Void) {
        let url = "\(baseURL)/chat/rooms/\(chatRoomId)/messages"
        
        APIClient.shared.request(url, method: .get, parameters: nil) { (result: Result<ChattingRoomDetailResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.result))
            case .failure(let error):
                print("❌ 채팅방 상세조회 실패: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
