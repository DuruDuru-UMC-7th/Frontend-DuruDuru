//
//  ExchangeRegisterViewController.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/28/25.
//

import UIKit

class ExchangeRegisterViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: - Properties
    private var exchangeRegisterView: ExchangeRegisterView!
    private var selectedIngredient: MyIngredient?
    var ingredients: [MyIngredient] = []
    var searchText: String?
    private var selectedIngredientIndex: IndexPath?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exchangeRegisterView = ExchangeRegisterView(frame: self.view.bounds)
        self.view = exchangeRegisterView
        navigationItem.hidesBackButton = true
        hidesBottomBarWhenPushed = true
        setupActions()
        setupCollectionView()
        setUpUI()
        
        exchangeRegisterView.searchBar.delegate = self
        
        /// 키보드 동작을 위한 제스쳐
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getIngredients()
    }
    
    // MARK: - Setup
    
    private func setUpUI() {
        // 상단바
        let closeImage = UIImage(systemName: "xmark")
        let closeButton = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(didTapCloseButton))
        self.navigationItem.rightBarButtonItem = closeButton
        closeButton.tintColor = .black
        
        self.title = "품앗이 등록하기"
    }
    
    private func setupActions() {
        exchangeRegisterView.nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }
    
    private func setupCollectionView() {
        exchangeRegisterView.ingredientsCircleCollectionView.delegate = self
        exchangeRegisterView.ingredientsCircleCollectionView.dataSource = self
    }
    
    @objc private func didTapCloseButton() {
        if let presentingVC = presentingViewController {
            presentingVC.dismiss(animated: true, completion: nil)
        } else if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    @objc private func didTapNextButton() {
        let detailVC = ExchangeRegisterDetailViewController()
        detailVC.ingredient = self.selectedIngredient
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        /// 키보드 숨기기
        exchangeRegisterView.searchBar.resignFirstResponder()
        
        // 검색어 가져오기
        searchText = searchBar.text
        
        // 검색 동작
        getByIngredientName(ingredientName: searchText!)
        exchangeRegisterView.ingredientsCircleCollectionView.reloadData()
    }
    
    // 키보드 숨기기
    @objc private func dismissKeyboard() {
        // 키보드가 나타나 있을 때만 숨기기
        if exchangeRegisterView.searchBar.isFirstResponder {
            exchangeRegisterView.searchBar.resignFirstResponder()
            if exchangeRegisterView.searchBar.text == "" {
                getIngredients()
            }
        }
    }
    
    // MARK: - API 관련
    
    // 식재료 조회 정렬
    func getIngredients() {
        let url = "http://3.35.252.162:8080/fridge/near-expiry"
        
        // API 요청
        APIClient.shared.request(url, method: .get) { (result: Result<IngredientResponse, Error>) in
            switch result {
            case .success(let response):
                print("!!식재료 조회 정렬 성공!!")
                self.ingredients = response.result.ingredients
                self.exchangeRegisterView.ingredientsCircleCollectionView.reloadData()
            case .failure(let error):
                print("네트워킹 오류: \(error)")
            }
        }
    }
    
    // 식재료 이름으로 검색 조회
    func getByIngredientName(ingredientName: String) {
        let url = "http://3.35.252.162:8080/fridge/name/near-expiry"
        
        // 쿼리 파라미터
        let queryParameters: [String: Any] = [
            "search": ingredientName,
        ]
        
        let queryString = APIClient.shared.createQueryString(from: queryParameters)
        let urlWithQuery = "\(url)?\(queryString)"
        
        // API 요청
        APIClient.shared.request(urlWithQuery, method: .get) { (result: Result<IngredientResponse, Error>) in
            switch result {
            case .success(let response):
                self.ingredients = response.result.ingredients
                self.exchangeRegisterView.ingredientsCircleCollectionView.reloadData()
            case .failure(let error):
                print("네트워킹 오류: \(error)")
            }
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ExchangeRegisterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: IngredientsCircleCollectionViewCell.identifier,
            for: indexPath
        ) as? IngredientsCircleCollectionViewCell else {
            return UICollectionViewCell()
        }
        let ingredient = ingredients[indexPath.item]
        cell.configure(with: ingredient) // 셀에 데이터 설정
        
        if indexPath == selectedIngredientIndex {
            cell.circleView.layer.borderWidth = 3 // 테두리 두께 설정
            cell.circleView.layer.borderColor = UIColor(hex: 0x4BD9B3, alpha: 1.0).cgColor
        } else {
            cell.circleView.layer.borderWidth = 0 // 테두리 두께 설정
            cell.circleView.layer.borderColor = UIColor(.clear).cgColor
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == exchangeRegisterView.ingredientsCircleCollectionView {
            let screenWidth = UIScreen.main.bounds.width
            let cellSpacing: CGFloat = 5
            let totalSpacing = cellSpacing * 4
            let cellWidth = (screenWidth - totalSpacing - 32) / 3 // 3열 유지
            
            return CGSize(width: cellWidth, height: cellWidth + 30) // 기존보다 더 키움
        }
        return CGSize(width: 66, height: 26)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIngredientIndex == indexPath {
            selectedIngredientIndex = nil
            collectionView.reloadData()
        } else {
            selectedIngredientIndex = indexPath
            collectionView.reloadData()
            self.selectedIngredient = ingredients[indexPath.item]
        }
        
        let isSelected = self.selectedIngredientIndex != nil
        exchangeRegisterView.updateNextButtonState(isEnabled: isSelected)
    }
}
