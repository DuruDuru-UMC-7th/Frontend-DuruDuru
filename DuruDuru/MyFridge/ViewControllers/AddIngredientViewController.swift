//
//  AddIngredientViewController.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/19/25.
//

import UIKit

class AddIngredientViewController: UIViewController, UITextFieldDelegate {

    
    private let addIngredientView = AddIngredientView()

    private var quantity: Int = 0
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = addIngredientView
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
        addIngredientView.minusButton.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
        addIngredientView.plusButton.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
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
        addIngredientView.quantityValueLabel.text = "\(quantity)"
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
