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
        view.kakaoBtn.addTarget(self, action: #selector(loginKakao), for: .touchUpInside)
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
    
    /// 카카오톡 로그인 시도함과 동시에 accessToken과 Nickname을 키체인에 저장합나다. 또한 키체인 저장후 루트뷰를 전환하여 크림앱에 들어갈 수 있도록 합니다.
    @MainActor
    @objc private func loginKakao() {
        LoginService.shared.kakaoLogin { [weak self] result in
            if result {
                self?.changeRootView()
            } else {
                print("카카오 로그인 실패입니다!!!!")
            }
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
}
