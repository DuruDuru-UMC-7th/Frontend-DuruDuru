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
    var ingredient: IngredientsModel?
    var recipes = IngredientModel.dummy()[0].recipes

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ingredientDetailView = IngredientDetailView(frame: self.view.bounds)
        self.view = ingredientDetailView
        ingredientDetailView.ingredientName.text = ingredient?.name
        
        setUpUIBar()
        setupDelegate()
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
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
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
