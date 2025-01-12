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
    let data = RecipeModel.dummy()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeView = RecipeView(frame: self.view.bounds)
        self.view = recipeView
        if let backImage = UIImage(named: "Arrow3")?.withRenderingMode(.alwaysOriginal) {
            let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        print("전달받은 ingredientName: \(ingredientName ?? "없음")")
        setupDelegate()
    }
    
    private func setupDelegate(){
        recipeView.recipeTableView.dataSource = self
        recipeView.ingredientName.text = ingredientName
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension RecipeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.identifier, for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        if let imageURL = URL(string: data[indexPath.row].titleImage) {
            cell.titleImage.kf.setImage(with: imageURL)
        }
        cell.recipeName.text = data[indexPath.row].recipeName
        
        
        return cell
    }
}
