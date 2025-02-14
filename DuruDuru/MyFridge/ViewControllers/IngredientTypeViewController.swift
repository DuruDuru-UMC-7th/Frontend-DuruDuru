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
    private var selectedCategory: String = "all"
    var ingredientId: Int!
    var setIngredientType: SetIngredientTypeRequest!
    private var selectedCircleCellIndex: IndexPath?
    
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
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
    }
    
    private func setupDelegates() {
        ingredientTypeView.ingredientCategoryCollectionView.delegate = self
        ingredientTypeView.ingredientCategoryCollectionView.dataSource = self
        ingredientTypeView.ingredientsCircleCollectionView.delegate = self
        ingredientTypeView.ingredientsCircleCollectionView.dataSource = self
        ingredientTypeView.searchBar.delegate = self
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
        setIngredientType(ingredientId: self.ingredientId)
        setIngredientStorageType(ingredientId: self.ingredientId, storageType: "냉장")
        let dateSelectionVC = DateSelectionViewController()
        navigationController?.pushViewController(dateSelectionVC, animated: true)
    }
    
    @objc private func didTapAllButton(_ sender: UIButton) {
        selectedCategoryIndex = nil
        for index in 0..<categoryData.count {
            if let cell = ingredientTypeView.ingredientCategoryCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? IngredientCategoryCollectionViewCell {
                cell.backgroundColor = UIColor(hex: 0xF7F7F8, alpha: 1.0)
                cell.icon.tintColor = UIColor.black
                cell.categoryName.textColor = .black
            }
        }
        
        ingredientTypeView.allButton.backgroundColor = UIColor(hex: 0x474747, alpha: 1.0)
        ingredientTypeView.allButton.tintColor = .white
        ingredientTypeView.searchBar.text = ""
        getAllMinorCategory()
    }
    
    /// 키보드 숨기기
    @objc private func dismissKeyboard() {
        // 키보드가 나타나 있을 때만 숨기기
        if ingredientTypeView.searchBar.isFirstResponder {
            ingredientTypeView.searchBar.resignFirstResponder()
        }
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
                print(response)
                self.minorCategoryList = response.result.minorCategoryList
                self.ingredientTypeView.ingredientsCircleCollectionView.reloadData()
            case .failure(let error):
                print("네트워킹 오류: \(error)")
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
                print("네트워킹 오류: \(error)")
            }
        }
    }
    
    // 식재료 종류 설정 API
    func setIngredientType(ingredientId: Int) {
        let url = "http://3.35.252.162:8080/ingredient/\(ingredientId)/category"
        
        let requestBody = SetIngredientTypeRequest(majorCategory: "채소", minorCategory: "뿌리채소")
        
        // API 요청
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(requestBody)
            let jsonParameters = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
            
            APIClient.shared.request(url, method: .post, parameters: jsonParameters) { (result: Result<SetIngredientTypeResponse, Error>) in
                switch result {
                case .success(let response):
                    print("!!식재료 종류 등록 성공!!")
                    print(response)
                case .failure(let error):
                    print("네트워킹 오류: \(error)")
                }
            }
        } catch {
            print("인코딩 오류: \(error)")
        }
    }
    
    // 보관 방식 설정
    func setIngredientStorageType(ingredientId: Int, storageType: String) {
        let url = "http://3.35.252.162:8080/ingredient/\(ingredientId)/storage-type"
        
        // 쿼리 파라미터
        let requestBody: [String: Any] = [
            "storageType": storageType
        ]
        
        // API 요청
        APIClient.shared.request(url, method: .post, parameters: requestBody) { (result: Result<SetIngredientStorageTypeResponse, Error>) in
            switch result {
            case .success(let response):
                print("!!식재료 보관 방식 등록 성공!!")
                print(response)
            case .failure(let error):
                print("네트워킹 오류: \(error)")
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
            ingredientTypeView.allButton.backgroundColor = UIColor(hex: 0xF7F7F8, alpha: 1.0)
            ingredientTypeView.allButton.tintColor = .black
            collectionView.reloadData()
            ingredientTypeView.searchBar.text = ""
            
            selectedCategory = categoryData[indexPath.item].categoryName
            getMinorCategory(majorCategory: selectedCategory)
        } else if collectionView == ingredientTypeView.ingredientsCircleCollectionView {
            // 기존 선택된 셀에 대한 테두리 초기화
            if let previousIndex = selectedCircleCellIndex {
                if let previousCell = collectionView.cellForItem(at: previousIndex) as? IngredientsCircleCollectionViewCell {
                    previousCell.circleView.layer.borderWidth = 0
                }
            }
            
            // 이미 선택된 셀을 다시 클릭
            if selectedCircleCellIndex == indexPath {
                ingredientTypeView.popupView.isHidden = true
                selectedCircleCellIndex = nil // 선택 해제
            } else { // 다른 셀을 클릭하면 팝업 뷰를 보여줌
                ingredientTypeView.popupView.isHidden = false
                selectedCircleCellIndex = indexPath // 새로 선택된 셀 저장
                
                // 선택된 셀에 테두리 설정
                if let selectedCell = collectionView.cellForItem(at: indexPath) as? IngredientsCircleCollectionViewCell {
                    selectedCell.circleView.layer.borderWidth = 3 // 테두리 두께 설정
                    selectedCell.circleView.layer.borderColor = UIColor(hex: 0x4BD9B3, alpha: 1.0).cgColor
                }
            }
        }
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

extension IngredientTypeViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        /// 키보드 숨기기
        ingredientTypeView.searchBar.resignFirstResponder()
        
        /// 검색 동작
    }
}
