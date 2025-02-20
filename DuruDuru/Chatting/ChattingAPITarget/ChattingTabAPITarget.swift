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
    func deleteChatRoom(chatRoomId: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        let endpoint = "\(baseURL)/chat/\(chatRoomId)"
        
        /// DELETE 요청
        APIClient.shared.request(endpoint, method: .delete, parameters: nil) { (result: Result<ChatDeleteResponse, Error>) in
            switch result {
            case .success(let response):
                if response.isSuccess {
                    print("✅ 채팅방 삭제 성공: \(chatRoomId)")
                    completion(.success(()))
                } else {
                    // 서버가 isSuccess = false 일 경우 에러로 처리
                    let errorMessage = response.message
                    let error = NSError(domain: "ChatDeleteError", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    completion(.failure(error))
                }
            case .failure(let error):
                print("❌ 채팅방 삭제 실패: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
