//
//  IngredientTypeViewController.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/19/25.
//

import UIKit

class IngredientTypeViewController: UIViewController {
    
    // MARK: - UI Components
    private var ingredientTypeView: IngredientTypeView!
    
    // 카테고리 데이터
    private let categoryData = IngredientCategoryModel.dummy()
    private var minorCategoryList: [MinorCategoryResult] = []
    private var selectedCategoryIndex: IndexPath?
    private var selectedCircleCellIndex: IndexPath?
    private var selectedCategory: String = "all"
    private var selectedMinorCategory: String!
    private var selectedStorageType: String!
    var ingredientId: Int!
    
    // MARK: - Lifecycle
    
    override func loadView() {
        ingredientTypeView = IngredientTypeView()
        self.view = ingredientTypeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        setupDelegates()
        setUpUI()
        getAllMinorCategory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllMinorCategory()
    }

    // MARK: - Setup
    
    private func setUpUI() {
        // 상단바
        let backImage = UIImage(systemName: "chevron.left")
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(didTapBackButton))
        self.navigationItem.leftBarButtonItem = backButton
        backButton.tintColor = .black
        
        let closeImage = UIImage(systemName: "xmark")
        let closeButton = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(didTapCloseButton))
        self.navigationItem.rightBarButtonItem = closeButton
        closeButton.tintColor = .black
        
        self.title = "식재료 추가하기"
    }
    
    private func setupActions() {
        ingredientTypeView.dateButton.addTarget(self, action: #selector(didTapDateButton), for: .touchUpInside)
        ingredientTypeView.allButton.addTarget(self, action: #selector(didTapAllButton), for: .touchUpInside)
        ingredientTypeView.storageTyp1.tag = 1 // 실온
        ingredientTypeView.storageTyp2.tag = 2 // 냉장
        ingredientTypeView.storageTyp3.tag = 3 // 냉동
        
        ingredientTypeView.storageTyp1.addTarget(self, action: #selector(didTapStorageTypeButton(_:)), for: .touchUpInside)
        ingredientTypeView.storageTyp2.addTarget(self, action: #selector(didTapStorageTypeButton(_:)), for: .touchUpInside)
        ingredientTypeView.storageTyp3.addTarget(self, action: #selector(didTapStorageTypeButton(_:)), for: .touchUpInside)
    }
    
    private func setupDelegates() {
        ingredientTypeView.ingredientCategoryCollectionView.delegate = self
        ingredientTypeView.ingredientCategoryCollectionView.dataSource = self
        ingredientTypeView.ingredientsCircleCollectionView.delegate = self
        ingredientTypeView.ingredientsCircleCollectionView.dataSource = self
    }
    
    // MARK: - Actions
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func didTapCloseButton() {
        if let presentingVC = presentingViewController {
            presentingVC.dismiss(animated: true, completion: nil)
        } else if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    @objc private func didTapDateButton() {
        setIngredientType() // 종류 설정 API
        setIngredientStorageType() // 보관 방식 설정 API
        let dateSelectionVC = DateSelectionViewController()
        dateSelectionVC.ingredientId = self.ingredientId
        navigationController?.pushViewController(dateSelectionVC, animated: true)
    }
    
    @objc private func didTapAllButton(_ sender: UIButton) {
        selectedCategoryIndex = nil
        selectMajorCategory()
        for index in 0..<categoryData.count {
            if let cell = ingredientTypeView.ingredientCategoryCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? IngredientCategoryCollectionViewCell {
                cell.backgroundColor = UIColor(hex: 0xF7F7F8, alpha: 1.0)
                cell.icon.tintColor = UIColor.black
                cell.categoryName.textColor = .black
            }
        }
        
        ingredientTypeView.allButton.backgroundColor = UIColor(hex: 0x474747, alpha: 1.0)
        ingredientTypeView.allButton.tintColor = .white
        getAllMinorCategory()
    }
    
    // 보관 방법 설정
    @objc private func didTapStorageTypeButton(_ sender: UIButton) {
        // 선택된 저장 유형을 설정
        switch sender.tag {
        case 1:
            selectedStorageType = "실온"
        case 2:
            selectedStorageType = "냉장"
        case 3:
            selectedStorageType = "냉동"
        default:
            return
        }
        
        // 버튼의 외관 업데이트
        updateStorageTypeButtonAppearance()
        
        // 날짜 버튼 활성화
        ingredientTypeView.dateButton.backgroundColor = UIColor(hex: 0x00C269)
        ingredientTypeView.dateButton.setTitleColor(.white, for: .normal)
        ingredientTypeView.dateButton.isEnabled = true
    }
    
    // 선택된 버튼 색 변경
    private func updateStorageTypeButtonAppearance() {
        let buttons = [ingredientTypeView.storageTyp1, ingredientTypeView.storageTyp2, ingredientTypeView.storageTyp3]
        let storageTypes = ["실온", "냉장", "냉동"]
        let selectedIndex = storageTypes.firstIndex(of: selectedStorageType ?? "") ?? -1
        
        for (index, button) in buttons.enumerated() {
            if index == selectedIndex {
                button.backgroundColor = UIColor(hex: 0x00C269, alpha: 1.0)
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = UIColor(hex: 0xEFEFEF, alpha: 1.0)
                button.setTitleColor(UIColor(hex: 0x9F9F9F, alpha: 1.0), for: .normal)
            }
        }
    }
    
    // 보관 방법 버튼 초기상태로
    private func resetStorageTypeButton() {
        ingredientTypeView.storageTyp1.backgroundColor = UIColor(hex: 0xEFEFEF, alpha: 1.0)
        ingredientTypeView.storageTyp1.setTitleColor(UIColor(hex: 0x9F9F9F, alpha: 1.0), for: .normal)
        ingredientTypeView.storageTyp2.backgroundColor = UIColor(hex: 0xEFEFEF, alpha: 1.0)
        ingredientTypeView.storageTyp2.setTitleColor(UIColor(hex: 0x9F9F9F, alpha: 1.0), for: .normal)
        ingredientTypeView.storageTyp3.backgroundColor = UIColor(hex: 0xEFEFEF, alpha: 1.0)
        ingredientTypeView.storageTyp3.setTitleColor(UIColor(hex: 0x9F9F9F, alpha: 1.0), for: .normal)
    }
    
    // MARK: - API 관련
    
    // 대분류 카테고리로 소분류 카테고리 조회 API
    func getMinorCategory(majorCategory: String) {
        let url = "http://3.35.252.162:8080/ingredient/category/major-to-minor"
        
        // 쿼리 파라미터
        let queryParameters: [String: Any] = [
            "majorCategory": majorCategory
        ]
        
        let queryString = APIClient.shared.createQueryString(from: queryParameters)
        let urlWithQuery = "\(url)?\(queryString)"
        
        // API 요청
        APIClient.shared.request(urlWithQuery, method: .get) { (result: Result<CategoryResponse, Error>) in
            switch result {
            case .success(let response):
                print("\(response.result.majorCategory)로 소분류 카테고리 조회 성공")
                self.minorCategoryList = response.result.minorCategoryList
                self.ingredientTypeView.ingredientsCircleCollectionView.reloadData()
            case .failure(let error):
                print("대분류 카테고리로 소분류 카테고리 조회 네트워킹 오류: \(error)")
            }
        }
    }
    
    // 소분류 카테고리 모두 조회 API
    func getAllMinorCategory() {
        let url = "http://3.35.252.162:8080/ingredient/minorCategory"
        
        // API 요청
        APIClient.shared.request(url, method: .get) { (result: Result<MinorCategoryResponse, Error>) in
            switch result {
            case .success(let response):
                print("!!소분류 카테고리 모두 조회 성공!!")
                self.minorCategoryList = response.result
                self.ingredientTypeView.ingredientsCircleCollectionView.reloadData()
            case .failure(let error):
                print("소분류 카테고리 모두 조회 네트워킹 오류: \(error)")
            }
        }
    }
    
    // 식재료 종류 설정 API
    func setIngredientType() {
        let url = "http://3.35.252.162:8080/ingredient/\(ingredientId!)/category"
        
        let requestBody = SetIngredientTypeRequest(majorCategory: self.selectedCategory, minorCategory: self.selectedMinorCategory)
        
        // API 요청
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(requestBody)
            let jsonParameters = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
            
            APIClient.shared.request(url, method: .post, parameters: jsonParameters) { (result: Result<SetIngredientTypeResponse, Error>) in
                switch result {
                case .success(let response):
                    print("!!식재료 종류 등록 성공!! 식재료 아이디: \(response.result.ingredientId), 식재료 이름: \(response.result.ingredientName) 대분류: \(response.result.majorCategory), 소분류: \(response.result.minorCategory)")
                case .failure(let error):
                    print("식재료 종류 네트워킹 오류: \(error)")
                }
            }
        } catch {
            print("인코딩 오류: \(error)")
        }
    }
    
    // 보관 방식 설정
    func setIngredientStorageType() {
        let url = "http://3.35.252.162:8080/ingredient/\(ingredientId!)/storage-type"
        
        // 쿼리 파라미터
        let requestBody: [String: Any] = [
            "storageType": self.selectedStorageType!
        ]
        
        // API 요청
        APIClient.shared.request(url, method: .post, parameters: requestBody) { (result: Result<SetIngredientStorageTypeResponse, Error>) in
            switch result {
            case .success(let response):
                print("!!식재료 보관 방식 등록 성공!! 보관 방식: \(response.result.storageType)")
            case .failure(let error):
                print("식재료 보관 방식 네트워킹 오류: \(error)")
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension IngredientTypeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == ingredientTypeView.ingredientCategoryCollectionView {
            return categoryData.count // 카테고리 개수
        } else if collectionView == ingredientTypeView.ingredientsCircleCollectionView {
            return minorCategoryList.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == ingredientTypeView.ingredientCategoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: IngredientCategoryCollectionViewCell.identifier,
                for: indexPath
            ) as? IngredientCategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(model: categoryData[indexPath.item])
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
        } else if collectionView == ingredientTypeView.ingredientsCircleCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: IngredientsCircleCollectionViewCell.identifier,
                for: indexPath
            ) as? IngredientsCircleCollectionViewCell else {
                return UICollectionViewCell()
            }
            let category = minorCategoryList[indexPath.item]
            cell.count.isHidden = true
            cell.configureSimple(with: category) // 심플 모델 기반 셀 구성
            
            // 선택된 셀의 색상 설정
            if indexPath == selectedCircleCellIndex {
                cell.circleView.layer.borderWidth = 3 // 테두리 두께 설정
                cell.circleView.layer.borderColor = UIColor(hex: 0x4BD9B3, alpha: 1.0).cgColor
            } else {
                cell.circleView.layer.borderWidth = 0 // 테두리 두께 설정
                cell.circleView.layer.borderColor = UIColor(.clear).cgColor
            }
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegate

extension IngredientTypeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == ingredientTypeView.ingredientCategoryCollectionView {
            selectedCategoryIndex = indexPath
            selectMajorCategory()
            collectionView.reloadData()
            selectedCategory = categoryData[indexPath.item].categoryName
            getMinorCategory(majorCategory: selectedCategory)
        } else if collectionView == ingredientTypeView.ingredientsCircleCollectionView {
            if selectedCircleCellIndex == indexPath {
                // 팝업 뷰를 숨김
                selectMajorCategory()
                collectionView.reloadData() // 셀의 테두리 업데이트
            } else {
                // 다른 셀을 클릭한 경우
                selectedCircleCellIndex = indexPath
                selectedMinorCategory = minorCategoryList[indexPath.item].minorCategory
                selectMinorCategory()
                collectionView.reloadData() // 셀의 테두리 업데이트
            }
        }
    }
    
    func selectMajorCategory() {
        // circleView 초기화
        selectedCircleCellIndex = nil
        ingredientTypeView.ingredientsCircleCollectionView.reloadData()
        selectedMinorCategory = nil
        
        // 보관방법 popUpView 초기화
        ingredientTypeView.popupView.isHidden = true
        resetStorageTypeButton()
        selectedStorageType = nil
        
        // 날짜 설정 버튼 비활성화
        ingredientTypeView.dateButton.backgroundColor = UIColor(hex: 0xF4F4F5)
        ingredientTypeView.dateButton.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
        ingredientTypeView.dateButton.isEnabled = false
        
        // 모두 조회 버튼 초기화
        ingredientTypeView.allButton.backgroundColor = UIColor(hex: 0xF7F7F8, alpha: 1.0)
        ingredientTypeView.allButton.tintColor = .black
    }
    
    func selectMinorCategory() {
        // 보관방법 popUpView 초기화
        resetStorageTypeButton()
        selectedStorageType = nil
        ingredientTypeView.popupView.isHidden = false
        
        // 날짜 설정 버튼 비활성화
        ingredientTypeView.dateButton.backgroundColor = UIColor(hex: 0xF4F4F5)
        ingredientTypeView.dateButton.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
        ingredientTypeView.dateButton.isEnabled = false
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension IngredientTypeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == ingredientTypeView.ingredientsCircleCollectionView {
            let screenWidth = UIScreen.main.bounds.width
            let cellSpacing: CGFloat = 5
            let totalSpacing = cellSpacing * 4
            let cellWidth = (screenWidth - totalSpacing - 32) / 3 // 3열 유지

            return CGSize(width: cellWidth, height: cellWidth + 30) // 기존보다 더 키움
        }
        return CGSize(width: 66, height: 26)
    }
    
}
