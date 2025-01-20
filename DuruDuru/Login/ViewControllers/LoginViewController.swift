//
//  LoginViewViewController.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/8/25.
//

import UIKit

class LoginViewController: UIViewController {

    // 앱 실행 단계
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = loginView
    }
    
    // MARK: - Property
    
    // 커스텀으로 작성한 로그인 뷰
    private lazy var loginView: LoginView = {
        let view = LoginView()
        view.emailBtn.addTarget(self, action: #selector(loginEmail), for: .touchUpInside)
        return view
    }()
    
    // MARK: - Actions
    
//    @objc private func loginEmail() {
//        let emailViewController = EmailLoginViewController()
//        emailViewController.modalPresentationStyle = .fullScreen // 전체 화면 전환 (옵션)
//        self.present(emailViewController, animated: true, completion: nil) // 화면 전환
//    }
    
    @objc private func loginEmail() {
        let rootVC = EmailLoginViewController()
        
        if let window = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = window.delegate as? SceneDelegate, let window = sceneDelegate.window {
            window.rootViewController = rootVC
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}
