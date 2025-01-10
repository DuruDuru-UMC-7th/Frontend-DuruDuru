//
//  MyCookingViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 1/9/25.
//

import UIKit

class MyCookingViewController: UIViewController, UICollectionViewDelegate {
    
    private var myCookingView: MyCookingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCookingView = MyCookingView(frame: self.view.bounds)
        self.view = myCookingView
        setupDelegate()
    }
    
    private func setupDelegate(){
        myCookingView.ingredientCategoryCollectionView.dataSource = self
        myCookingView.ingredientCategoryCollectionView.delegate = self
    }
    
}

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
    
