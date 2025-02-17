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
    //private var ingredients: [IngredientsModel] = IngredientsModel.dummy()
    private var ingredients: [TradeItem] = []  // 품앗이 데이터 저장
    private var selectedIngredient: TradeItem?

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exchangeRegisterView = ExchangeRegisterView(frame: self.view.bounds)
        self.view = exchangeRegisterView
        navigationItem.hidesBackButton = true
        hidesBottomBarWhenPushed = true
        setupActions()
        setupCollectionView()
        
        fetchTradeHistory() // 품앗이 목록 가져오기
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
        
        if let presentingVC = presentingViewController {
            presentingVC.dismiss(animated: true, completion: nil)
        } else if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        } else {
        }
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

    
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        selectedIngredient = ingredients[indexPath.row]
    
    // MARK: - API
    private func fetchTradeHistory() {
        let url = "http://3.35.252.162:8080/trade/my/history"

        APIClient.shared.request(url, method: .get) { (result: Result<TradeHistoryResponse, Error>) in
            switch result {
            case .success(let response):
                print("품앗이 목록 조회 성공: \(response)")
                self.ingredients = response.result.tradeList
                
                DispatchQueue.main.async {
                    self.exchangeRegisterView.ingredientsCircleCollectionView.reloadData()
                }
                
            case .failure(let error):
                print("품앗이 목록 조회 실패: \(error)")
            }
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIngredient = ingredients[indexPath.row]
        print("선택한 식재료: \(selectedIngredient?.title ?? "알 수 없음")")
    }

}
