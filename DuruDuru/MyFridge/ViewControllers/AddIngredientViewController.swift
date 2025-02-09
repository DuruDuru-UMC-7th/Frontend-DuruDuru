//
//  AddIngredientViewController.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/19/25.
//

import UIKit

class AddIngredientViewController: UIViewController, UITextFieldDelegate {

    // ✅ **뷰 분리**
    private let addIngredientView = AddIngredientView()

    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = addIngredientView // ✅ 뷰를 커스텀 뷰로 변경
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        addIngredientView.nameTextField.delegate = self
        navigationItem.hidesBackButton = true
    }
    
    // MARK: - Actions 설정
    
    private func setupActions() {
        addIngredientView.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        addIngredientView.closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        addIngredientView.nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
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
        let nextVC = IngredientTypeViewController() // 종류 설정 화면
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    /// textField return 누를때 동작
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addIngredientView.nameTextField.resignFirstResponder()
        return true
    }
}
