//
//  ExchangeRegisterDetailViewController.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/28/25.
//

import UIKit

class ExchangeRegisterDetailViewController: UIViewController {
    
    // MARK: - Properties
    private let detailView = ExchangeRegisterDetailView() // 커스텀 뷰
    private var ingredient: IngredientsModel? // 선택된 식재료
    private var quantity: Int = 0
    private var selectedMethod: String? = nil
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setupActions() // 버튼 동작 설정
    }
    
    override func loadView() {
        self.view = detailView // 커스텀 뷰 설정
    }
    
    // MARK: - Configure
    func configure(with ingredient: IngredientsModel) {
        self.ingredient = ingredient
        
        // 전달받은 데이터를 뷰에 반영
        detailView.ingredientNameLabel.text = ingredient.name
        let daysRemaining = ingredient.daysRemaining.replacingOccurrences(of: "D-", with: "")
        detailView.expiryLabel.text = "남은 소비기한 \(daysRemaining)일"
    }
    
    // MARK: - Actions
    private func setupActions() {
        detailView.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        detailView.closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        detailView.minusButton.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
        detailView.plusButton.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        detailView.unitButton.addTarget(self, action: #selector(didTapUnitButton), for: .touchUpInside)
        detailView.shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        detailView.exchangeButton.addTarget(self, action: #selector(didTapExchangeButton), for: .touchUpInside)
    }
    
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true) // 네비게이션 스택에서 이전 화면으로 이동
    }
    
    @objc private func didTapCloseButton() {
        // 네비게이션 스택을 초기화하고 첫 화면으로 이동
        navigationController?.popToRootViewController(animated: true)
    }
    @objc private func didTapMinusButton() {
        if quantity > 0 { // 0 이하로 내려가지 않음
            quantity -= 1
            updateQuantityLabel()
        }
    }
    
    @objc private func didTapPlusButton() {
        quantity += 1
        updateQuantityLabel()
    }
    
    private func updateQuantityLabel() {
        detailView.quantityValueLabel.text = "\(quantity)"
    }
    
    @objc private func didTapUnitButton() {
        // 드롭다운 메뉴 구현 (UIAlertController 사용)
        let alert = UIAlertController(title: "단위 선택", message: nil, preferredStyle: .actionSheet)
        let units = ["g", "kg", "개", "봉지"] // 단위 리스트
        for unit in units {
            alert.addAction(UIAlertAction(title: unit, style: .default, handler: { _ in
                self.detailView.unitButton.setTitle(unit, for: .normal)
            }))
        }
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func didTapShareButton() {
        selectedMethod = "나눔"
        detailView.updateButtonStyle(
            selectedButton: detailView.shareButton,
            deselectedButton: detailView.exchangeButton
        )
    }
    
    @objc private func didTapExchangeButton() {
        selectedMethod = "교환"
        detailView.updateButtonStyle(
            selectedButton: detailView.exchangeButton,
            deselectedButton: detailView.shareButton
        )
    }
}
