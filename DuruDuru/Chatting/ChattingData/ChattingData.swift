//
//  ChattingData.swift
//  DuruDuru
//
//  Created by 한지강 on 2/18/25.
//
import Foundation

/// 서버에 전송할 메시지 모델
struct ChatMessageRequest: Codable {
    let username: String
    let content: String
}

/// 서버로부터 수신한 메시지 모델
struct ChatMessageResponse: Codable, Identifiable {
    var id = UUID()
    let username: String
    let content: String
    let sentTime: String?
    
    enum CodingKeys: String, CodingKey {
        case username, content, sentTime
    }
}
