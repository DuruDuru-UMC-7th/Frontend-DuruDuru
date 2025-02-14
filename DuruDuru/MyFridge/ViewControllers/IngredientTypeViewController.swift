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

    private func showBottomPopup() {
        // 팝업 컨테이너 뷰
        let popupView = UIView()
        popupView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        popupView.layer.cornerRadius = 16
        popupView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        popupView.clipsToBounds = true
        popupView.tag = 999 // 중복 방지를 위한 태그 설정

        // 팝업 높이 설정
        let popupHeight: CGFloat = 150

        // 팝업 제목
        let titleLabel = UILabel()
        titleLabel.text = "이렇게 보관할 거예요!"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center

        // 팝업 메시지
        let messageLabel = UILabel()
        messageLabel.text = "보관 방식에 따라 적용되는 소비기한이 달라져요"
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.textAlignment = .center
        messageLabel.textColor = .darkGray

        // 버튼들 (실온, 냉장, 냉동)
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16


        let roomTempButton = UIButton(type: .system)
        configureButton(roomTempButton, title: "실온")
        roomTempButton.addTarget(self, action: #selector(didSelectRoomTemp), for: .touchUpInside)

        let fridgeButton = UIButton(type: .system)
        configureButton(fridgeButton, title: "냉장")
        fridgeButton.addTarget(self, action: #selector(didSelectFridge), for: .touchUpInside)

        let freezerButton = UIButton(type: .system)
        configureButton(freezerButton, title: "냉동")
        freezerButton.addTarget(self, action: #selector(didSelectFreezer), for: .touchUpInside)


        stackView.addArrangedSubview(roomTempButton)
        stackView.addArrangedSubview(fridgeButton)
        stackView.addArrangedSubview(freezerButton)

        // 팝업 레이아웃 설정
        popupView.addSubview(titleLabel)
        popupView.addSubview(messageLabel)
        popupView.addSubview(stackView)

        view.addSubview(popupView)

        popupView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            popupView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
            popupView.heightAnchor.constraint(equalToConstant: popupHeight),

            titleLabel.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),

            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),

            stackView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])

        // "날짜 설정하러 가기" 버튼 숨기기
        ingredientTypeView.dateButton.isHidden = true

        // "다음 단계" 버튼 추가
        let nextButton = UIButton(type: .system)
        nextButton.setTitle("다음 단계", for: .normal)
        nextButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.backgroundColor = .systemGreen
        nextButton.layer.cornerRadius = 8
        nextButton.tag = 998 // 중복 방지를 위한 태그 설정
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)

        view.addSubview(nextButton)

        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
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
        setIngredientStorageType(ingredientId: self.ingredientId, storageType: <#T##String#>)
        let dateSelectionVC = DateSelectionViewController()
        navigationController?.pushViewController(dateSelectionVC, animated: true)
    }
    
    private func configureButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        button.setTitleColor(.gray, for: .normal) 
        button.layer.cornerRadius = 8
    }
    
    @objc private func didSelectRoomTemp(_ sender: UIButton) {
        resetButtonStates()
        updateButtonState(sender, isSelected: true)
    }

    @objc private func didSelectFridge(_ sender: UIButton) {
        resetButtonStates()
        updateButtonState(sender, isSelected: true)
    }

    @objc private func didSelectFreezer(_ sender: UIButton) {
        resetButtonStates()
        updateButtonState(sender, isSelected: true)
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

    private func resetButtonStates() {
        for subview in view.subviews {
            if let stackView = subview.subviews.first(where: { $0 is UIStackView }) as? UIStackView {
                for button in stackView.arrangedSubviews where button is UIButton {
                    updateButtonState(button as! UIButton, isSelected: false)
                }
            }
        }
    }

    private func updateButtonState(_ button: UIButton, isSelected: Bool) {
        if isSelected {
            button.backgroundColor = .systemGreen // 선택 시 초록색
            button.setTitleColor(.white, for: .normal) // 글씨 흰색
        } else {
            button.backgroundColor = .lightGray // 기본 회색
            button.setTitleColor(.darkGray, for: .normal) // 글씨 진한 회색
        }
    }
    
    @objc private func didTapNextButton() {
        print("다음 단계 버튼 클릭")
        dismissBottomPopup()
    }
    
    private func dismissBottomPopup() {
        if let popupView = view.subviews.first(where: { $0.tag == 999 }) {
            popupView.removeFromSuperview()
        }
        if let nextButton = view.subviews.first(where: { $0.tag == 998 }) {
            nextButton.removeFromSuperview()
        }
        // "날짜 설정하러 가기" 버튼 다시 보이기
        ingredientTypeView.dateButton.isHidden = false
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
            let selectedMinorCategory = minorCategoryList[indexPath.item]
            
            // 팝업 띄우기
            showBottomPopup()
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
