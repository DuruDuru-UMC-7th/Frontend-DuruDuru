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
        
        /// 뒤로 가기 버튼
        let backImage = UIImage(named: "Arrow3")
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
        backButton.tintColor = .black

        self.title = "설정"
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
