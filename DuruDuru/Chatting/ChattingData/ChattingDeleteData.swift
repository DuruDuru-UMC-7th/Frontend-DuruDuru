//
//  ChattingDeleteData.swift
//  DuruDuru
//
//  Created by 한지강 on 2/21/25.
//

/// 채팅방 삭제 응답 모델
struct ChatDeleteResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: String?
}
