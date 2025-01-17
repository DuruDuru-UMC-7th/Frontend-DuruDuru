//
//  RecipeViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 1/12/25.
//

import UIKit
import Kingfisher

class RecipeViewController: UIViewController {
    
    private var recipeView: RecipeView!
    var ingredientName: String?  /// 전달 받은 재료 이름
    var recipes = [RecipeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeView = RecipeView(frame: self.view.bounds)
        self.view = recipeView
        if let backImage = UIImage(named: "Arrow3")?.withRenderingMode(.alwaysOriginal) {
            let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.title = (ingredientName ?? "없음") + "을 사용하는 레시피"
        setupDelegate()
    }
    
    private func setupDelegate(){
        recipeView.recipeTableView.dataSource = self
        recipeView.recipeTableView.delegate = self
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension RecipeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.identifier, for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        if let imageURL = URL(string: recipes[indexPath.row].titleImage) {
            cell.titleImage.kf.setImage(with: imageURL)
        }
        cell.recipeName.text = recipes[indexPath.row].recipeName
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // 선택된 셀의 레시피 정보를 가져옵니다.
            let selectedRecipe = recipes[indexPath.row]
            // RecipeDetailViewController를 인스턴스화합니다.
            let recipeDetailVC = RecipeDetailViewController()
            
            // 선택된 레시피 정보를 전달합니다.
//            recipeDetailVC.recipe = selectedRecipe
            
            // 화면 전환을 수행합니다.
            navigationController?.pushViewController(recipeDetailVC, animated: true)
        }
    
    
}
