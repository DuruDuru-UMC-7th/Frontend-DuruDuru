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
    var ingredientName: String?  /// 전달 받은 재료 이름
    var recipes = [RecipeModel]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeView = RecipeView(frame: self.view.bounds)
        self.view = recipeView
        
        /// 뒤로 가기 버튼
        let backImage = UIImage(systemName: "chevron.left")
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
        backButton.tintColor = .black
        
        self.title = (ingredientName ?? "없음") + "을 사용하는 레시피"
        setupDelegate()
        
        /// 키보드 동작을 위한 제스쳐
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Funtions
    
    private func setupDelegate(){
        recipeView.recipeTableView.dataSource = self
        recipeView.recipeTableView.delegate = self
        recipeView.searchBar.delegate = self
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// 키보드 숨기기
    @objc private func dismissKeyboard() {
        // 키보드가 나타나 있을 때만 숨기기
        if recipeView.searchBar.isFirstResponder {
            recipeView.searchBar.resignFirstResponder()
        }
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension RecipeViewController: UITableViewDataSource, UITableViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let selectedRecipe = recipes[indexPath.row]
        let recipeDetailVC = RecipeDetailViewController()
        
//        recipeDetailVC.recipe = selectedRecipe
        
        // 화면 전환을 수행합니다.
        navigationController?.pushViewController(recipeDetailVC, animated: true)
    }
}

extension RecipeViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        /// 키보드 숨기기
        recipeView.searchBar.resignFirstResponder()
        
        /// 검색 동작
    }
    
}

