//
//  LoginViewViewController.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/8/25.
//

import UIKit

class LoginViewController: UIViewController {

    // LoginView를 소유하고 초기화
    private var loginView: LoginView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // LoginView 초기화 및 화면에 추가
        loginView = LoginView(frame: self.view.bounds)
        self.view.addSubview(loginView)
    }
}
