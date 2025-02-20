import Foundation
import StompClientLib
import Combine


///  STOMP WebSocket 매니저 (싱글턴 적용)
class ChatWebSocketManager: NSObject, ObservableObject, StompClientLibDelegate {
    
    ///  싱글턴 인스턴스
    static let shared = ChatWebSocketManager()
    
    ///  WebSocket을 통해 수신된 메시지 저장
    @Published var messages: [ChatMessageResponse] = []

    ///  STOMP 클라이언트 인스턴스
    private var socketClient = StompClientLib()

    ///  서버의 WebSocket 엔드포인트 URL
    private let serverURL = URL(string: "ws://3.35.252.162:8080/ws-connect")!

    ///  현재 접속할 채팅방 ID (초기값 nil)
    private var chatRoomId: Int?

    ///  private init (싱글턴 패턴 적용)
    public override init() {
        super.init()
    }

    /// 채팅방 ID 설정 후 WebSocket 연결
    func connect(to chatRoomId: Int) {
        self.chatRoomId = chatRoomId
        
        // ✅ 최신 JWT 가져오기
        guard let jwtToken = TokenSave.shared.accessToken else {
            print("⚠️ JWT 토큰 없음, WebSocket 연결 실패")
            return
        }
        
        var request = URLRequest(url: serverURL)
        request.timeoutInterval = 5
        request.setValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization") // ✅ 최신 JWT 반영

        let headers = ["Authorization": "Bearer \(jwtToken)"] // ✅ 최신 JWT 헤더 추가
        socketClient.openSocketWithURLRequest(request: request as NSURLRequest, delegate: self, connectionHeaders: headers)

        print(" WebSocket 연결 시도 (채팅방 ID: \(chatRoomId))")
    }

    /// ✅ WebSocket 연결 종료
    func disconnect() {
        socketClient.disconnect()
        print("❌ WebSocket 연결 종료")
    }

    /// ✅ 특정 채팅방 메시지 구독
    private func subscribe() {
        guard let chatRoomId = chatRoomId else { return }
        let destination = "/subscribe/chat.\(chatRoomId)"
        socketClient.subscribe(destination: destination)
        print("채팅방 구독 시작: \(destination)")
    }

    /// ✅ 메시지 전송
    func sendMessage(username: String, content: String) {
        guard let chatRoomId = chatRoomId else {
            print("⚠️ 채팅방 ID가 설정되지 않음")
            return
        }
        
        let messageRequest = ChatMessageRequest(username: username, content: content)
        guard let jsonData = try? JSONEncoder().encode(messageRequest),
              let jsonString = String(data: jsonData, encoding: .utf8) else {
            print("⚠️ 메시지 인코딩 실패")
            return
        }

        let destination = "/publish/chat.\(chatRoomId)"
        let headers = ["content-type": "application/json"]
        
        socketClient.sendMessage(message: jsonString, toDestination: destination, withHeaders: headers, withReceipt: nil)
        
        print("📤 메시지 전송: \(jsonString) -> \(destination)")
    }

    // MARK: - StompClientLibDelegate 구현

    func stompClientDidConnect(client: StompClientLib!) {
        print("✅ WebSocket 연결 성공")
        subscribe()
    }

    func stompClientDidDisconnect(client: StompClientLib!) {
        print("❌ WebSocket 연결 종료됨")
    }

    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String: String]?, withDestination destination: String) {
        print("DEBUG: 수신된 원시 메시지 (destination: \(destination)): \(stringBody ?? "nil")")
        if let stringBody = stringBody,
           let data = stringBody.data(using: .utf8),
           let chatMessage = try? JSONDecoder().decode(ChatMessageResponse.self, from: data) {
            DispatchQueue.main.async {
                self.messages.append(chatMessage)
                print("DEBUG: 디코딩 후 수신 메시지: \(chatMessage)")
                print("DEBUG: 전체 메시지 개수: \(self.messages.count)")
            }
        } else {
            print("⚠️ 메시지 디코딩 실패")
        }
    }


    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        print("✅ 서버 수신 확인: \(receiptId)")
    }

    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        print("❌ WebSocket 에러: \(description) \(message ?? "")")
    }

    func serverDidSendPing() {
        print("🔄 서버 Ping 수신")
    }
}
