//
//  ChattingTabAPI.swift
//  DuruDuru
//
//  Created by 한지강 on 2/14/25.
//


import Alamofire
import Foundation

/// 채팅 API 요청을 관리
class ChattingTabAPITarget {
    static let shared = ChattingTabAPITarget()
    private let baseURL = "http://3.35.252.162:8080"

    func fetchChatRooms(memberId: Int, completion: @escaping (Result<[ChatRoom], Error>) -> Void) {
        let url = "\(baseURL)/chat/rooms"
        let parameters: Parameters = ["memberId": memberId]

        APIClient.shared.request(url, method: .get, parameters: parameters) { (result: Result<ChatRoomListResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.chatRooms))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
