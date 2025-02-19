//
//  EmailLoginViewController.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/20/25.
//

import UIKit

class EmailLoginViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = loginView
        setupDelegate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loginView.emailTextField.becomeFirstResponder()
    }
    
    private lazy var loginView: EmailLoginView = {
        let view = EmailLoginView()
        view.backButton.addTarget(self, action: #selector(backFunction), for: .touchUpInside)
        view.loginBtn.addTarget(self, action: #selector(loginFunction), for: .touchUpInside)
        view.signUpButton.addTarget(self, action: #selector(toSignUpFunction), for: .touchUpInside)
        return view
    }()
    
    private func setupDelegate() {
        loginView.emailTextField.delegate = self
        loginView.passwordTextField.delegate = self
    }
    
    // MARK: - UITextField Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 만약 이메일 텍스트필드라면 비밀번호 텍스트필드로 포커스 이동
        if textField == loginView.emailTextField {
            loginView.passwordTextField.becomeFirstResponder()
        } else {
            // 비밀번호 텍스트필드인 경우 키보드 내리기
            loginView.passwordTextField.resignFirstResponder()
        }
        return true
    }
    
    // MARK: - 로그인 API 연결
    @objc private func loginFunction() {
        guard let email = loginView.emailTextField.text, !email.isEmpty,
              let password = loginView.passwordTextField.text, !password.isEmpty else {
            print("아이디와 비밀번호를 입력해주세요")
            showAlert(message: "아이디와 비밀번호를 입력해주세요")
            return
        }
        
        print("입력한 이메일: \(email), 비밀번호: \(password)")
        
        // 로그인 API 호출 (Alamofire 사용)
        EmailLoginService.shared.login(email: email, password: password) { [weak self] success, message in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if success {
                    print("로그인 API 호출 성공")
                    self.changeRootView()
                } else {
                    print("로그인 API 호출 실패 - 메시지: \(message ?? "알 수 없는 오류")")
                    self.showAlert(message: message ?? "로그인에 실패했습니다.")
                }
            }
        }
    }
    
    private func changeRootView() {
        let rootVC = MainTabBarController()
        if let window = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = window.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = rootVC
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
    }
    
    @objc private func backFunction() {
        let vc = LoginViewController()
        if let window = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = window.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = vc
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
    }
    
    @objc private func toSignUpFunction() {
        let vc = SignUpFirstViewController()
        if let window = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = window.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = vc
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
