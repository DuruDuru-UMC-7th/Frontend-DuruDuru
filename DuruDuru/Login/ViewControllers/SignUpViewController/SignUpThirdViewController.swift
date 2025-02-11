//
//  SignUpThirdViewController.swift
//  DuruDuru
//
//  Created by 이은찬 on 2/11/25.
//

import UIKit

class SignUpThirdViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = signUpThirdView
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
