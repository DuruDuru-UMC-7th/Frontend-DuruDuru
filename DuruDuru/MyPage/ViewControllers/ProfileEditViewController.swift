//
//  ProfileEditViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 1/28/25.
//

import UIKit

class ProfileEditViewController: UIViewController {
    
    private var profileEditView: ProfileEditView!

    override func viewDidLoad() {
        super.viewDidLoad()
        profileEditView = ProfileEditView(frame: self.view.bounds)
        self.view = profileEditView

        /// 뒤로 가기 버튼
        let backImage = UIImage(named: "Arrow3")
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
        backButton.tintColor = .black

        self.title = "프로필 편집"
        
        /// 완료 버튼
        let completeButton = UIButton().then {
            $0.setTitle("완료", for: .normal)
            $0.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            $0.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
            $0.sizeToFit()
        }
        let completeBarButtonItem = UIBarButtonItem(customView: completeButton)
        self.navigationItem.rightBarButtonItem = completeBarButtonItem
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func completeButtonTapped() {
        print("완료 버튼 클릭")
    }
}
