//
//  MyCookingViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 1/9/25.
//

import UIKit

class MyCookingViewController: UIViewController, UICollectionViewDelegate {
    
    
    // MARK: - Properties
    
    private var myCookingView: MyCookingView!
    private var data: [IngredientModel] = []
    let ingredientCategoryList = IngredientCategoryModel.dummy()
    weak var delegate: MyCookingViewControllerDelegate?  ///delegate 변수
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCookingView = MyCookingView(frame: self.view.bounds)
        self.view = myCookingView
        setupDelegate()
        
        /// 키보드 동작을 위한 제스쳐
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        fetchIngredientRecipes()
    }
    
    private func setupDelegate(){
        myCookingView.ingredientCategoryCollectionView.dataSource = self
        myCookingView.ingredientCategoryCollectionView.delegate = self
        myCookingView.ingredientsTableView.dataSource = self
        myCookingView.searchBar.delegate = self
    }
    
    /// 키보드 숨기기
    @objc private func dismissKeyboard() {
        // 키보드가 나타나 있을 때만 숨기기
        if myCookingView.searchBar.isFirstResponder {
            myCookingView.searchBar.resignFirstResponder()
        }
    }
    
    // MARK: - API 관련

    /// 식재료 목록을 최신 등록순으로 불러오는 함수
    func getMyIngredients(completion: @escaping ([IngredientModel]) -> Void) {
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

    /// 내 냉장고 속 식재료 목록을 조회하고, 추천 레시피를 가져오는 함수
    func fetchIngredientRecipes() {
        getMyIngredients { [weak self] ingredients in
            guard let self = self else { return }
            var updatedIngredients = ingredients
            let group = DispatchGroup()
            
            for i in 0..<updatedIngredients.count {
                group.enter()
                self.getRecommendedRecipes(for: updatedIngredients[i]) { recipes in
                    updatedIngredients[i].recipes = recipes
                    print("\(updatedIngredients[i].name)의 추천 레시피 개수: \(recipes.count)")
                    group.leave()
                }
            }
            group.notify(queue: .main) {
                self.data = updatedIngredients
                self.myCookingView.ingredientsTableView.reloadData()
            }
        }
    }

    /// 특정 식재료에 대한 추천 레시피 조회 API 호출
    func getRecommendedRecipes(for ingredient: IngredientModel, completion: @escaping ([RecipeModel]) -> Void) {
        let baseUrl = "http://3.35.252.162:8080/recipes/recommend"

        let urlWithParams = "\(baseUrl)?ingredients=\(ingredient.ingredientId)&page=1&size=10"
        
        APIClient.shared.request(urlWithParams, method: .get) { (result: Result<RecipeResponse, Error>) in
            switch result {
            case .success(let response):
                print("\(ingredient.name)의 추천 레시피 조회 성공: \(response)")
                
                // API 응답을 변환하여 RecipeModel 배열로 저장
                let recipes = response.result.recipes.map { RecipeModel(from: $0) }
                completion(recipes)
                
            case .failure(let error):
                print("\(ingredient.name)의 추천 레시피 조회 실패: \(error)")
                completion([])
            }
        }
    }

    /// 특정 카테고리 기준으로 필터링하여 식재료 가져오기
    func fetchFilteredIngredients(by category: String) {
        let baseUrl = "http://3.35.252.162:8080/fridge/majorCategory/recent"
        let parameters: [String: Any] = ["majorCategory": category]

        APIClient.shared.request(baseUrl, method: .get, parameters: parameters) { (result: Result<IngredientResponse, Error>) in
            switch result {
            case .success(let response):
                print("선택한 카테고리 (\(category)) 식재료 조회 성공: \(response)")
                let ingredients = response.result.ingredients.map { IngredientModel(from: $0) }
                self.data = ingredients
                self.myCookingView.ingredientsTableView.reloadData()

            case .failure(let error):
                print("카테고리 필터링 실패: \(error)")
            }
        }
    }

}

// MARK: - UICollectionViewDataSource

extension MyCookingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == myCookingView.ingredientCategoryCollectionView {
            return ingredientCategoryList.count
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
            cell.configure(model: ingredientCategoryList[indexPath.row])
            return cell
            
        }
        return UICollectionViewCell()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MyCookingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsTableViewCell.identifier, for: indexPath) as? IngredientsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(model: data[indexPath.row])
        cell.cellDelegate = self
        cell.indexPath = indexPath
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == myCookingView.ingredientCategoryCollectionView {
            let selectedCategory = ingredientCategoryList[indexPath.row].categoryName
            print("선택된 카테고리: \(selectedCategory)")
            
            //선택한 카테고리 기준으로 필터링하여 API 호출
            fetchFilteredIngredients(by: selectedCategory)
        }
    }
}

extension MyCookingViewController: IngredientsTableViewCellDelegate {
    func recipeViewButtonTapped(at indexPath: IndexPath) {
        let selectedIngredient = data[indexPath.row]

        let recipeViewController = RecipeViewController()
        recipeViewController.hidesBottomBarWhenPushed = true
        recipeViewController.ingredient = selectedIngredient

        // API 호출하여 추천 레시피 가져오기
        getRecommendedRecipes(for: selectedIngredient) { recipes in
            recipeViewController.recipes = recipes
            self.navigationController?.pushViewController(recipeViewController, animated: true)
        }
    }
}


extension MyCookingViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        /// 키보드 숨기기
        myCookingView.searchBar.resignFirstResponder()
        
        /// 검색 동작
    }
    
}

/// 레시피 화면 전환을 위한 delegate 프로토콜
protocol MyCookingViewControllerDelegate: AnyObject {
    func didTapRecipeViewButton()
}

