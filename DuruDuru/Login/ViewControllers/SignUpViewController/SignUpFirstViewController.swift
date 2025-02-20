//
//  SignUpViewController.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/20/25.
//

import UIKit

class SignUpFirstViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Property
    private lazy var signUpFirstView: SignUpFirstView = {
        let view = SignUpFirstView()
        view.backButton.addTarget(self, action: #selector(backFunction), for: .touchUpInside)
        view.nextBtn.addTarget(self, action: #selector(handleNextButton), for: .touchUpInside)
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = signUpFirstView
        
        // 텍스트필드 delegate 설정
        signUpFirstView.nameTextField.delegate = self
        signUpFirstView.emailTextField.delegate = self
        signUpFirstView.passwordTextField.delegate = self
    }
    
    // MARK: - Functions
    
    @objc private func backFunction() {
        let vc = EmailLoginViewController()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = vc
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
    }
    
    /// 다음 버튼 클릭 시 회원가입 API 호출 후 결과에 따라 화면 전환 또는 에러 Alert 표시
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
        
        // 회원가입 API 호출
        SignUpService.shared.signUp(nickname: name, email: email, password: password) { [weak self] success, message in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if success {
                    print("회원가입 API 호출 성공")
                    let thirdVC = SignUpThirdViewController()
                    thirdVC.nickName = self.signUpFirstView.nameTextField.text! 
                    // 네비게이션 컨트롤러가 있다면 push, 없다면 모달로 전환
                    if let nav = self.navigationController {
                        nav.pushViewController(thirdVC, animated: true)
                    } else {
                        thirdVC.modalPresentationStyle = .fullScreen
                        self.present(thirdVC, animated: true, completion: nil)
                    }
                } else {
                    print("회원가입 API 호출 실패 - 메시지: \(message ?? "알 수 없는 오류")")
                    self.showAlert(message: message ?? "회원가입에 실패했습니다.")
                }
            }
        }
    }
    
    // MARK: - 유효성 검사
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*?&#])[A-Za-z\\d@$!%*?&#]{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: password)
    }
    
    // MARK: - Alert
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - UITextField Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 이름 텍스트필드이면 이메일 텍스트필드로 포커스 이동
        if textField == signUpFirstView.nameTextField {
            signUpFirstView.emailTextField.becomeFirstResponder()
        }
        // 이메일 텍스트필드이면 비밀번호 텍스트필드로 포커스 이동
        else if textField == signUpFirstView.emailTextField {
            signUpFirstView.passwordTextField.becomeFirstResponder()
        }
        // 비밀번호 텍스트필드이면 키보드 내리기
        else if textField == signUpFirstView.passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}
