//
//  IngredientTypeViewController.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/19/25.
//

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
    private var ingredientData = IngredientsDataModel.dummy()
    
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


    private func showBottomPopup(for ingredient: IngredientSimpleModel) {
        // 팝업 컨테이너 뷰
        let popupView = UIView()
        popupView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        popupView.layer.cornerRadius = 16
        popupView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        popupView.clipsToBounds = true
        popupView.tag = 999 // 중복 방지를 위한 태그 설정

        // 팝업 높이 설정
        let popupHeight: CGFloat = 250

        // 팝업 제목
        let titleLabel = UILabel()
        titleLabel.text = "이렇게 보관할 거예요!"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center

        // 팝업 메시지
        let messageLabel = UILabel()
        messageLabel.text = "보관 방식에 따라 적용되는 소비기한이 달라져요"
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.textAlignment = .center
        messageLabel.textColor = .darkGray

        // 버튼들 (실온, 냉장, 냉동)
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16


        let roomTempButton = UIButton(type: .system)
        configureButton(roomTempButton, title: "실온")
        roomTempButton.addTarget(self, action: #selector(didSelectRoomTemp), for: .touchUpInside)

        let fridgeButton = UIButton(type: .system)
        configureButton(fridgeButton, title: "냉장")
        fridgeButton.addTarget(self, action: #selector(didSelectFridge), for: .touchUpInside)

        let freezerButton = UIButton(type: .system)
        configureButton(freezerButton, title: "냉동")
        freezerButton.addTarget(self, action: #selector(didSelectFreezer), for: .touchUpInside)


        stackView.addArrangedSubview(roomTempButton)
        stackView.addArrangedSubview(fridgeButton)
        stackView.addArrangedSubview(freezerButton)

        // 팝업 레이아웃 설정
        popupView.addSubview(titleLabel)
        popupView.addSubview(messageLabel)
        popupView.addSubview(stackView)

        view.addSubview(popupView)

        popupView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            popupView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            popupView.heightAnchor.constraint(equalToConstant: popupHeight),

            titleLabel.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),

            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),

            stackView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])

        // "날짜 설정하러 가기" 버튼 숨기기
        ingredientTypeView.dateButton.isHidden = true

        // "다음 단계" 버튼 추가
        let nextButton = UIButton(type: .system)
        nextButton.setTitle("다음 단계", for: .normal)
        nextButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.backgroundColor = .systemGreen
        nextButton.layer.cornerRadius = 8
        nextButton.tag = 998 // 중복 방지를 위한 태그 설정
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)

        view.addSubview(nextButton)

        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
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
    
    private func configureButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.backgroundColor = .lightGray // 기본 회색
        button.setTitleColor(.darkGray, for: .normal) // 기본 진한 회색 글씨
        button.layer.cornerRadius = 8
    }
    
    @objc private func didSelectRoomTemp(_ sender: UIButton) {
        resetButtonStates()
        updateButtonState(sender, isSelected: true)
    }

    @objc private func didSelectFridge(_ sender: UIButton) {
        resetButtonStates()
        updateButtonState(sender, isSelected: true)
    }

    @objc private func didSelectFreezer(_ sender: UIButton) {
        resetButtonStates()
        updateButtonState(sender, isSelected: true)
    }

    
    private func resetButtonStates() {
        for subview in view.subviews {
            if let stackView = subview.subviews.first(where: { $0 is UIStackView }) as? UIStackView {
                for button in stackView.arrangedSubviews where button is UIButton {
                    updateButtonState(button as! UIButton, isSelected: false)
                }
            }
        }
    }

    private func updateButtonState(_ button: UIButton, isSelected: Bool) {
        if isSelected {
            button.backgroundColor = .systemGreen // 선택 시 초록색
            button.setTitleColor(.white, for: .normal) // 글씨 흰색
        } else {
            button.backgroundColor = .lightGray // 기본 회색
            button.setTitleColor(.darkGray, for: .normal) // 글씨 진한 회색
        }
    }
    
    @objc private func didTapNextButton() {
        print("다음 단계 버튼 클릭")
        dismissBottomPopup()
    }
    
    private func dismissBottomPopup() {
        if let popupView = view.subviews.first(where: { $0.tag == 999 }) {
            popupView.removeFromSuperview()
        }
        if let nextButton = view.subviews.first(where: { $0.tag == 998 }) {
            nextButton.removeFromSuperview()
        }
        // "날짜 설정하러 가기" 버튼 다시 보이기
        ingredientTypeView.dateButton.isHidden = false
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
            
            // 팝업 띄우기
            showBottomPopup(for: selectedIngredient)
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
