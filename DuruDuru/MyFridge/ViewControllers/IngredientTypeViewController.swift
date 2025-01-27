//
//  IngredientTypeViewController.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/19/25.
//

import UIKit

class IngredientTypeViewController: UIViewController {
    
    // MARK: - UI Components
    private var ingredientTypeView: IngredientTypeView!
    
    // 카테고리 데이터
    private let categories = IngredientCategoryModel.dummy()
    
    // 식재료 데이터 (IngredientSimpleModel 기반)
    private let ingredientData = IngredientData.dummy()
    
    private var filteredIngredients: [IngredientSimpleModel] = [] // 현재 선택된 카테고리의 식재료
    
    // MARK: - Lifecycle
    override func loadView() {
        ingredientTypeView = IngredientTypeView()
        self.view = ingredientTypeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        setupDelegates()
        filterIngredients(for: nil) // 초기 상태: 모든 식재료 표시
        navigationItem.hidesBackButton = true
    }

    // MARK: - Setup
    private func setupActions() {
        ingredientTypeView.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        ingredientTypeView.closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        ingredientTypeView.dateButton.addTarget(self, action: #selector(didTapDateButton), for: .touchUpInside)
    }
    
    private func setupDelegates() {
        ingredientTypeView.ingredientCategoryCollectionView.delegate = self
        ingredientTypeView.ingredientCategoryCollectionView.dataSource = self
        ingredientTypeView.ingredientsCircleCollectionView.delegate = self
        ingredientTypeView.ingredientsCircleCollectionView.dataSource = self
    }
    
    // MARK: - Filtering
    private func filterIngredients(for category: IngredientCategoryModel?) {
        if let category = category {
            filteredIngredients = ingredientData
                .first(where: { $0.category.categoryName == category.categoryName })?
                .ingredients ?? []
        } else {
            // 모든 카테고리의 식재료를 평평하게(flatMap) 펼쳐서 보여줌
            filteredIngredients = ingredientData.flatMap { $0.ingredients }
        }
        ingredientTypeView.ingredientsCircleCollectionView.reloadData()
    }


    // MARK: - Actions
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapDateButton() {
        let dateSelectionVC = DateSelectionViewController()
        navigationController?.pushViewController(dateSelectionVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension IngredientTypeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == ingredientTypeView.ingredientCategoryCollectionView {
            return categories.count // 카테고리 개수
        } else if collectionView == ingredientTypeView.ingredientsCircleCollectionView {
            return filteredIngredients.count // 필터링된 식재료 개수
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == ingredientTypeView.ingredientCategoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: IngredientCategoryCollectionViewCell.identifier,
                for: indexPath
            ) as? IngredientCategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            let category = categories[indexPath.item]
            cell.configure(model: category)
            return cell
        } else if collectionView == ingredientTypeView.ingredientsCircleCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: IngredientsCircleCollectionViewCell.identifier,
                for: indexPath
            ) as? IngredientsCircleCollectionViewCell else {
                return UICollectionViewCell()
            }
            let ingredient = filteredIngredients[indexPath.item]
            cell.configureSimple(with: ingredient) // 심플 모델 기반 셀 구성
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegate
extension IngredientTypeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == ingredientTypeView.ingredientCategoryCollectionView {
            let selectedCategory = categories[indexPath.item]
            filterIngredients(for: selectedCategory)
        } else if collectionView == ingredientTypeView.ingredientsCircleCollectionView {
            let selectedIngredient = filteredIngredients[indexPath.item]
            print("선택된 식재료: \(selectedIngredient.name)")
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension IngredientTypeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == ingredientTypeView.ingredientCategoryCollectionView {
            return CGSize(width: 66, height: 26)
        } else if collectionView == ingredientTypeView.ingredientsCircleCollectionView {
            let spacing: CGFloat = 8
            let totalSpacing = spacing * 4
            let cellWidth = (collectionView.frame.width - totalSpacing) / 3
            return CGSize(width: cellWidth, height: cellWidth)
        }
        return CGSize.zero
    }
}
