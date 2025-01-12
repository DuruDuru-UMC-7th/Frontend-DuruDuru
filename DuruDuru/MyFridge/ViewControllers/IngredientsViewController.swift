//
//  IngredientsViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 1/9/25.
//

import UIKit

class IngredientsViewController: UIViewController, UICollectionViewDelegate {
    
    private var ingredientsView: IngredientsView!
    let data = IngredientCategoryModel.dummy()
    let ingredientData = IngredientModel.dummy()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientsView = IngredientsView(frame: self.view.bounds)
        self.view = ingredientsView
        setupDelegate()
    }
    
    private func setupDelegate(){
        ingredientsView.ingredientCategoryCollectionView.dataSource = self
        ingredientsView.ingredientCategoryCollectionView.delegate = self
        ingredientsView.ingredientsCircleCollectionView.dataSource = self
        ingredientsView.ingredientsCircleCollectionView.delegate = self
        
    }
    
}


// MARK: - UICollectionViewDataSource

extension IngredientsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == ingredientsView.ingredientCategoryCollectionView {
            return data.count // 카테고리 필터 데이터 개수 반환
        } else if collectionView == ingredientsView.ingredientsCircleCollectionView {
            return ingredientData.count // 식재료 목록 데이터 개수 반환
        }
        return 0
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == ingredientsView.ingredientCategoryCollectionView {
            // 카테고리 필터 셀 처리
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: IngredientCategoryCollectionViewCell.identifier,
                for: indexPath
            ) as? IngredientCategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let category = data[indexPath.item]
            cell.icon.image = category.icon
            cell.categoryName.text = category.categoryName
            return cell
            
        } else if collectionView == ingredientsView.ingredientsCircleCollectionView {
            // 동그란 식재료 셀 처리
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: IngredientsCircleCollectionViewCell.identifier,
                for: indexPath
            ) as? IngredientsCircleCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let ingredient = ingredientData[indexPath.item]
            cell.configure(with: ingredient)
            return cell
        }
        
        return UICollectionViewCell()
    }

}


