//
//  OnBoardingViewController.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/20/25.
//

import UIKit

class OnBoardingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // OnBoardingView 인스턴스 생성
        let onboardingView = OnBoardingView()
        
        // OnBoardingView 추가 및 레이아웃 설정
        view.addSubview(onboardingView)
        onboardingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            onboardingView.topAnchor.constraint(equalTo: view.topAnchor),
            onboardingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            onboardingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // 2초 후 LoginViewController로 전환
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.navigateToLogin()
        }
    }
    
    private func navigateToLogin() {
        let loginVC = LoginViewController()
        loginVC.modalTransitionStyle = .crossDissolve
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
    }
}
