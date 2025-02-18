//
//  HomeTradeModel.swift
//  DuruDuru
//
//  Created by 윤시진 on 2/18/25.
//

import Foundation

struct HomeTradeModel {
    let tradeId: Int
    let title: String
    let eupmyeondong: String
    let tradeType: String
    let ingredientCount: Int
    var dday: String
    let thumbnailImgURL: String?
    let createdAt: String

    init(from apiTrade: Trade) {
        self.tradeId = apiTrade.tradeId
        self.title = apiTrade.title
        self.eupmyeondong = apiTrade.eupmyeondong
        self.tradeType = apiTrade.tradeType == "SHARE" ? "나눔" : "교환"
        self.ingredientCount = apiTrade.ingredientCount
        self.thumbnailImgURL = apiTrade.thumbnailImgURL
        self.createdAt = formatTimeAgo(apiTrade.createdAt)
        self.dday = calculateDday(expiryDate: apiTrade.expiryDate)
    }
}

    // 날짜를 "남은 소비기한 X일" 형식으로 변환하는 함수
    private func calculateDday(expiryDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let expiry = dateFormatter.date(from: expiryDate) {
            let remainingDays = Calendar.current.dateComponents([.day], from: Date(), to: expiry).day ?? 0
            return "남은 소비기한 \(remainingDays)일"
        }
        return "소비기한 알 수 없음"
    }

    // "공릉동 · 31초 전" 이런 형식으로 변환하는 함수
    private func formatTimeAgo(_ dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]

        if let date = formatter.date(from: dateString) {
            let diff = Int(Date().timeIntervalSince(date))
            if diff < 60 { return "\(diff)초 전" }
            else if diff < 3600 { return "\(diff / 60)분 전" }
            else if diff < 86400 { return "\(diff / 3600)시간 전" }
            else { return "\(diff / 86400)일 전" }
        }
        return "방금 전"
    }
