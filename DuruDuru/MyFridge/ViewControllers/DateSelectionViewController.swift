//
//  DateSelectionViewController.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/19/25.
//

import UIKit

class DateSelectionViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    // MARK: - Properties
    private let dateSelectionView = DateSelectionView()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = dateSelectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        setupIconConstraints()
        navigationItem.hidesBackButton = true
        
        dateSelectionView.dateTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        /// 이메일 텍스트 필드에 포커스
        dateSelectionView.dateTextField.becomeFirstResponder()
    }
    
    // MARK: - Setup Methods
    private func setupActions() {
        dateSelectionView.confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        dateSelectionView.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
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
        print("식재료 추가 완료")

        let myFridgeVC = MyFridgeViewController()
        navigationController?.setViewControllers([myFridgeVC], animated: true)
    }

    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    //키보드 delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.isEqual(dateSelectionView.dateTextField)){
            dateSelectionView.dateTextField.resignFirstResponder()
        }
        return true
    }
}
