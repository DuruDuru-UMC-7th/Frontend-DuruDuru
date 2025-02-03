//
//  EmailLoginViewController.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/20/25.
//

import UIKit

class EmailLoginViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    
    /// 아이디, 비번 지정 변수
    let userInfo: UserInfo = UserInfo(id: "1234", pwd: "1234")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = loginView
        
        setupDelegate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        /// 이메일 텍스트 필드에 포커스
        loginView.emailTextField.becomeFirstResponder()
    }
    
    /// 커스텀으로 작성한 로그인 뷰
    private lazy var loginView: EmailLoginView = {
        let view = EmailLoginView()
        view.backButton.addTarget(self, action: #selector(backFunction), for: .touchUpInside)
        view.loginBtn.addTarget(self, action: #selector(loginFunction), for: .touchUpInside)
        return view
    }()

    // MARK: - Function
    
    /// delegate
    private func setupDelegate() {
        loginView.emailTextField.delegate = self
        loginView.passwordTextField.delegate = self
    }
    
    //키보드 delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.isEqual(loginView.emailTextField)){ /// emailTextField에서 리턴 누르면
            loginView.passwordTextField.becomeFirstResponder() /// passwordTextField로 포커스 이동
        }
        endEdit()
        return true
    }
    
    func endEdit(){
        loginView.passwordTextField.resignFirstResponder()//키보드 숨기기
    }
    
    /// 데이터 모델에 지정한 아이디, 비밀번호에 해당 할 경우 로그인 가능하도록 하는 함수
    @objc private func loginFunction() {
        guard let inputId = loginView.emailTextField.text,
              let inputPwd = loginView.passwordTextField.text,
              !inputId.isEmpty, !inputPwd.isEmpty else {
            print("아이디와 비밀번호를 입력해주세요")
            return
        }
        
        if let storedUserInfo = UserInfo.loadUserDefaults() {
            if storedUserInfo.id == inputId && storedUserInfo.pwd == inputPwd {
                print("기존 사용자 로그인 성공")
                changeRootView()
            } else {
                print("아이디 또는 비밀번호 불일치")
            }
        } else {
            let newUserInfo = UserInfo(id: inputId, pwd: inputPwd)
            newUserInfo.saveUserDefaults()
            print("아이디 비밀번호 새롭게 갱신 및 로그인 성공")
            changeRootView()
        }
    }
    
    /// 로그인 뷰 -> TabBarController 루트 뷰 전환 함수
    private func changeRootView() {
        let rootVC = MainTabBarController()
        
        if let window = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = window.delegate as? SceneDelegate, let window = sceneDelegate.window {
            window.rootViewController = rootVC
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
    
    /// 뒤로가기 함수
    @objc private func backFunction() {
        let VC = LoginViewController()
        
        if let window = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = window.delegate as? SceneDelegate, let window = sceneDelegate.window {
            window.rootViewController = VC
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}
