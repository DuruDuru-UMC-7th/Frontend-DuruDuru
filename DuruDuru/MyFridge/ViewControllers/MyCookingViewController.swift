//
//  MyCookingViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 1/9/25.
//

import UIKit

class MyCookingViewController: UIViewController, UICollectionViewDelegate, UISearchBarDelegate {
    
    
    // MARK: - Properties
    
    private var myCookingView: MyCookingView!
    let categoryData = IngredientCategoryModel.dummy()
    private var selectedCategoryIndex: IndexPath?
    var ingredients: [MyIngredient] = []
    var allRecipeData: [[Recipe]] = [[]]
    private var recipeLoadOperations = [IndexPath: Operation]()
    private let imageLoadQueue = OperationQueue()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCookingView = MyCookingView(frame: self.view.bounds)
        self.view = myCookingView
        setupDelegate()
        setupButtonActions()
        setupGestures()
        setupQueue()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadAllData()
        self.myCookingView.ingredientsTableView.reloadData()
        
        selectedCategoryIndex = nil
        myCookingView.allButton.backgroundColor = UIColor(hex: 0x474747, alpha: 1.0)
        myCookingView.allButton.tintColor = .white
        myCookingView.searchBar.text = ""
        myCookingView.ingredientCategoryCollectionView.isUserInteractionEnabled = true
    }
    
    private func setupDelegate(){
        myCookingView.ingredientCategoryCollectionView.dataSource = self
        myCookingView.ingredientCategoryCollectionView.delegate = self
        myCookingView.ingredientsTableView.dataSource = self
        myCookingView.searchBar.delegate = self
    }
    
    private func setupQueue() {
        imageLoadQueue.maxConcurrentOperationCount = 2
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupButtonActions() {
        myCookingView.allButton.addTarget(self, action: #selector(didTapAllButton), for: .touchUpInside)
    }
    
    private func reloadAllData() {
        resetCategory()
        getAllMyIngredeint() { [weak self] in
            self?.loadAllRecipes()
        }
    }
    
    private func resetCategory() {
        selectedCategoryIndex = nil
        for index in 0..<categoryData.count {
            if let cell = myCookingView.ingredientCategoryCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? IngredientCategoryCollectionViewCell {
                cell.backgroundColor = UIColor(hex: 0xF7F7F8, alpha: 1.0)
                cell.icon.tintColor = UIColor.black
                cell.categoryName.textColor = .black
            }
        }
    }
    
    // 모두 조회 버튼 클릭시 -> 카테고리 색 원래대로, 버튼 색 표시, 검색창 text 없애기, 모두 조회 API 호출
    @objc private func didTapAllButton() {
        myCookingView.allButton.backgroundColor = UIColor(hex: 0x474747, alpha: 1.0)
        myCookingView.allButton.tintColor = .white
        
        myCookingView.searchBar.text = ""
        
        reloadAllData()
    }
    
    // 검색어가 있을때 -> 모두조회 버튼 클릭해제, 카테고리 선택 비활성화, 검색어로 식재료 검색
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        resetCategory()
        myCookingView.allButton.backgroundColor = UIColor(hex: 0xF7F7F8, alpha: 1.0)
        myCookingView.allButton.tintColor = .black
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        /// 키보드 숨기기
        myCookingView.searchBar.resignFirstResponder()
        self.getByIngredientName(ingredientName: searchBar.text!)
    }
    
    // 키보드 숨기기
    @objc private func dismissKeyboard() {
        // 키보드가 나타나 있을 때만 숨기기
        if myCookingView.searchBar.isFirstResponder {
            myCookingView.searchBar.resignFirstResponder()
            if myCookingView.searchBar.text == "" {
                myCookingView.allButton.backgroundColor = UIColor(hex: 0x474747, alpha: 1.0)
                myCookingView.allButton.tintColor = .white
                reloadAllData()
            }
        }
    }
    
    // MARK: - API 관련
    
    private func getAllMyIngredeint(completion: @escaping () -> Void) {
        APIClient.shared.request("http://3.35.252.162:8080/fridge/recent", method: .get) {
            [weak self] (result: Result<IngredientResponse, Error>) in
            switch result {
            case .success(let response):
                self?.ingredients = response.result.ingredients
                self?.allRecipeData = Array(repeating: [], count: response.result.ingredients.count)
                completion()
            case .failure(let error):
                print("Error loading ingredients: \(error)")
            }
        }
    }
    
    private func loadAllRecipes() {
        let group = DispatchGroup()
        
        for (index, ingredient) in ingredients.enumerated() {
            group.enter()
            getRecommendedRecipes(ingredient: ingredient, index: index) {
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.myCookingView.ingredientsTableView.reloadData()
        }
    }
    
    // 식재료 이름으로 검색 조회
    func getByIngredientName(ingredientName: String) {
        let url = "http://3.35.252.162:8080/fridge/name/recent"
        
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
                print("!!식재료 이름: \(ingredientName) 조회 성공!!")
                self.ingredients = response.result.ingredients
                self.loadAllRecipes()
            case .failure(let error):
                print("네트워킹 오류: \(error)")
            }
        }
    }
    
    // 식재료 대분류 카테고리로 조회후 정렬
    func getByMajorCategoryOrderBy(majorCategory: String) {
        let url = "http://3.35.252.162:8080/fridge/majorCategory/recent"
        
        // 쿼리 파라미터
        let queryParameters: [String: Any] = [
            "majorCategory": majorCategory
        ]
        
        let queryString = APIClient.shared.createQueryString(from: queryParameters)
        let urlWithQuery = "\(url)?\(queryString)"
        
        // API 요청
        APIClient.shared.request(urlWithQuery, method: .get) { (result: Result<IngredientResponse, Error>) in
            switch result {
            case .success(let response):
                print("!!majorCaegory: \(majorCategory) 조회 성공!!")
                self.ingredients = response.result.ingredients
                self.loadAllRecipes()
            case .failure(let error):
                print("네트워킹 오류: \(error)")
            }
        }
    }
    
    private func getRecommendedRecipes(ingredient: MyIngredient, index: Int, completion: @escaping () -> Void) {
        let ingredientName = ingredient.ingredientName
        
        // 1. 캐시 체크
        if let cached = RecipeCache.getRecipes(for: ingredientName) {
            self.allRecipeData[index] = cached
            completion()
            return
        }
        
        let baseUrl = "http://3.35.252.162:8080/recipes/recommend"
        
        let urlWithParams = "\(baseUrl)?ingredients=\(ingredientName)&page=1&size=10"
        
        APIClient.shared.request(urlWithParams, method: .get) { (result: Result<RecommandedRecipeResponse, Error>) in
            switch result {
            case .success(let response):
                let recipes = response.result.recipes
                // 2. 캐시 저장
                RecipeCache.setRecipes(recipes, for: ingredientName)
                self.allRecipeData[index] = recipes
                completion()
            case .failure(let error):
                print("\(ingredientName) 조회 실패: \(error)")
                completion()
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension MyCookingViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == myCookingView.ingredientCategoryCollectionView {
            return categoryData.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == myCookingView.ingredientCategoryCollectionView {
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
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == myCookingView.ingredientCategoryCollectionView {
            selectedCategoryIndex = indexPath
            myCookingView.allButton.backgroundColor = UIColor(hex: 0xF7F7F8, alpha: 1.0)
            myCookingView.allButton.tintColor = .black
            collectionView.reloadData()
            
            myCookingView.searchBar.text = ""
            let selectedCategory = categoryData[indexPath.item].categoryName
            getByMajorCategoryOrderBy(majorCategory: selectedCategory)
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MyCookingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingredients.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsTableViewCell.identifier, for: indexPath) as? IngredientsTableViewCell else {
            return UITableViewCell()
        }
        
        let ingredient = ingredients[indexPath.row]
        cell.configure(model: ingredient)
        
        // 캐시 체크
        if let cachedRecipes = RecipeCache.getRecipes(for: ingredient.ingredientName) {
            cell.updateRecipes(recipes: cachedRecipes)
        } else {
            
            // 비동기 작업 생성
            let operation = BlockOperation { [weak self] in
                self?.getRecommendedRecipes(ingredient: ingredient, index: indexPath.row) {
                    DispatchQueue.main.async {
                        if let recipes = RecipeCache.getRecipes(for: ingredient.ingredientName) {
                            cell.updateRecipes(recipes: recipes)
                        }
                    }
                }
            }
            
            recipeLoadOperations[indexPath] = operation
            imageLoadQueue.addOperation(operation)
        }
        
        cell.cellDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        recipeLoadOperations[indexPath]?.cancel()
    }
}

extension MyCookingViewController: IngredientsTableViewCellDelegate {
    func recipeViewButtonTapped(at indexPath: IndexPath) {
        let selectedIngredient = ingredients[indexPath.row]
        
        
        let recipeViewController = RecipeViewController()
        recipeViewController.hidesBottomBarWhenPushed = true
        recipeViewController.ingredient = selectedIngredient
        self.navigationController?.pushViewController(recipeViewController, animated: true)
    }
}

/// 레시피 화면 전환을 위한 delegate 프로토콜
protocol MyCookingViewControllerDelegate: AnyObject {
    func didTapRecipeViewButton()
}
