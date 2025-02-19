//
//  ChattingTabAPITarget.swift
//  DuruDuru
//
//  Created by 한지강 on 2/18/25.
//

import Alamofire
import Foundation

/// 채팅 API 요청을 관리하는 클래스
class ChattingTabAPITarget {
    static let shared = ChattingTabAPITarget()
    private let baseURL = "http://3.35.252.162:8080"

    func fetchChatRooms(completion: @escaping (Result<[ChatRoom], Error>) -> Void) {
        print("API 요청 시작: 채팅방 목록 조회")

        let endpoint = "\(baseURL)/chat/rooms"
        APIClient.shared.request(endpoint, method: .get, parameters: nil) { (result: Result<ChatRoomListResponse, Error>) in
            switch result {
            case .success(let response):
                print(" API 응답 성공: \(response.result.chatRooms.count)개의 채팅방 수신됨")
                completion(.success(response.result.chatRooms))
            case .failure(let error):
                print(" API 요청 실패: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
