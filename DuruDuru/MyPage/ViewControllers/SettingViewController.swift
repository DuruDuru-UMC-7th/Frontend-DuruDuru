//
//  SettingViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 1/28/25.
//

import UIKit

class SettingViewController: UIViewController {
    
    private var settingView: SettingView!

    override func viewDidLoad() {
        super.viewDidLoad()
        settingView = SettingView(frame: self.view.bounds)
        self.view = settingView
        
        // 뒤로 가기 버튼
        let backImage = UIImage(systemName: "chevron.left")
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
        backButton.tintColor = .black

        self.title = "설정"
        
        // 로그아웃 레이블에 탭 제스처 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(logOutLabelTapped))
        settingView.logOutLabel.isUserInteractionEnabled = true
        settingView.logOutLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func logOutLabelTapped() {
        // 카카오 로그아웃 호출
        KakaoLoginManager.shared.logout { [weak self] success in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if success {
                    print("카카오 로그아웃 성공")
                    self.changeRootToLogin()
                } else {
                    print("카카오 로그아웃 실패")
                    self.showAlert(message: "로그아웃에 실패했습니다.")
                }
            }
        }
    }
    
    private func changeRootToLogin() {
        let loginVC = LoginViewController()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = loginVC
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
    }
}
