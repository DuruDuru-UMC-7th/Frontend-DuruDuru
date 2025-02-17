//
//  DateSelectionViewController.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/19/25.
//

import UIKit
import SwiftUI

class DateSelectionViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    // MARK: - Properties
    private let dateSelectionView = DateSelectionView()
    private var selectedDate = Date()
    private var date: String!
    
    var ingredientId: Int!
//    var purchaseDate: String!
//    var expiryDate: String!
    private var isPurchaseDateSelected: Bool = true
    
    // MARK: - Lifecycle
    override func loadView() {
        view = dateSelectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        setupIconConstraints()
        setUpUI()
        
        dateSelectionView.dateTextField.delegate = self
    }
    
    // MARK: - Setup Methods
    
    private func setUpUI() {
        // 상단바
        let backImage = UIImage(systemName: "chevron.left")
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(didTapBackButton))
        self.navigationItem.leftBarButtonItem = backButton
        backButton.tintColor = .black
        
        let closeImage = UIImage(systemName: "xmark")
        let closeButton = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(didTapCloseButton))
        self.navigationItem.rightBarButtonItem = closeButton
        closeButton.tintColor = .black
        
        self.title = "식재료 추가하기"
    }
    
    private func setupActions() {
        dateSelectionView.confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        dateSelectionView.purchaseDateButton.addTarget(self, action: #selector(didTapPurchaseDate), for: .touchUpInside)
        dateSelectionView.expirationDateButton.addTarget(self, action: #selector(didTapExpirationDate), for: .touchUpInside)
        // 캘린더
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dateFieldTapped))
        dateSelectionView.dateTextField.addGestureRecognizer(tapGesture)
        dateSelectionView.dateTextField.isUserInteractionEnabled = true
        
        dateSelectionView.dateTextField.delegate = self
        dateSelectionView.dateTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func setupIconConstraints() {
        guard let iconView = dateSelectionView.dateTextField.leftView,
              let iconImageView = iconView.subviews.first as? UIImageView else {
            return
        }
        
        iconImageView.snp.makeConstraints {
            $0.centerY.equalTo(iconView)
            $0.leading.equalTo(iconView).offset(10) // 아이콘 왼쪽 여백
            $0.width.height.equalTo(20) // 아이콘 크기
        }
    }
    
    // MARK: - Actions
    
    @objc private func didTapConfirmButton() {
        if isPurchaseDateSelected {
            setPurchaseDate()
        } else {
            setExpiryDate()
        }
        let myFridgeVC = MyFridgeViewController()
        self.navigationController?.setViewControllers([myFridgeVC], animated: true)
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
    
    // 구매한 날짜 버튼 클릭
    @objc private func didTapPurchaseDate() {
        isPurchaseDateSelected = true
//        self.dateSelectionView.dateTextField.text = self.purchaseDate
        updateUIForSelection(
            selectedButton: dateSelectionView.purchaseDateButton,
            deselectedButton: dateSelectionView.expirationDateButton,
            newDateLabelText: "구매한 날짜 입력하기",
            newDescriptionText: "선택한 날짜를 기준으로 두루두루가 적정 소비기한을 계산해요."
        )
    }
    
    // 소비기한 버튼 클릭
    @objc private func didTapExpirationDate() {
        isPurchaseDateSelected = false
//        self.dateSelectionView.dateTextField.text = self.selectedDate
        updateUIForSelection(
            selectedButton: dateSelectionView.expirationDateButton,
            deselectedButton: dateSelectionView.purchaseDateButton,
            newDateLabelText: "소비기한 직접 입력하기",
            newDescriptionText: "포장지에 적혀있는 식재료의 소비기한을 알려주세요."
        )
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let isNotEmpty = !(textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        updateConfirmButtonState(isEnabled: isNotEmpty)
    }
    
    private func updateConfirmButtonState(isEnabled: Bool) {
        dateSelectionView.confirmButton.isEnabled = isEnabled
        dateSelectionView.confirmButton.backgroundColor = isEnabled ? .systemGreen : .systemGray4
    }
    
    @objc private func dateFieldTapped() {
        let calendarVC = UIHostingController(
            rootView: CalendarView(initialDate: selectedDate) { selected in
                self.selectedDate = selected
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy / MM / dd"
                self.dateSelectionView.dateTextField.text = formatter.string(from: selected)
                self.date = formatter.string(from: selected)
//                if self.isPurchaseDateSelected {
//                    self.purchaseDate = formatter.string(from: selected)
//                    self.dateSelectionView.dateTextField.text = self.purchaseDate
//                } else {
//                    self.expiryDate = formatter.string(from: selected)
//                    self.dateSelectionView.dateTextField.text = self.expiryDate
//                }
                
                // 날짜 선택 시 버튼 활성화
                self.updateConfirmButtonState(isEnabled: true)
            }
        )
        present(calendarVC, animated: true)
    }
    
    
    // 버튼 & 라벨 업데이트
    private func updateUIForSelection(
        selectedButton: UIButton,
        deselectedButton: UIButton,
        newDateLabelText: String,
        newDescriptionText: String
    ) {
        selectedButton.backgroundColor = .systemGreen
        selectedButton.setTitleColor(.white, for: .normal)
        
        deselectedButton.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        deselectedButton.setTitleColor(.gray, for: .normal)
        
        dateSelectionView.dateLabel.text = newDateLabelText
        dateSelectionView.descriptionLabel.text = newDescriptionText
    }
    
    // 날짜 형식 변환
    private func formatDate(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy / MM / dd"
        
        if let date = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let formattedDate = dateFormatter.string(from: date)
            
            return formattedDate
        }
        return "형식 변환 오류"
    }
    
    // MARK: - API 관련
    
    // 구매 날짜 설정 API
    func setPurchaseDate() {
        let url = "http://3.35.252.162:8080/ingredient/\(ingredientId!)/purchase-date"
        
        // 쿼리 파라미터
        let requestBody: [String: Any] = [
            "purchaseDate": formatDate(self.date)
        ]
        
        // API 요청
        APIClient.shared.request(url, method: .post, parameters: requestBody) { (result: Result<SetIngredientPurchaseDateResponse, Error>) in
            switch result {
            case .success(let response):
                print("!!식재료 구매날짜 등록 성공!!, 구매날짜: \(response.result.purchaseDate)")
            case .failure(let error):
                print("구매날짜 등록 네트워킹 오류: \(error)")
            }
        }
    }
    
    // 소비기한 날짜 설정 API
    func setExpiryDate() {
        let url = "http://3.35.252.162:8080/ingredient/\(ingredientId!)/expiry-date"
        
        // 쿼리 파라미터
        let requestBody: [String: Any] = [
            "expiryDate": formatDate(self.date)
        ]
        
        // API 요청
        APIClient.shared.request(url, method: .post, parameters: requestBody) { (result: Result<SetIngredientExpiryDateResponse, Error>) in
            switch result {
            case .success(let response):
                print("!!식재료 소비기한 등록 성공!!, 소비기한: \(response.result.expiryDate)")
            case .failure(let error):
                print("소비기한 등록 네트워킹 오류: \(error)")
            }
        }
    }
}
