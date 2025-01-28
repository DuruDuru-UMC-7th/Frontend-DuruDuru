//
//  ExchangeRegisterViewController.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/28/25.
//

import UIKit

class ExchangeRegisterViewController: UIViewController {
    
    // MARK: - Properties
    private var exchangeRegisterView: ExchangeRegisterView!
    private var ingredients: [IngredientsModel] = IngredientsModel.dummy()
    private var selectedIngredient: IngredientsModel?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exchangeRegisterView = ExchangeRegisterView(frame: self.view.bounds)
        self.view = exchangeRegisterView
        navigationItem.hidesBackButton = true
        hidesBottomBarWhenPushed = true
        setupActions()
        setupCollectionView()
    }
    
    // MARK: - Actions
    private func setupActions() {
        exchangeRegisterView.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        exchangeRegisterView.closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        exchangeRegisterView.nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }

    private func setupCollectionView() {
        exchangeRegisterView.ingredientsCircleCollectionView.delegate = self
        exchangeRegisterView.ingredientsCircleCollectionView.dataSource = self
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapNextButton() {
        guard let selectedIngredient = selectedIngredient else {
            let alert = UIAlertController(title: "선택 오류", message: "식재료를 선택해주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)
            return
        }
        let detailVC = ExchangeRegisterDetailViewController()
        detailVC.configure(with: selectedIngredient)
        navigationController?.pushViewController(detailVC, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIngredient = ingredients[indexPath.row]
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ExchangeRegisterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: IngredientsCircleCollectionViewCell.identifier,
            for: indexPath
        ) as? IngredientsCircleCollectionViewCell else {
            return UICollectionViewCell()
        }
        let ingredient = ingredients[indexPath.row]
        cell.configure(with: ingredient)
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        selectedIngredient = ingredients[indexPath.row]
//    }
}
