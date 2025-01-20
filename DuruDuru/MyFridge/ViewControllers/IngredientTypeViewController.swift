//
//  IngredientTypeViewController.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/19/25.
//

import UIKit

class IngredientTypeViewController: UIViewController {

    // MARK: - Data
    private let categories = ["과일", "육류", "버섯", "유제품", "수산물", "견과류", "건조식품"]
    private let items = [
        "과일": ["사과", "배", "귤"],
        "육류": ["소고기", "돼지고기", "닭고기"],
        "버섯": ["표고버섯", "팽이버섯", "송이버섯"],
        "유제품": ["우유", "요구르트", "치즈", "크림", "버터", "아이스크림"],
        "수산물": ["새우", "참치", "연어"],
        "견과류": ["아몬드", "호두", "캐슈넛"],
        "건조식품": ["쌀", "콩", "밀"]
    ]
    private var selectedCategory: String = "과일" // 기본 선택된 카테고리

    // MARK: - UI Components
    private var ingredientTypeView: IngredientTypeView!

    // MARK: - Lifecycle
    override func loadView() {
        ingredientTypeView = IngredientTypeView()
        self.view = ingredientTypeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        setupInitialState()
        navigationItem.hidesBackButton = true
    }

    // MARK: - Setup
    private func setupActions() {
        ingredientTypeView.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        ingredientTypeView.closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        ingredientTypeView.leftStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        ingredientTypeView.dateButton.addTarget(self, action: #selector(didTapDateButton), for: .touchUpInside)
    }

    private func setupInitialState() {
        updateCategoryButtons()
        ingredientTypeView.pickerView.delegate = self
        ingredientTypeView.pickerView.dataSource = self
        ingredientTypeView.pickerView.reloadAllComponents()
    }

    // MARK: - Actions
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func didTapCategoryButton(_ sender: UIButton) {
        guard let category = sender.title(for: .normal) else { return }
        selectedCategory = category
        updateCategoryButtons()
        ingredientTypeView.pickerView.reloadAllComponents()
    }
    
    @objc private func didTapDateButton() {
        // 날짜 설정 화면으로 이동
        let dateSelectionVC = DateSelectionViewController() 
        navigationController?.pushViewController(dateSelectionVC, animated: true)
    }
    
    private func updateCategoryButtons() {
        ingredientTypeView.leftStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        categories.forEach { category in
            let button = UIButton(type: .system)
            button.setTitle(category, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 16)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = category == selectedCategory ? .systemGreen : .white
            button.layer.cornerRadius = 8
            button.clipsToBounds = true
            button.addTarget(self, action: #selector(didTapCategoryButton(_:)), for: .touchUpInside)
            ingredientTypeView.leftStackView.addArrangedSubview(button)
        }
    }
    
    
}

// MARK: - UIPickerViewDataSource & Delegate
extension IngredientTypeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items[selectedCategory]?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[selectedCategory]?[row]
    }
}
