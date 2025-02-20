//
//  IngredientDetailViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 2/7/25.
//

import UIKit

class IngredientDetailViewController: UIViewController {
    
    // MARK: - Properties
    private var ingredientDetailView: IngredientDetailView!
    var ingredient: MyIngredient! {
        didSet {
            recipes = [] 
        }
    }
    var recipes: [Recipe] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ingredientDetailView = IngredientDetailView(frame: self.view.bounds)
        self.view = ingredientDetailView
        ingredientDetailView.config(ingredient: self.ingredient)
        
        // 캐시에서 레시피 불러오기
        loadRecipesFromCache()
        
        setUpUIBar()
        setupDelegate()
        setUpActions()
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
            ingredientDetailView.recipeTableView.reloadData()
        } else {
            print("캐시에 레시피 정보 없음")
            self.title = "\(ingredientName)을 사용하는 레시피 (0)"
        }
    }
    
    // MARK: - Funtions
    
    private func setupDelegate(){
        ingredientDetailView.recipeTableView.dataSource = self
        ingredientDetailView.recipeTableView.delegate = self
    }
    
    func setUpUIBar() {
        /// 뒤로 가기 버튼
        let backImage = UIImage(systemName: "chevron.left")
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
        backButton.tintColor = .black
        
        self.title = "식재료 정보"
        
    }
    
    func setUpActions() {
        ingredientDetailView.deleteIngredient.addTarget(self, action: #selector(ingredientDeleteButtonTapped), for: .touchUpInside)
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func ingredientDeleteButtonTapped() {
        deleteIngredient(deletedIngredientId: ingredient.ingredientId)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - API 관련
    
    // 식재료 삭제 API
    func deleteIngredient(deletedIngredientId: Int) {
        let url = "http://3.35.252.162:8080/ingredient/\(deletedIngredientId)"
        
        // API 요청
        APIClient.shared.request(url, method: .delete) { (result: Result<DeleteIngredientResponse, Error>) in
            switch result {
            case .success(_):
                print("!!식재료 삭제 성공!!")
            case .failure(let error):
                print("네트워킹 오류: \(error)")
            }
        }
    }
}

extension IngredientDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.identifier, for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(recipe: recipes[indexPath.row])
        
        return cell
    }
}
