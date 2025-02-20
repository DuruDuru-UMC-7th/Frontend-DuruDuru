//
//  HomeViewController.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/8/25.
//

import UIKit
import SnapKit
import Then
import Alamofire

class HomeViewController: UIViewController, UISearchBarDelegate {

    // MARK: - UI Components
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // 홈 화면의 콘텐츠 뷰들 (예시)
    private let myIngredientView = MyIngredientView()
    private let nearbyView = NearbyView()
    private let homeRecipeView = HomeRecipeView()
    
    private var ingredients: [MyIngredient] = []

    // 옵션 뷰 관련 (정렬 드롭다운 등)
    private let darkBackgroundView = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        $0.isHidden = true
    }
    
    private let optionsView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 30
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.isHidden = true
    }
    
    private let filterLabel = UILabel().then {
        $0.text = "정렬"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .black
    }
    
    private let recentFilter = UIButton().then {
        $0.setTitle("최신 등록순", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    private let nearExpiryDateFilter = UIButton().then {
        $0.setTitle("소비기한 임박순", for: .normal)
        $0.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    private let farExpiryFilter = UIButton().then {
        $0.setTitle("소비기한 여유순", for: .normal)
        $0.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    private let menuCloseButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .black
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setUpUIBar()
        setupDelegate()
        setupButtonActions()
        
        fetchAndDisplayIngredients()
        fetchAndDisplayTradeList()
    }
    
    // MARK: - Setup UI
    
    private func setUpUIBar() {
        let logoImage = UIImageView().then {
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(named: "HomeLogo")
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoImage)
        
        let alarmButton = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(alarmButtonTapped))
        alarmButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = alarmButton
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(myIngredientView)
        contentView.addSubview(nearbyView)
        contentView.addSubview(homeRecipeView)
        
        // 옵션 뷰는 scrollView가 아닌 view에 추가
        view.addSubview(darkBackgroundView)
        view.addSubview(optionsView)
        
        optionsView.addSubview(filterLabel)
        optionsView.addSubview(recentFilter)
        optionsView.addSubview(nearExpiryDateFilter)
        optionsView.addSubview(farExpiryFilter)
        optionsView.addSubview(menuCloseButton)
    }
    
    private func setupDelegate() {
        nearbyView.searchBar.delegate = self
    }
    
    private func setupButtonActions() {
        // 옵션 뷰 관련 액션
        nearbyView.recentButton.addTarget(self, action: #selector(didTapRecentButton), for: .touchUpInside)
        menuCloseButton.addTarget(self, action: #selector(didTapMenuCloseButton), for: .touchUpInside)
        recentFilter.addTarget(self, action: #selector(didTapRecentFilter), for: .touchUpInside)
        nearExpiryDateFilter.addTarget(self, action: #selector(didTapNearExpiryFilter), for: .touchUpInside)
        farExpiryFilter.addTarget(self, action: #selector(didTapFarExpiryFilter), for: .touchUpInside)
        
        // 홈 화면 내 버튼 액션 (탭 전환 및 세그먼트 변경)
        myIngredientView.openFridgeButton.addTarget(self, action: #selector(didTapOpenFridgeButton), for: .touchUpInside)
        homeRecipeView.seeMoreButton.addTarget(self, action: #selector(didTapSeeMoreButton), for: .touchUpInside)
        
        // 여기서 moreButton(품앗이 더 보기 버튼) 타겟 추가
        // (만약 nearbyView의 moreButton이 private이라면 접근제한을 해제하거나, 외부에 노출되도록 수정하세요)
        nearbyView.moreButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
    }
    
    // MARK: - Button Actions
    
    @objc private func alarmButtonTapped() {
        // 알람 버튼 동작 구현
    }
    
    @objc private func didTapRecentButton() {
        darkBackgroundView.isHidden = false
        optionsView.isHidden = false
        
        optionsView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(185)
        }
    }
    
    @objc private func didTapMenuCloseButton() {
        darkBackgroundView.isHidden = true
        optionsView.isHidden = true
    }
    
    // 정렬 옵션 버튼 액션 (예시)
    @objc private func didTapRecentFilter() {
        updateSelectedFilter(recentFilter)
    }
    
    @objc private func didTapNearExpiryFilter() {
        updateSelectedFilter(nearExpiryDateFilter)
    }
    
    @objc private func didTapFarExpiryFilter() {
        updateSelectedFilter(farExpiryFilter)
    }
    
    private func updateSelectedFilter(_ selectedButton: UIButton) {
        // 모든 버튼 기본 스타일 복원
        recentFilter.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
        nearExpiryDateFilter.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
        farExpiryFilter.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
        
        // 선택된 버튼 강조
        selectedButton.setTitleColor(.black, for: .normal)
        selectedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        // 옵션 뷰 닫기
        didTapMenuCloseButton()
    }
    
    /// myIngredientView의 openFridgeButton을 누르면 "나의 냉장고" 탭으로 전환 후,
    /// 해당 탭 내 MyFridgeViewController의 세그먼트를 식재료 목록(IngredientsViewController)으로 설정
    @objc private func didTapOpenFridgeButton() {
        if let tabBarController = self.tabBarController,
           let fridgeNav = tabBarController.viewControllers?[1] as? UINavigationController,
           let myFridgeVC = fridgeNav.topViewController as? MyFridgeViewController {
            tabBarController.selectedIndex = 1
            myFridgeVC.selectSegment(.ingredients)
        }
    }
    
    /// homeRecipeView의 seeMoreButton을 누르면 "나의 냉장고" 탭으로 전환 후,
    /// 해당 탭 내 MyFridgeViewController의 세그먼트를 나만의 요리(MyCookingViewController)로 설정
    @objc private func didTapSeeMoreButton() {
        if let tabBarController = self.tabBarController,
           let fridgeNav = tabBarController.viewControllers?[1] as? UINavigationController,
           let myFridgeVC = fridgeNav.topViewController as? MyFridgeViewController {
            tabBarController.selectedIndex = 1
            myFridgeVC.selectSegment(.cooking)
        }
    }
    
    /// moreButton(품앗이 더 보기)를 누르면 "품앗이" 탭으로 전환
    @objc private func didTapMoreButton() {
        if let tabBarController = self.tabBarController {
            tabBarController.selectedIndex = 2
        }
    }
    
    // MARK: -- API
    
    func fetchHomeIngredients(completion: @escaping ([IngredientModel]) -> Void) {
        let baseUrl = "http://3.35.252.162:8080/fridge/recent"

        APIClient.shared.request(baseUrl, method: .get) { (result: Result<IngredientResponse, Error>) in
            switch result {
            case .success(let response):
                print("내 냉장고 식재료 조회 성공: \(response)")
                let ingredients = response.result.ingredients.map { IngredientModel(from: $0) }
                completion(ingredients)
            case .failure(let error):
                print("내 냉장고 식재료 조회 실패: \(error)")
                completion([])
            }
        }
    }

    private func fetchAndDisplayIngredients() {
        fetchHomeIngredients { [weak self] ingredients in
            DispatchQueue.main.async {
                self?.myIngredientView.updateIngredients(ingredients.map { MyIngredientModel(from: $0) })
            }
        }
    }


    // MARK: -- 나와 가까운 품앗이
    
    private func fetchAndDisplayTradeList() {
        fetchHomeTradeList { [weak self] trades in
            DispatchQueue.main.async {
                print("나와 가까운 품앗이 데이터: \(trades)")
                self?.nearbyView.updateTradeList(trades)
            }
        }
    }

    private func fetchHomeTradeList(completion: @escaping ([HomeTradeModel]) -> Void) {
        let baseUrl = "http://3.35.252.162:8080/trade/near/recent"

        APIClient.shared.request(baseUrl, method: .get) { (result: Result<TradeListResponse, Error>) in
            switch result {
            case .success(let response):
                print("홈 - 나와 가까운 품앗이 조회 성공!")
                let trades = response.result.tradeList.map { HomeTradeModel(from: $0) }
                completion(trades)
            case .failure(let error):
                print("홈 - 품앗이 조회 실패: \(error)")
                completion([])
            }
        }
    }
    
    // MARK: -- UISearchBarDelegate Method
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
        }
        
        myIngredientView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top)
            $0.left.right.equalToSuperview()
        }
        
        nearbyView.snp.makeConstraints {
            $0.top.equalTo(myIngredientView.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
        }
        
        homeRecipeView.snp.makeConstraints {
            $0.top.equalTo(nearbyView.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        darkBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        optionsView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(185)
            $0.bottom.equalToSuperview().offset(185) // 초기에는 화면 아래에 숨김
        }
        
        filterLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.leading.equalToSuperview().offset(16)
        }
        
        recentFilter.snp.makeConstraints {
            $0.top.equalTo(filterLabel.snp.bottom).offset(21)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(17)
        }
        
        nearExpiryDateFilter.snp.makeConstraints {
            $0.top.equalTo(recentFilter.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(17)
        }
        
        farExpiryFilter.snp.makeConstraints {
            $0.top.equalTo(nearExpiryDateFilter.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(17)
        }
        
        menuCloseButton.snp.makeConstraints {
            $0.centerY.equalTo(filterLabel)
            $0.trailing.equalToSuperview().offset(-16)
            $0.width.height.equalTo(24)
        }
    }
}
