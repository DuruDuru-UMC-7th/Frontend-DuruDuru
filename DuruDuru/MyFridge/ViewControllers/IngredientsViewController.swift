//
//  IngredientsViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 1/9/25.
//

import UIKit
import AVFoundation

class IngredientsViewController: UIViewController, UISearchBarDelegate {
    
    private var ingredientsView: IngredientsView!
    let categoryData = IngredientCategoryModel.dummy()
//    var allIngredientData = IngredientsDataModel.dummy() // 모든 식재료 데이터
//    var filteredIngredients: [IngredientsModel] = [] // 필터링된 데이터
//    var selectedCategory: IngredientCategoryModel? = nil // 현재 선택된 카테고리
//    var minorCategoryList: [String] = []
    
    private var selectedCategoryIndex: IndexPath?
    
    // API 연결 관련
    var ingredients: [MyIngredient] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsView = IngredientsView(frame: self.view.bounds)
        self.view = ingredientsView
        setupDelegate()
        setupButtonActions()
        getOrderBy(order: "near-expiry")
        
        /// 키보드 동작을 위한 제스쳐
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        selectedCategoryIndex = nil
        for index in 0..<categoryData.count {
            if let cell = ingredientsView.ingredientCategoryCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? IngredientCategoryCollectionViewCell {
                cell.backgroundColor = UIColor(hex: 0xF7F7F8, alpha: 1.0)
                cell.icon.tintColor = UIColor.black
                cell.categoryName.textColor = .black
            }
        }
        
        ingredientsView.allButton.backgroundColor = UIColor(hex: 0x474747, alpha: 1.0)
        ingredientsView.allButton.tintColor = .white
        
        ingredientsView.searchBar.text = ""
        ingredientsView.ingredientCategoryCollectionView.isUserInteractionEnabled = true
        
        updateSelectedOrder(ingredientsView.nearExpiryDateFilter)
        getOrderBy(order: "near-expiry")
    }
    
    private func setupDelegate() {
        ingredientsView.ingredientCategoryCollectionView.dataSource = self
        ingredientsView.ingredientCategoryCollectionView.delegate = self
        ingredientsView.ingredientsCircleCollectionView.dataSource = self
        ingredientsView.ingredientsCircleCollectionView.delegate = self
        ingredientsView.searchBar.delegate = self
    }
    
    private func setupButtonActions() {
        ingredientsView.floatingButton.addTarget(self, action: #selector(togglePopupButtons), for: .touchUpInside)
        ingredientsView.manualButton.addTarget(self, action: #selector(didTapDirectAddButton), for: .touchUpInside)
        ingredientsView.receiptButton.addTarget(self, action: #selector(didTapReceiptAddButton), for: .touchUpInside)
        
        ingredientsView.allButton.addTarget(self, action: #selector(didTapAllButton), for: .touchUpInside)
        ingredientsView.expiryDropdownButton.addTarget(self, action: #selector(didTapFilteringButton), for: .touchUpInside)
        ingredientsView.menuCloseButton.addTarget(self, action: #selector(didTapMenuCloseButton), for: .touchUpInside)
        ingredientsView.recentFilter.addTarget(self, action: #selector(didTapRecent), for: .touchUpInside)
        ingredientsView.nearExpiryDateFilter.addTarget(self, action: #selector(didTapNearExpiryDate), for: .touchUpInside)
        ingredientsView.farExpiryFilter.addTarget(self, action: #selector(didTapFarExpiryDate), for: .touchUpInside)
    }
    
    /// 특정 카테고리에 해당하는 식재료만 필터링
//    private func filterIngredients(by category: IngredientCategoryModel?) {
//        selectedCategory = category
//        
//        
//        if let category = category {
//            filteredIngredients = allIngredientData
//                .first(where: { $0.category.categoryName == category.categoryName })?
//                .ingredients.map { IngredientsModel(name: $0.name, daysRemaining: "D-0") } ?? []
//        } else {
//            // 전체 보기
//            filteredIngredients = allIngredientData.flatMap { $0.ingredients }.map { IngredientsModel(name: $0.name, daysRemaining: "D-0") }
//        }
//        ingredientsView.ingredientsCircleCollectionView.reloadData()
//    }
    
    
    // 대분류에 따른 소분류 조회 api 연결
//    private func fetchIngredientCategories(for majorCategory: String) {
//        print("API 요청: majorCategory = \(majorCategory)") // 디버깅용 출력
//        
//        APIClient.shared.getIngredientCategories(majorCategory: majorCategory) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let categories):
//                    self.minorCategoryList = categories
//                    print("소분류 카테고리: \(categories)") // ✅ 결과 확인
//                    self.ingredientsView.ingredientsCircleCollectionView.reloadData()
//                case .failure(let error):
//                    print("오류 발생: \(error.localizedDescription)")
//                }
//            }
//        }
//    }
    
    /// 식재료 삭제 팝업 (전체 데이터에서도 삭제)
    private func showDeletePopup(for ingredient: MyIngredient, at indexPath: IndexPath) {
        let alertController = UIAlertController(
            title: "이 식재료를 냉장고에서 삭제할까요?",
            message: "삭제한 식재료는 다시 복구할 수 없어요.",
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(title: "아니요", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "네, 삭제할게요", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            
            let ingredientDetailVC = IngredientDetailViewController()
            ingredientDetailVC.ingredient = ingredient
            ingredientDetailVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(ingredientDetailVC, animated: true)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func togglePopupButtons() {
        let isHidden = ingredientsView.receiptButton.isHidden
        ingredientsView.darkBackgroundView.isHidden = !isHidden
        ingredientsView.receiptButton.isHidden = !isHidden
        ingredientsView.manualButton.isHidden = !isHidden
        let newImage = isHidden ? UIImage(named: "close") : UIImage(named: "exchangeFloating")
        ingredientsView.floatingButton.setImage(newImage, for: .normal)
    }
    
    @objc private func didTapDirectAddButton() {
        let addIngredientVC = AddIngredientViewController()
        addIngredientVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(addIngredientVC, animated: true)
    }
    
    @objc private func didTapFilteringButton() {
        ingredientsView.optionsView.isHidden = false
        ingredientsView.darkBackgroundView.isHidden = false
    }
    
    @objc private func didTapMenuCloseButton() {
        ingredientsView.optionsView.isHidden = true
        ingredientsView.darkBackgroundView.isHidden = true
    }
    
    // 최신 등록순 클릭시
    @objc private func didTapRecent() {
        updateSelectedOrder(ingredientsView.recentFilter)
        getOrderBy(order: "all/recent")
    }
    
    // 소비기한 임박순 클릭시
    @objc private func didTapNearExpiryDate() {
        updateSelectedOrder(ingredientsView.nearExpiryDateFilter)
        getOrderBy(order: "near-expiry")
    }
    
    // 소비기한 여유순 클릭시
    @objc private func didTapFarExpiryDate() {
        updateSelectedOrder(ingredientsView.farExpiryFilter)
        getOrderBy(order: "far-expiry")
    }
    
    // 모두 조회 버튼 클릭시 -> 카테고리 색 원래대로, 버튼 색 표시, 검색창 text 없애기, 모두 조회 API 호출
    @objc private func didTapAllButton() {
        selectedCategoryIndex = nil
        for index in 0..<categoryData.count {
            if let cell = ingredientsView.ingredientCategoryCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? IngredientCategoryCollectionViewCell {
                cell.backgroundColor = UIColor(hex: 0xF7F7F8, alpha: 1.0)
                cell.icon.tintColor = UIColor.black
                cell.categoryName.textColor = .black
            }
        }
        
        ingredientsView.allButton.backgroundColor = UIColor(hex: 0x474747, alpha: 1.0)
        ingredientsView.allButton.tintColor = .white
        
        ingredientsView.searchBar.text = ""
        ingredientsView.ingredientCategoryCollectionView.isUserInteractionEnabled = true
        
        updateSelectedOrder(ingredientsView.nearExpiryDateFilter)
        getOrderBy(order: "near-expiry")
    }
    
    private func updateSelectedOrder(_ selectedButton: UIButton) {
        // 모든 버튼의 타이틀을 일반으로 설정
        ingredientsView.recentFilter.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
        ingredientsView.nearExpiryDateFilter.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
        ingredientsView.farExpiryFilter.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)

        // 선택된 버튼의 타이틀을 볼드체로 설정
        selectedButton.setTitleColor(.black, for: .normal)
        selectedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14) // 볼드체로 설정

        // 드롭다운 버튼의 타이틀 업데이트
        ingredientsView.expiryDropdownButton.configuration?.attributedTitle = AttributedString(selectedButton.title(for: .normal) ?? "", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 12)]))

        // 메뉴 숨기기
        ingredientsView.optionsView.isHidden = true
        ingredientsView.darkBackgroundView.isHidden = true
    }
    
    @objc private func didTapReceiptAddButton() {
        print("영수증으로 추가하기 버튼 클릭")
        
        
#if targetEnvironment(simulator)
        fatalError()
#endif
        
        // Privacy - Camera Usage Description
        AVCaptureDevice.requestAccess(for: .video) { [weak self] isAuthorized in
            guard isAuthorized else {
                self?.showAlertGoToSetting()
                return
            }
            
            DispatchQueue.main.async {
                let customCameraVC = CustomCameraViewController()
                customCameraVC.modalPresentationStyle = .fullScreen
                self?.present(customCameraVC, animated: true)
            }
        }
    }
    
    /// 카메라 접근 Alert
    func showAlertGoToSetting() {
        let alertController = UIAlertController(
            title: "현재 카메라 사용에 대한 접근 권한이 없습니다.",
            message: "설정 > {앱 이름}탭에서 접근을 활성화 할 수 있습니다.",
            preferredStyle: .alert
        )
        let cancelAlert = UIAlertAction(
            title: "취소",
            style: .cancel
        ) { _ in
            alertController.dismiss(animated: true, completion: nil)
        }
        let goToSettingAlert = UIAlertAction(
            title: "설정으로 이동하기",
            style: .default) { _ in
                guard
                    let settingURL = URL(string: UIApplication.openSettingsURLString),
                    UIApplication.shared.canOpenURL(settingURL)
                else { return }
                UIApplication.shared.open(settingURL, options: [:])
            }
        [cancelAlert, goToSettingAlert]
            .forEach(alertController.addAction(_:))
        DispatchQueue.main.async {
            self.present(alertController, animated: true) // must be used from main thread only
        }
    }
    
    // 검색어가 있을때 -> 모두조회 버튼 클릭해제, 카테고리 선택 비활성화, 검색어로 식재료 검색
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 검색어 가져오기
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            // 검색어가 없는 경우
            ingredientsView.allButton.backgroundColor = UIColor(hex: 0x474747, alpha: 1.0)
            ingredientsView.allButton.tintColor = .white
            
            updateSelectedOrder(ingredientsView.nearExpiryDateFilter)
            getOrderBy(order: "near-expiry")
            ingredientsView.ingredientCategoryCollectionView.isUserInteractionEnabled = true
            return
        }
        
        ingredientsView.allButton.backgroundColor = UIColor(hex: 0xF7F7F8, alpha: 1.0)
        ingredientsView.allButton.tintColor = .black
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        /// 키보드 숨기기
        ingredientsView.searchBar.resignFirstResponder()
        
        // 검색어 가져오기
        let searchText = searchBar.text
        
        // 검색 동작
        getByIngredientName(ingredientName: searchText!)
        ingredientsView.ingredientsCircleCollectionView.reloadData()
        ingredientsView.ingredientCategoryCollectionView.isUserInteractionEnabled = false
    }
    
    // 키보드 숨기기
    @objc private func dismissKeyboard() {
        // 키보드가 나타나 있을 때만 숨기기
        if ingredientsView.searchBar.isFirstResponder {
            ingredientsView.searchBar.resignFirstResponder()
        }
    }
    
    // MARK: - API 관련
    
    // 식재료 조회 정렬
    func getOrderBy(order: String) {
        let url = "http://3.35.252.162:8080/fridge/2/\(order)"
        
        // API 요청
        APIClient.shared.request(url, method: .get) { (result: Result<IngredientResponse, Error>) in
            switch result {
            case .success(let response):
                print("!!식재료 조회 정렬 성공!!")
                self.ingredients = response.result.ingredients
                self.ingredientsView.ingredientsCircleCollectionView.reloadData()
            case .failure(let error):
                print("네트워킹 오류: \(error)")
            }
        }
    }
    
    // 식재료 이름으로 검색 조회
    func getByIngredientName(ingredientName: String) {
        let url = "http://3.35.252.162:8080/ingredient/search/name"
        
        // 쿼리 파라미터
        let queryParameters: [String: Any] = [
            "memberId": 2, // 임시로 넣은 memberId
            "search": ingredientName,
        ]
        
        let queryString = APIClient.shared.createQueryString(from: queryParameters)
        let urlWithQuery = "\(url)?\(queryString)"
        
        // API 요청
        APIClient.shared.request(urlWithQuery, method: .get) { (result: Result<IngredientResponse, Error>) in
            switch result {
            case .success(let response):
                print("!!식재료 이름으로 검색 조회 성공!!")
                self.ingredients = response.result.ingredients
                self.ingredientsView.ingredientsCircleCollectionView.reloadData()
            case .failure(let error):
                print("네트워킹 오류: \(error)")
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension IngredientsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == ingredientsView.ingredientCategoryCollectionView {
            return categoryData.count
        } else if collectionView == ingredientsView.ingredientsCircleCollectionView {
            return ingredients.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == ingredientsView.ingredientCategoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: IngredientCategoryCollectionViewCell.identifier,
                for: indexPath
            ) as? IngredientCategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(model: categoryData[indexPath.row])
            
            // 선택된 셀의 색상 설정
            if indexPath == selectedCategoryIndex {
                cell.backgroundColor = UIColor(hex: 0x474747, alpha: 1.0)
                cell.icon.tintColor = .white
                cell.categoryName.textColor = .white
            } else {
                cell.backgroundColor = UIColor(hex: 0xF7F7F8, alpha: 1.0)
                cell.icon.tintColor = .black
                cell.categoryName.textColor = .black
            }
            
            return cell
        } else if collectionView == ingredientsView.ingredientsCircleCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: IngredientsCircleCollectionViewCell.identifier,
                for: indexPath
            ) as? IngredientsCircleCollectionViewCell else {
                return UICollectionViewCell()
            }
            let ingredient = ingredients[indexPath.item]
            cell.configure(with: ingredient) // 셀에 데이터 설정
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegate
extension IngredientsViewController: UICollectionViewDelegate {
    /// 대분류에 따른 소분류 조회 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == ingredientsView.ingredientCategoryCollectionView {
            selectedCategoryIndex = indexPath
            ingredientsView.allButton.backgroundColor = UIColor(hex: 0xF7F7F8, alpha: 1.0)
            ingredientsView.allButton.tintColor = .black
            collectionView.reloadData()
            
            let selectedCategory = categoryData[indexPath.item].categoryName // 선택한 카테고리명 가져오기
            print("사용자가 선택한 카테고리: \(selectedCategory)") // 디버깅 출력
            
            // 테고리 선택 시 API 요청 실행
            //            fetchIngredientCategories(for: selectedCategory)
        } else if collectionView == ingredientsView.ingredientsCircleCollectionView {
            let selectedIngredient = ingredients[indexPath.item]
            showDeletePopup(for: selectedIngredient, at: indexPath) // 셀 선택 시 팝업 호출
        }
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension IngredientsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == ingredientsView.ingredientsCircleCollectionView {
            let screenWidth = UIScreen.main.bounds.width
            let cellSpacing: CGFloat = 5
            let totalSpacing = cellSpacing * 4
            let cellWidth = (screenWidth - totalSpacing - 32) / 3 // 3열 유지

            return CGSize(width: cellWidth, height: cellWidth + 30) // 기존보다 더 키움
        }
        return CGSize(width: 66, height: 26)
    }
    
}
