//
//  SignUpViewController.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/20/25.
//

import UIKit

class SignUpFirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = signUpFirstView
    }
    
    // MARK: - Property
    
    private lazy var signUpFirstView: SignUpFirstView = {
        let view = SignUpFirstView()
        view.backButton.addTarget(self, action: #selector(backFunction), for: .touchUpInside)
        view.nextBtn.addTarget(self, action: #selector(handleNextButton), for: .touchUpInside)
        return view
    }()
    
    // MARK: - Functions
    
    @objc private func backFunction() {
        let VC = EmailLoginViewController()
        
        if let window = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = window.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = VC
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
    
    /// 다음 버튼 클릭 시
    @objc private func handleNextButton() {
        guard let name = signUpFirstView.nameTextField.text, !name.isEmpty,
              let email = signUpFirstView.emailTextField.text, !email.isEmpty,
              let password = signUpFirstView.passwordTextField.text, !password.isEmpty else {
            showAlert(message: "모든 필드를 입력해주세요.")
            return
        }
        
        if !isValidEmail(email) {
            showAlert(message: "올바른 이메일 형식을 입력해주세요.")
            return
        }
        
        if !isValidPassword(password) {
            showAlert(message: "비밀번호는 8자 이상, 숫자, 영어 및 특수문자가 포함되어야 합니다.")
            return
        }
        
        let secondViewController = SignUpSecondViewController()
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*?&#])[A-Za-z\\d@$!%*?&#]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegEx).evaluate(with: password)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
