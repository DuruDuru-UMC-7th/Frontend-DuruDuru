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


//extension MyTradeModel {
//    static func dummy() -> [MyTradeModel] {
//        return [
//            MyTradeModel(image: "https://s3-alpha-sig.figma.com/img/ba06/ae18/445e46c52a15161a8f7e2967dac8ad47?Expires=1739750400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=JbeFB2H2rrT-A0vZ06itXivD~Rc3FrIs1qKP1z71HP8YSpch-fJ~pPE81EZokH-1QQuevPqeIDkpGgd1I~NYHbd~kwWRLnBHAGaSTFVAmaqf-30jjceLZOD5iVQWTDbCRf2uOL~yJPOYvGOU2KNlmtzchz9C3xQ8fA4ik1qrTi3dPw6-k6FB70bXSSYix5f3h41koRRAtegWaYARuIuadVEVMKpSq4N8vlJATYE0ecLDt~BaR3owmuS3GGByILAmj~ojcPvrBtVVdIrP~RPAOJF7OvD3kI7IYemQav9SyOhJqp2lNnAuOF1txFLC~DzHfYgiFn7SZcE3Hg9dcWmX-g__", name: "깐마늘", tradeType: "나눔"),
//            MyTradeModel(image: "https://s3-alpha-sig.figma.com/img/ea4f/461e/271b4802a84c7c5e49a5d4720d9ce381?Expires=1739750400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=TTW8gpr3TDPtUbyiYpWcXLDHy3TQO5ozOWREW691T1PtDLOfD4ft0Eag2d2mgLzSij5uQkHXTK8eAmdvXGqf2EZV4BUCXpYm5xodCG1oIzIFu-7NnmLkz9aAndskdHF6ey2I0fx0g50EXSbEyvfpLNj~59yRlw8IJBGjR0QyB3ewHoZ1sqemSrTcPAGmXnp1XgyNf1HyIilUBe9ycqYj4YfakS0cGFhg~ju4XeuaY11LkO1UnPjCoRArpO6BzuuQTBreLojPkUnyMrJJz2moRRxcl0d2RZvIs6qKVCo2weFy5Zz3EkLaQbItBIA7bd7IZxhc1Fytdw46HQ-ej1CMVA__", name: "고춧가루", tradeType: "교환"),
//            MyTradeModel(image: "https://s3-alpha-sig.figma.com/img/167e/8714/b5c508aca0dfede358b65a69e5dff53d?Expires=1739750400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=JowCyW5lGpxvgTL2cZltgF6Ux1m-9Utk5i-1g4MXuHVHsZW5Ek3qjFmPMNdDVtk~tC3nS5FzNnmvVVIFGA2skPx4L58M8AM3sm6atyOzdUmXZWz75n3Z7SJrmz958n2BHSqzJRsTY~Fi4NbS3LVnNPz06eN6qOCcSxjKoYCIlWJAYxKhOZDHd3dlsZdGTXP0MHZtpd5d35-brKzq9OZIswulLTqZ7pMXYSzdby7uiGXBhSAWqBp6jXzfZ6X8me5XHroaUxSIF2JwdX9SrLKdPWI3nL38r3b1R~tVgiAsnKBhvo-O8xQALrj-a1gEVrCjaS32s9Tks0rTanQQ5oxAcQ__", name: "가래떡", tradeType: "교환")
//        ]
//    }
//}


struct OtherTradeModel {
    let image: String
    let name: String
    let tradeType: String
}

extension OtherTradeModel {
    /// 모든 데이터를 반환
    static func dummy() -> [OtherTradeModel] {
        return [
            OtherTradeModel(image: "자른미역", name: "마른 미역", tradeType: "나눔"),
            OtherTradeModel(image: "품앗이-계란", name: "계란", tradeType: "나눔"),
            OtherTradeModel(image: "중력분", name: "중력분", tradeType: "나눔"),
            OtherTradeModel(image: "두부", name: "두부", tradeType: "교환"),
            OtherTradeModel(image: "땅콩", name: "땅콩", tradeType: "교환"),
            OtherTradeModel(image: "고구마", name: "고구마", tradeType: "교환")
        ]
    }

    /// 나눔, 교환 필터링
    static func getDummyData(for tradeType: String) -> [OtherTradeModel] {
        return dummy().filter { $0.tradeType == tradeType }
    }
}

