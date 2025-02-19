//
//  MyTradeModel.swift
//  DuruDuru
//
//  Created by 임효진 on 2/9/25.
//

import Foundation

struct MyTradeModel {
    let tradeId: Int
    let memberId: Int
    let title: String
    let eupmyeondong: String
    let tradeType: String
    let image: String?

    init(from tradeItem: ActiveTradeItem) {
        self.tradeId = tradeItem.tradeId
        self.memberId = tradeItem.memberId
        self.title = tradeItem.title
        self.eupmyeondong = tradeItem.eupmyeondong
        self.tradeType = tradeItem.tradeType
        self.image = tradeItem.thumbnailImgUrl
    }
}

struct OtherTradeModel {
    let image: String
    let name: String
    let tradeType: String
    
    /// 기존 더미 데이터를 위한 생성자
    init(image: String, name: String, tradeType: String) {
        self.image = image
        self.name = name
        self.tradeType = tradeType
    }
    
    /// 서버에서 받은 `NearbyTradeItem`을 변환하는 생성자
    init(from tradeItem: NearbyTradeItem) {
        self.name = tradeItem.title
        self.tradeType = tradeItem.tradeType
        self.image = tradeItem.thumbnailImgUrl ?? "defaultImage"
    }
}


