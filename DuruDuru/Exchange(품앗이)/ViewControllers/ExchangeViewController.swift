//
//  ExchangeViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 1/23/25.
//

import UIKit

class ExchangeViewController: UIViewController {
    
    // MARK: - Properties
    
    private var exchangeView: ExchangeView!
    private var isFloatingExpanded = false
    var isTownRegistered = false // 동네 등록 여부 변수
    private var tradeItems: [MyTradeModel] = []
    
    //private var tradeItems: [MyTradeModel] = MyTradeModel.dummy()
    private var otherTradeItems: [OtherTradeModel] = OtherTradeModel.dummy()
    private var isShowingShareTrades = true
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exchangeView = ExchangeView(frame: self.view.bounds)
        self.view = exchangeView
        setUpUIBar()
        setupDelegate()
        setupActions()
        exchangeView.updateTableViewHeight(dataCnt: OtherTradeModel.dummy().count)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // API 요청
        getTown()
        getActiveTradeList()
        getNearbyTradeList(tradeType: "SHARE")
    }
    
    // MARK: - Functions
    
    private func setupDelegate(){
        exchangeView.myExchangeCollectionView.dataSource = self
        exchangeView.myExchangeCollectionView.delegate = self
        exchangeView.exchangeTableView.delegate = self
        exchangeView.exchangeTableView.dataSource = self
        exchangeView.locationButton.addTarget(self, action: #selector(didTapLocationButton), for: .touchUpInside)
    }
    
    private func setupActions() {
        exchangeView.floatingButton.addTarget(self, action: #selector(didTapFloatingButton), for: .touchUpInside)
        exchangeView.registerPoomButton.addTarget(self, action: #selector(didTapRegisterPoom), for: .touchUpInside)
        exchangeView.registerTogetherButton.addTarget(self, action: #selector(didTapRegisterTogether), for: .touchUpInside)
        exchangeView.shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        exchangeView.exchangeButton.addTarget(self, action: #selector(didTapExchangeButton), for: .touchUpInside)
    }
    
    func setUpUIBar() {
        let townButton = UIBarButtonItem(customView: exchangeView.locationButton)
        let downButton = UIBarButtonItem(customView: exchangeView.downImage)
        
        // UIStackView를 사용하여 간격 조정
        let stackView = UIStackView(arrangedSubviews: [townButton.customView!, downButton.customView!])
        stackView.axis = .horizontal
        stackView.spacing = 0
        
        // 상단 바에 스택 뷰 추가
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: stackView)
    }
    
    /// 플로팅 버튼 클릭 시 동작
    @objc private func didTapFloatingButton() {
        isFloatingExpanded.toggle()
        
        UIView.animate(withDuration: 0.3) {
            self.exchangeView.updateFloatingButtons(isExpanded: self.isFloatingExpanded)
        }
    }
    
    /// "품앗이 등록하기" 버튼 클릭 시 동작
    @objc private func didTapRegisterPoom() {
        let registerVC = ExchangeRegisterViewController()
        registerVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    /// "함께 먹자 등록하기" 버튼 클릭 시 동작
    @objc private func didTapRegisterTogether() {
        let togetherVC = ExchangeRegisterDetailViewController()
        navigationController?.pushViewController(togetherVC, animated: true)
    }
    
    @objc private func didTapLocationButton() {
        let settingTownVC = SettingTownViewController()
        settingTownVC.hidesBottomBarWhenPushed = true
        settingTownVC.isTownRegistered = self.isTownRegistered
        navigationController?.pushViewController(settingTownVC, animated: true)
    }
    
    @objc private func didTapShareButton() {
        isShowingShareTrades = true
        updateTradeList()
        getNearbyTradeList(tradeType: "SHARE")
    }

    @objc private func didTapExchangeButton() {
        isShowingShareTrades = false
        updateTradeList()
        getNearbyTradeList(tradeType: "EXCHANGE")
    }

    
    /// 나눔/교환 버튼 클릭 시 데이터 업데이트
    private func updateTradeList() {
        if isShowingShareTrades {
            exchangeView.shareButton.backgroundColor = UIColor(hex: 0x00C269)
            exchangeView.shareButton.setTitleColor(.white, for: .normal)
            exchangeView.shareButton.layer.borderColor = UIColor(hex: 0x00C269).cgColor

            exchangeView.exchangeButton.backgroundColor = .white
            exchangeView.exchangeButton.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.16), for: .normal)
            exchangeView.exchangeButton.layer.borderColor = UIColor(hex: 0x37383C, alpha: 0.16).cgColor

            otherTradeItems = OtherTradeModel.getDummyData(for: "나눔")
        } else {
            exchangeView.exchangeButton.backgroundColor = UIColor(hex: 0x00C269)
            exchangeView.exchangeButton.setTitleColor(.white, for: .normal)
            exchangeView.exchangeButton.layer.borderColor = UIColor(hex: 0x00C269).cgColor

            exchangeView.shareButton.backgroundColor = .white
            exchangeView.shareButton.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.16), for: .normal)
            exchangeView.shareButton.layer.borderColor = UIColor(hex: 0x37383C, alpha: 0.16).cgColor

            otherTradeItems = OtherTradeModel.getDummyData(for: "교환")
        }
        exchangeView.exchangeTableView.reloadData()
    }

}




// MARK: - UICollectionView

extension ExchangeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == exchangeView.myExchangeCollectionView {
            return tradeItems.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == exchangeView.myExchangeCollectionView {
            guard indexPath.item < tradeItems.count else { return UICollectionViewCell() }
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MyExchangeCollectionViewCell.identifier,
                for: indexPath
            ) as? MyExchangeCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let tradeItem = tradeItems[indexPath.item]
            cell.name.text = tradeItem.title
            cell.isChange.text = tradeItem.tradeType
            
            // 이미지가 nil이면 기본 이미지 사용
            if let imageUrlString = tradeItem.image, let imageURL = URL(string: imageUrlString) {
                cell.titleImage.kf.setImage(with: imageURL) // Kingfisher로 로드
            } else {
                cell.titleImage.image = UIImage(named: "defaultImage") // 기본 이미지 설정
            }
            
            return cell
        }
        return UICollectionViewCell()
    }

    
    
    
    // MARK: - API 관련
    
    // 동네 조회 API
    func getTown() {
        let url = "http://3.35.252.162:8080/town/"
        
        /// 쿼리 파라미터
        let queryParameters: [String: Any] = [
            "memberId": 2, // 임시로 넣은 memberId
        ]
        
        let queryString = APIClient.shared.createQueryString(from: queryParameters)
        let urlWithQuery = "\(url)?\(queryString)"
        
        /// API 요청
        APIClient.shared.request(urlWithQuery, method: .get) { [self] (result: Result<TownResponse, Error>) in
            switch result {
            case .success(let response):
                print("!!동네 조회 성공!!")
                print(response)
                isTownRegistered = true
                exchangeView.locationButton.setTitle(response.result!.eupmyeondong, for: .normal)
            case .failure(let error):
                print("네트워킹 오류: \(error)")
            }
        }
    }
    
    func getActiveTradeList() {
        let url = "http://3.35.252.162:8080/trade/my/active"
        
        let queryParameters: [String: Any] = [
            "memberId": 1 // 임시로 넣은 memberId
        ]
        
        let queryString = APIClient.shared.createQueryString(from: queryParameters)
        let urlWithQuery = "\(url)?\(queryString)"
        
        APIClient.shared.request(urlWithQuery, method: .get) { [weak self] (result: Result<ActiveTradeResponse, Error>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                print("API 응답 데이터: \(response)")
                
                let trades = response.result?.tradeList ?? []
                if trades.isEmpty {
                    print("품앗이 게시글이 없습니다.")
                }
                
                self.tradeItems = trades.map { MyTradeModel(from: $0) }
                
                DispatchQueue.main.async {
                    self.exchangeView.myExchangeCollectionView.reloadData()
                }
                
            case .failure(let error):
                print("네트워킹 오류: \(error)")
            }
        }
    }
    
    private func getNearbyTradeList(tradeType: String) {
        let url = "http://3.35.252.162:8080/trade/near/\(tradeType)"

        let queryParameters: [String: Any] = [
            "type": tradeType
        ]

        let queryString = APIClient.shared.createQueryString(from: queryParameters)
        let urlWithQuery = "\(url)?\(queryString)"

        APIClient.shared.request(urlWithQuery, method: .get) { [weak self] (result: Result<NearbyTradeResponse, Error>) in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                print("API 응답 데이터: \(response)")

                let trades = response.result?.trades ?? []
                
                if trades.isEmpty {
                    print("품앗이 게시글이 없습니다. → 더미 데이터 사용")
                    
                    // 더미 데이터를 변환
                    let dummyTradeItems = OtherTradeModel.getDummyData(for: tradeType == "SHARE" ? "나눔" : "교환").map {
                        NearbyTradeItem(
                            tradeId: Int.random(in: 1000...9999),
                            memberId: Int.random(in: 1...100),
                            ingredientId: Int.random(in: 1...50),
                            expiryDate: nil,
                            title: $0.name,
                            eupmyeondong: "공릉동",
                            status: "ACTIVE",
                            tradeType: tradeType,
                            likeCount: Int.random(in: 0...10),
                            createdAt: "2025-02-15T15:00:00",
                            updatedAt: "2025-02-15T15:00:00",
                            thumbnailImgURl: $0.image
                        )
                    }
                    
                    let dummyResponse = NearbyTradeResponse(
                        isSuccess: true,
                        code: "TRADE_3005",
                        message: "품앗이 게시글 리스트를 성공적으로 조회하였습니다.",
                        result: NearbyTradeResult(trades: dummyTradeItems)
                    )

                    self.otherTradeItems = dummyTradeItems.map { OtherTradeModel(from: $0) }
                    
                    print(" 더미 데이터를 API 응답 형식으로 변환 완료: \(dummyResponse)")

                } else {
                    self.otherTradeItems = trades.map { OtherTradeModel(from: $0) }
                }

                DispatchQueue.main.async {
                    self.exchangeView.exchangeTableView.reloadData()
                }

            case .failure(let error):
                print("네트워킹 오류: \(error)")
                //print("네트워크 오류 발생 → 더미 데이터 사용")

                let dummyTradeItems = OtherTradeModel.getDummyData(for: tradeType == "SHARE" ? "나눔" : "교환").map {
                    NearbyTradeItem(
                        tradeId: Int.random(in: 1000...9999),
                        memberId: Int.random(in: 1...100),
                        ingredientId: Int.random(in: 1...50),
                        expiryDate: nil,
                        title: $0.name,
                        eupmyeondong: "공릉동",
                        status: "ACTIVE",
                        tradeType: tradeType,
                        likeCount: Int.random(in: 0...10),
                        createdAt: "2025-02-15T15:00:00",
                        updatedAt: "2025-02-15T15:00:00",
                        thumbnailImgURl: $0.image
                    )
                }
                
                let dummyResponse = NearbyTradeResponse(
                    isSuccess: true,
                    code: "TRADE_3005",
                    message: "품앗이 게시글 리스트를 성공적으로 조회하였습니다.",
                    result: NearbyTradeResult(trades: dummyTradeItems)
                )

                self.otherTradeItems = dummyTradeItems.map { OtherTradeModel(from: $0) }

                //print("네트워크 오류 발생 → 더미 데이터를 API 응답 형식으로 변환 완료: \(dummyResponse)")

                DispatchQueue.main.async {
                    self.exchangeView.exchangeTableView.reloadData()
                }
            }
        }
    }



}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ExchangeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return otherTradeItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeTableViewCell.identifier, for: indexPath) as? ExchangeTableViewCell else {
            return UITableViewCell()
        }
        let tradeItem = otherTradeItems[indexPath.row]
        cell.name.text = tradeItem.name // 이름 설정
        cell.titleImage.image = UIImage(named: tradeItem.image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let exchangeDetailVc = ExchangeDetailViewController()
        exchangeDetailVc.tradeId = 2 /// 임시로 2로 지정
        exchangeDetailVc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(exchangeDetailVc, animated: true)
    }
}
