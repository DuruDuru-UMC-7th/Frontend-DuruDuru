//
//  SignUpSecondViewController.swift
//  DuruDuru
//
//  Created by 이은찬 on 2/11/25.
//

import UIKit

class SignUpSecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = signUpSecondView
    }
    
    // MARK: - Property
    
    private lazy var signUpSecondView: SignUpSecondView = {
        let view = SignUpSecondView()
        view.backButton.addTarget(self, action: #selector(backFunction), for: .touchUpInside)
        view.nextBtn.addTarget(self, action: #selector(handleNextButton), for: .touchUpInside)
        return view
    }()
    
    // MARK: - Functions
    
    @objc private func backFunction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleNextButton() {
        guard let phone = signUpSecondView.phoneTextField.text, !phone.isEmpty else {
            showAlert(message: "전화번호를 입력해주세요.")
            return
        }
        
        let thirdViewController = SignUpThirdViewController()
        navigationController?.pushViewController(thirdViewController, animated: true)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
