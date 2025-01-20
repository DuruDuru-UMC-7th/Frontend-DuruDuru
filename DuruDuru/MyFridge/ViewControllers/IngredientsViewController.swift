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
        setupFloatingButtonActions()
        
    }

    private func setupDelegate() {
        ingredientsView.ingredientCategoryCollectionView.dataSource = self
        ingredientsView.ingredientCategoryCollectionView.delegate = self
        ingredientsView.ingredientsCircleCollectionView.dataSource = self
        ingredientsView.ingredientsCircleCollectionView.delegate = self
    }
    
    private func setupFloatingButtonActions() {
        // 플로팅 버튼 클릭 시
        ingredientsView.floatingButton.addTarget(self, action: #selector(togglePopupButtons), for: .touchUpInside)
        // 직접 추가 버튼 클릭 시
        ingredientsView.manualButton.addTarget(self, action: #selector(didTapDirectAddButton), for: .touchUpInside)
        // 영수증 추가 버튼 클릭 시
        ingredientsView.receiptButton.addTarget(self, action: #selector(didTapReceiptAddButton), for: .touchUpInside)
    }

    @objc private func togglePopupButtons() {
        let isHidden = ingredientsView.receiptButton.isHidden
        ingredientsView.receiptButton.isHidden = !isHidden
        ingredientsView.manualButton.isHidden = !isHidden
    }

    @objc private func didTapDirectAddButton() {
        let addIngredientVC = AddIngredientViewController()
        addIngredientVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(addIngredientVC, animated: true)
    }

    @objc private func didTapReceiptAddButton() {
        print("영수증으로 추가하기 버튼 클릭")
        // 영수증 관련 화면 구현 예정
    }


}

// MARK: - UICollectionViewDataSource

extension IngredientsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == ingredientsView.ingredientCategoryCollectionView {
            return data.count // 카테고리 필터 데이터 개수 반환
        } else if collectionView == ingredientsView.ingredientsCircleCollectionView {
            return ingredientData.count // 동그란 식재료 데이터 개수 반환
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

// MARK: - UICollectionViewDelegateFlowLayout

extension IngredientsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == ingredientsView.ingredientCategoryCollectionView {
            // 카테고리 필터 셀 크기 유지
            return CGSize(width: 66, height: 26)
        } else if collectionView == ingredientsView.ingredientsCircleCollectionView {
            // 동그란 식재료 셀 크기 설정 (한 줄에 3개 배치)
            let spacing: CGFloat = 8
            let totalSpacing = spacing * 4
            let cellWidth = (collectionView.frame.width - totalSpacing) / 3
            return CGSize(width: cellWidth, height: cellWidth)
        }
        return CGSize.zero
    }


}
