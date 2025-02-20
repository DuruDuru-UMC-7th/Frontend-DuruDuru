//
//  SignUpThirdViewController.swift
//  DuruDuru
//
//  Created by 이은찬 on 2/11/25.
//

import UIKit

class SignUpThirdViewController: UIViewController {
    
    var nickName: String = "길동"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = signUpThirdView
        signUpThirdView.nickName.text = "\(nickName)님을 환영해요!"
    }
    
    // MARK: - Property
    private lazy var signUpThirdView: SignUpThirdView = {
        let view = SignUpThirdView()
        view.backButton.addTarget(self, action: #selector(backFunction), for: .touchUpInside)
        return view
    }()
    
    // MARK: - Functions
    @objc private func backFunction() {
        navigationController?.popViewController(animated: true)
    }
}
