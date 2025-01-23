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

        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    let label = UILabel().then {
        $0.text = "품앗이 상세페이지"
    }

}
