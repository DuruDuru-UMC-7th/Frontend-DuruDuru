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
        
        /// 3초 후 스캔 완료
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.addReceiptView.indicator.isHidden = true
            self.addReceiptView.completeIcon.isHidden = false
            self.addReceiptView.glowView.isHidden = true
            self.addReceiptView.scanLabel.text = "인식 완료!"
            self.OCRScan(memberId: 5, image: self.image ?? UIImage())
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.scanningCompleted()
                print("3초 지남")
            }
        }
    }
 
    private func scanningCompleted() {
        addReceiptView.stopScanningBarAnimation()
        addReceiptView.indicator.stopAnimating()
        let editReceiptIngredientsVC = EditReceiptIngredientsViewController()
//        editReceiptIngredientsVC.responseReceiptIngredientsModel = response
        editReceiptIngredientsVC.modalPresentationStyle = .fullScreen
        present(editReceiptIngredientsVC, animated: true, completion: nil)
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    /// API 관련
    private func OCRScan(memberId: Int, image: UIImage) {
        let url = "http://3.35.252.162:8080/OCR/receipt"
        
        // 파라미터 설정
        let parameters: [String: Any] = ["membetId": memberId]
        
        // 이미지 데이터로 변환
        guard let imageData = image.pngData() else {
            print("이미지 변환 실패")
            return
        }
        
        // multipart/form-data 요청
        APIClient.shared.upload(url: url, memberId: memberId, imageData: imageData) { (result: Result<ResponseReceiptIngredientsModel, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                    self.scanningCompleted(response)
                }
            case .failure(let error):
                print("네트워킹 오류: \(error)")
            }
        }
    }
}
