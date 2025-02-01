//
//  AddReceiptViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 1/31/25.
//

import UIKit

class AddReceiptViewController: UIViewController {
    
    var image: UIImage?
    private var addReceiptView: AddReceiptView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addReceiptView = AddReceiptView(frame: view.bounds)
        addReceiptView.imageView.image = image
        self.view = addReceiptView
        startScanning()
        
        addReceiptView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func startScanning() {
        addReceiptView.animateScanningBar()
        addReceiptView.indicator.startAnimating()
        
        /// 5초 후 스캔 완료
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.addReceiptView.indicator.isHidden = true
            self.addReceiptView.completeIcon.isHidden = false
            self.addReceiptView.glowView.isHidden = true
            self.addReceiptView.scanLabel.text = "인식 완료!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.scanningCompleted()
            }
        }
    }
    
    private func scanningCompleted() {
        addReceiptView.stopScanningBarAnimation()
        addReceiptView.indicator.stopAnimating()
        let editReceiptIngredientsVC = EditReceiptIngredientsViewController()
        editReceiptIngredientsVC.modalPresentationStyle = .fullScreen
        present(editReceiptIngredientsVC, animated: true, completion: nil)
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
