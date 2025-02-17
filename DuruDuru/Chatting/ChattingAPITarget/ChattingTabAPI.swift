import Alamofire
import Foundation

/// 채팅 API 요청을 관리하는 클래스
class ChattingTabAPITarget {
    static let shared = ChattingTabAPITarget()
    private let baseURL = "http://3.35.252.162:8080"

    func fetchChatRooms(memberId: Int, completion: @escaping (Result<[ChatRoom], Error>) -> Void) {
        let endpoint = "\(baseURL)/chat/rooms"
        let parameters: Parameters = ["memberId": memberId]
        
        let queryString = APIClient.shared.createQueryString(from: parameters)
        let urlWithQuery = "\(endpoint)?\(queryString)"
        
        APIClient.shared.request(urlWithQuery, method: .get, parameters: nil) { (result: Result<ChatRoomListResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.result.chatRooms))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
