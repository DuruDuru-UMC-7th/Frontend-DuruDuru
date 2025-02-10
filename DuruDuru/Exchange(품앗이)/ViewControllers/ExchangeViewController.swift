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
    
    private var tradeItems: [MyTradeModel] = MyTradeModel.dummy()
    private var otherTradeItems: [OtherTradeModel] = OtherTradeModel.dummy()
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
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MyExchangeCollectionViewCell.identifier,
                for: indexPath
            ) as? MyExchangeCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let tradeItem = tradeItems[indexPath.item]
            cell.name.text = tradeItem.name // 이름 설정
            if let imageURL = URL(string: tradeItem.image) {
                cell.titleImage.kf.setImage(with: imageURL)
            }
            cell.isChange.text = tradeItem.tradeType
            
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
        // 이미지 설정: 이미지 이름을 사용하여 UIImage를 생성
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
