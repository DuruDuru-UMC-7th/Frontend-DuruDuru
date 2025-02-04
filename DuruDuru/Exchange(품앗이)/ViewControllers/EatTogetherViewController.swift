//
//  EatTogetherViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 1/23/25.
//

import UIKit

class EatTogetherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    let label = UILabel().then {
        $0.text = "함께 먹자"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
