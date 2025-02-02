//
//  IngredientsViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 1/9/25.
//

import UIKit

class IngredientsViewController: UIViewController, UITextFieldDelegate {

    private var ingredientsView: IngredientsView!
    let categoryData = IngredientCategoryModel.dummy()
    var allIngredientData = IngredientsDataModel.dummy() // 모든 식재료 데이터
    var filteredIngredients: [IngredientsModel] = [] // 필터링된 데이터
    var selectedCategory: IngredientCategoryModel? = nil // 현재 선택된 카테고리

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsView = IngredientsView(frame: self.view.bounds)
        self.view = ingredientsView
        setupDelegate()
        setupFloatingButtonActions()
        setupSearchBar()
        
        filterIngredients(by: nil) // 초기 상태에서는 모든 식재료 보여주기
    }

    private func setupDelegate() {
        ingredientsView.ingredientCategoryCollectionView.dataSource = self
        ingredientsView.ingredientCategoryCollectionView.delegate = self
        ingredientsView.ingredientsCircleCollectionView.dataSource = self
        ingredientsView.ingredientsCircleCollectionView.delegate = self
    }
    
    private func setupFloatingButtonActions() {
        ingredientsView.floatingButton.addTarget(self, action: #selector(togglePopupButtons), for: .touchUpInside)
        ingredientsView.manualButton.addTarget(self, action: #selector(didTapDirectAddButton), for: .touchUpInside)
        ingredientsView.receiptButton.addTarget(self, action: #selector(didTapReceiptAddButton), for: .touchUpInside)
        
        ingredientsView.allButton.addTarget(self, action: #selector(didTapAllCategoryButton), for: .touchUpInside)
    }

    /// 특정 카테고리에 해당하는 식재료만 필터링
    private func filterIngredients(by category: IngredientCategoryModel?) {
        selectedCategory = category
        
        if let category = category {
            filteredIngredients = allIngredientData
                .first(where: { $0.category.categoryName == category.categoryName })?
                .ingredients.map { IngredientsModel(name: $0.name, daysRemaining: "D-0") } ?? []
        } else {
            // 전체 보기
            filteredIngredients = allIngredientData.flatMap { $0.ingredients }.map { IngredientsModel(name: $0.name, daysRemaining: "D-0") }
        }
        ingredientsView.ingredientsCircleCollectionView.reloadData()
    }
    
    /// 식재료 삭제 팝업 (전체 데이터에서도 삭제)
    private func showDeletePopup(for ingredient: IngredientsModel, at indexPath: IndexPath) {
        let alertController = UIAlertController(
            title: "이 식재료를 냉장고에서 삭제할까요?",
            message: "삭제한 식재료는 다시 복구할 수 없어요.",
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(title: "아니요", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "네, 삭제할게요", style: .destructive) { [weak self] _ in
            guard let self = self else { return }

            // 전체 데이터에서 해당 아이템 삭제
            for (index, categoryData) in allIngredientData.enumerated() {
                if let ingredientIndex = categoryData.ingredients.firstIndex(where: { $0.name == ingredient.name }) {
                    allIngredientData[index].ingredients.remove(at: ingredientIndex)
                    break
                }
            }

            // 현재 필터링된 데이터에서도 삭제
            filteredIngredients.remove(at: indexPath.row)

            // 화면 갱신 (현재 선택된 카테고리를 유지하면서 필터링)
            self.filterIngredients(by: self.selectedCategory)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true, completion: nil)
    }

    // 식재료 검색
    private func setupSearchBar() {
        ingredientsView.searchBar.delegate = self
        ingredientsView.searchBar.addTarget(self, action: #selector(didChangeSearchText), for: .editingChanged)
    }

    
    @objc private func togglePopupButtons() {
        let isHidden = ingredientsView.receiptButton.isHidden
        ingredientsView.receiptButton.isHidden = !isHidden
        ingredientsView.manualButton.isHidden = !isHidden
        let newImage = isHidden ? UIImage(named: "close") : UIImage(named: "exchangeFloating")
        ingredientsView.floatingButton.setImage(newImage, for: .normal)
    }

    @objc private func didTapDirectAddButton() {
        let addIngredientVC = AddIngredientViewController()
        addIngredientVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(addIngredientVC, animated: true)
    }

    @objc private func didTapReceiptAddButton() {
        print("영수증으로 추가하기 버튼 클릭")
    }
    
    @objc private func didTapAllCategoryButton() {
        print("전체 카테고리 버튼 클릭됨")
        
        filterIngredients(by: nil) // 전체 카테고리 선택 시 모든 데이터 표시
        selectedCategory = nil
        ingredientsView.ingredientCategoryCollectionView.reloadData()
    }
    
    // 식재료 이름에 따른 필터링
    @objc private func didChangeSearchText() {
        guard let searchText = ingredientsView.searchBar.text, !searchText.isEmpty else {
            filterIngredients(by: selectedCategory) // 검색어가 없으면 기존 필터 유지
            return
        }

        // 현재 필터링된 데이터에서 검색어가 포함된 항목만 필터링
        filteredIngredients = allIngredientData.flatMap { $0.ingredients }
            .map { IngredientsModel(name: $0.name, daysRemaining: "D-0") }
            .filter { $0.name.contains(searchText) }

        ingredientsView.ingredientsCircleCollectionView.reloadData()
    }

}

// MARK: - UICollectionViewDataSource

extension IngredientsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == ingredientsView.ingredientCategoryCollectionView {
            return categoryData.count
        } else if collectionView == ingredientsView.ingredientsCircleCollectionView {
            return filteredIngredients.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == ingredientsView.ingredientCategoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: IngredientCategoryCollectionViewCell.identifier,
                for: indexPath
            ) as? IngredientCategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(model: categoryData[indexPath.row])
            return cell
        } else if collectionView == ingredientsView.ingredientsCircleCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: IngredientsCircleCollectionViewCell.identifier,
                for: indexPath
            ) as? IngredientsCircleCollectionViewCell else {
                return UICollectionViewCell()
            }
            let ingredient = filteredIngredients[indexPath.item]
            cell.configure(with: ingredient)
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegate
extension IngredientsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == ingredientsView.ingredientCategoryCollectionView {
            let selectedCategory = categoryData[indexPath.item]
            filterIngredients(by: selectedCategory)
        } else if collectionView == ingredientsView.ingredientsCircleCollectionView {
            let selectedIngredient = filteredIngredients[indexPath.row]
            showDeletePopup(for: selectedIngredient, at: indexPath)
        }
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension IngredientsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == ingredientsView.ingredientsCircleCollectionView {
            let screenWidth = UIScreen.main.bounds.width
            let cellSpacing: CGFloat = 5
            let totalSpacing = cellSpacing * 4
            let cellWidth = (screenWidth - totalSpacing - 32) / 3 // 3열 유지

            return CGSize(width: cellWidth, height: cellWidth + 30) // 기존보다 더 키움
        }
        return CGSize(width: 66, height: 26)
    }
}
