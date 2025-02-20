//
//  ChattingRoomMakeAPI.swift
//  DuruDuru
//
//  Created by 한지강 on 2/17/25.
//

import Foundation
import Alamofire

class ChattingRoomMakeAPI {
    static let shared = ChattingRoomMakeAPI()
    private let baseURL = "http://3.35.252.162:8080"

    func createChatRoom(tradeId: Int, completion: @escaping (Result<ChattingRoomMakeResult, Error>) -> Void) {  // 🔹 반환 타입 변경
        let url = "\(baseURL)/chat/"
        let parameters: [String: Any] = ["tradeId": tradeId]

        APIClient.shared.request(url, method: .post, parameters: parameters) { (result: Result<ChattingRoomMakeResponse, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data.result))  // 🔹 전체 응답을 반환하도록 수정
            case .failure(let error):
                print("❌ 채팅방 생성 실패: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
