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
    let data = IngredientModel.dummy()
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
}

extension MyCookingViewController: IngredientsTableViewCellDelegate {
    /// 버튼 눌렀을 때 레시피 화면으로 데이터 전달
    func recipeViewButtonTapped(at indexPath: IndexPath) {
        let selectedIngredientName = data[indexPath.row].name
        
        let recipeViewController = RecipeViewController()
        recipeViewController.hidesBottomBarWhenPushed = true
        recipeViewController.ingredientName = selectedIngredientName
        recipeViewController.recipes = data[indexPath.row].recipes
        navigationController?.pushViewController(recipeViewController, animated: true)
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

