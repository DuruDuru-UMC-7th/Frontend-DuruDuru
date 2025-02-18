//
//  UIViewControllerAlert.swift
//  DuruDuru
//
//  Created by 이은찬 on 2/18/25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String = "알림", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
