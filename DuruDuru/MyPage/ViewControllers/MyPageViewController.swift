//
//  MyPageViewController.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/8/25.
//

import UIKit

class MyPageViewController: UIViewController {
    
    private var myPageView: MyPageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        myPageView = MyPageView(frame: self.view.bounds)
        self.view = myPageView
        
        /// 마이페이지 제목
        let myPage = UILabel().then {
            $0.text = "마이페이지"
            $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            $0.textColor = .black
            $0.sizeToFit()
        }
        
        let titleButtonItem = UIBarButtonItem(customView: myPage)
        self.navigationItem.leftBarButtonItem = titleButtonItem
        
        /// 설정 버튼
        let settingButton = UIBarButtonItem(image: .setting, style: .plain, target: self, action: #selector(settingButtonTapped))
        settingButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = settingButton
    }
    
    @objc func settingButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
