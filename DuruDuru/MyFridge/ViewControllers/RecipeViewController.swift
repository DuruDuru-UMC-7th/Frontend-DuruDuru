//
//  RecipeViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 1/12/25.
//

import UIKit
import Kingfisher

class RecipeViewController: UIViewController {
    
    // MARK: - Properties
    private var recipeView: RecipeView!
    var ingredientName: String?  // 전달 받은 재료 이름
    var recipes = [Recipe]()
    var ingredient: MyIngredient!
    var recipesOrderByLike: [Recipe] = []
    var recipesOrderByRecent: [Recipe] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeView = RecipeView(frame: self.view.bounds)
        self.view = recipeView
        
        let backImage = UIImage(systemName: "chevron.left")
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
        backButton.tintColor = .black
        
        self.title = (ingredient.ingredientName) + "을 사용하는 레시피"
        setupDelegate()
        setupOptionViewActions()
        
        // 캐시에서 레시피 불러오기
        loadRecipesFromCache()
        
        // 키보드 동작을 위한 제스처 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - 캐시에서 레시피 로드
    
    private func loadRecipesFromCache() {
        guard let ingredientName = ingredient?.ingredientName else {
            print("식재료 정보 없음")
            return
        }
        
        // 캐시에서 레시피 조회
        if let cachedRecipes = RecipeCache.getRecipes(for: ingredientName) {
            self.recipes = cachedRecipes
            self.title = "\(ingredientName)을 사용하는 레시피"
            recipeView.recipeTableView.reloadData()
            self.recipesOrderByRecent = cachedRecipes
            let sortedRecipes = recipes.sorted { $0.favoriteCount > $1.favoriteCount }
            self.recipesOrderByLike = sortedRecipes
        } else {
            print("캐시에 레시피 정보 없음")
            self.title = "\(ingredientName)을 사용하는 레시피 (0)"
        }
    }
    
    
    // MARK: - Functions
    private func setupDelegate(){
        recipeView.recipeTableView.dataSource = self
        recipeView.recipeTableView.delegate = self
        recipeView.searchBar.delegate = self
    }
    
    /// 옵션뷰 관련 액션 설정
    private func setupOptionViewActions() {
        // 옵션뷰를 표시하기 위해 orderFilterButton에 액션 추가
        recipeView.orderFilterButton.addTarget(self, action: #selector(showOptionsView), for: .touchUpInside)
        
        // 옵션뷰 내 닫기 버튼 액션 추가
        recipeView.menuCloseButton.addTarget(self, action: #selector(hideOptionsView), for: .touchUpInside)
        
        // 필터 버튼 액션 추가 ("찜 많은 순", "최신 등록순")
        recipeView.moreFilter.addTarget(self, action: #selector(didSelectMoreFilter), for: .touchUpInside)
        recipeView.recentFilter.addTarget(self, action: #selector(didSelectRecentFilter), for: .touchUpInside)
        
        // 어두운 배경을 탭하면 옵션뷰가 숨겨지도록 제스처 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideOptionsView))
        recipeView.darkBackgroundView.addGestureRecognizer(tapGesture)
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// 키보드 숨기기
    @objc private func dismissKeyboard() {
        if recipeView.searchBar.isFirstResponder {
            recipeView.searchBar.resignFirstResponder()
        }
    }
    
    // MARK: - 옵션뷰 표시/숨김 및 필터 업데이트
    
    /// 옵션뷰를 표시합니다.
    @objc private func showOptionsView() {
        recipeView.optionsView.isHidden = false
        recipeView.darkBackgroundView.isHidden = false
    }
    
    /// 옵션뷰를 숨깁니다.
    @objc private func hideOptionsView() {
        recipeView.optionsView.isHidden = true
        recipeView.darkBackgroundView.isHidden = true
    }
    
    /// 선택된 필터 버튼의 스타일을 업데이트하고, 드롭다운 버튼의 타이틀을 변경한 후 옵션뷰를 숨깁니다.
    private func updateSelectedOrder(_ selectedButton: UIButton) {
        // 모든 필터 버튼의 타이틀 색상을 기본값으로 설정 (여기서는 "찜 많은 순"과 "최신 등록순")
        recipeView.moreFilter.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
        recipeView.recentFilter.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
        
        // 선택된 버튼의 타이틀을 검정색, 볼드체로 설정
        selectedButton.setTitleColor(.black, for: .normal)
        selectedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        // 드롭다운 버튼(순서 필터 버튼)의 타이틀 업데이트
        recipeView.orderFilterButton.configuration?.attributedTitle = AttributedString(selectedButton.title(for: .normal) ?? "", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 12)]))
        
        // 옵션뷰 숨김 처리
        recipeView.optionsView.isHidden = true
        recipeView.darkBackgroundView.isHidden = true
    }
    
    /// "찜 많은 순" 필터 선택 시 호출
    @objc private func didSelectMoreFilter() {
        print("찜 많은 순 선택")
        updateSelectedOrder(recipeView.moreFilter)
        self.recipes = self.recipesOrderByLike
        self.recipeView.recipeTableView.reloadData()
    }
    
    /// "최신 등록순" 필터 선택 시 호출
    @objc private func didSelectRecentFilter() {
        print("최신 등록순 선택")
        updateSelectedOrder(recipeView.recentFilter)
        self.recipes = self.recipesOrderByRecent
        self.recipeView.recipeTableView.reloadData()
    }
    
    // 레시피 검색 API
    func getByIngredientName(ingredientName: String) {
        let url = "http://3.35.252.162:8080/recipes/search)"
        
        // 쿼리 파라미터
        let queryParameters: [String: Any] = [
            "query": ingredientName,
            "page": 1,
            "size": 10,
        ]
        
        let queryString = APIClient.shared.createQueryString(from: queryParameters)
        let urlWithQuery = "\(url)?\(queryString)"
        
        // API 요청
        APIClient.shared.request(urlWithQuery, method: .get) { (result: Result<RecommandedRecipeResponse, Error>) in
            switch result {
            case .success(let response):
                print("!!이름: \(ingredientName) 레시피 조회 성공!!")
                self.recipes = response.result.recipes
                self.updateSelectedOrder(self.recipeView.recentFilter)
                self.recipeView.recipeTableView.reloadData()
            case .failure(let error):
                print("네트워킹 오류: \(error)")
            }
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension RecipeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.identifier, for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(recipe: recipes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeDetailVC = RecipeDetailViewController()
        recipeDetailVC.recipeName = recipes[indexPath.row].recipeName
        navigationController?.pushViewController(recipeDetailVC, animated: true)
    }
    
}

// MARK: - UISearchBarDelegate
extension RecipeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        recipeView.searchBar.resignFirstResponder()
        
    }
}
