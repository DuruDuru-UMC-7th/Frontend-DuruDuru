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
        setUpUI()
        
        dateSelectionView.dateTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        /// 이메일 텍스트 필드에 포커스
        dateSelectionView.dateTextField.becomeFirstResponder()
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
    
    @objc private func didTapCloseButton() {
        
        if let presentingVC = presentingViewController {
            presentingVC.dismiss(animated: true, completion: nil)
        } else if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        } else {
        }
    }
    
    //키보드 delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.isEqual(dateSelectionView.dateTextField)){
            dateSelectionView.dateTextField.resignFirstResponder()
        }
        return true
    }
}
