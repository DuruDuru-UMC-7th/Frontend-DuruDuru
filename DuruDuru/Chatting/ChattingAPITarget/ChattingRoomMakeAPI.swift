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

    
    func createChatRoom(tradeId: Int, completion: @escaping (Result<Int, Error>) -> Void) {
        let url = "\(baseURL)/chat/"  //

        let parameters: [String: Any] = ["tradeId": tradeId]

        APIClient.shared.request(url, method: .post, parameters: parameters) { (result: Result<ChattingRoomMakeResponse, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data.result.chattingRoomId))
            case .failure(let error):
                print("❌ 채팅방 생성 실패: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
