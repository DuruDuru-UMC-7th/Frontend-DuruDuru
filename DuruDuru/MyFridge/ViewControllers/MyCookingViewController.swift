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
    let data = IngredientCategoryModel.dummy()
    weak var delegate: MyCookingViewControllerDelegate?  /// delegate 변수
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCookingView = MyCookingView(frame: self.view.bounds)
        self.view = myCookingView
        setupDelegate()
    }
    
    private func setupDelegate(){
        myCookingView.ingredientCategoryCollectionView.dataSource = self
        myCookingView.ingredientCategoryCollectionView.delegate = self
        myCookingView.ingredientsTableView.dataSource = self
    }
}

// MARK: - UICollectionViewDataSource

extension MyCookingViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == myCookingView.ingredientCategoryCollectionView {
            return IngredientCategoryModel.dummy().count
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
            let list = IngredientCategoryModel.dummy()
            cell.icon.image = list[indexPath.row].icon
            cell.categoryName.text = list[indexPath.row].categoryName
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
}

extension MyCookingViewController: IngredientsTableViewCellDelegate {
    func recipeViewButtonTapped(at indexPath: IndexPath) {
        let selectedIngredientName = data[indexPath.row].categoryName
        
        let recipeViewController = RecipeViewController()
        recipeViewController.ingredientName = selectedIngredientName 
        navigationController?.pushViewController(recipeViewController, animated: true)
    }
}

/// 레시피 화면 전환을 위한 delegate 프로토콜
protocol MyCookingViewControllerDelegate: AnyObject {
    func didTapRecipeViewButton()
}

