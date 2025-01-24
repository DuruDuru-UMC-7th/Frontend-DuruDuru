//
//  ExchangeDetailViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 1/24/25.
//

import UIKit

class ExchangeDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 뒤로 가기 버튼
        let backImage = UIImage(named: "Arrow3")
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
        backButton.tintColor = .black
        
        view.backgroundColor = .white
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    let label = UILabel().then {
        $0.text = "품앗이 상세페이지"
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

}
