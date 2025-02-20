//
//  AddReceiptViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 1/31/25.
//

import UIKit

class AddReceiptViewController: UIViewController {
    
    // MARK: - Properties
    
    var image: UIImage?
    private var addReceiptView: AddReceiptView!
    private var receipt: ReceiptResult!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addReceiptView = AddReceiptView(frame: view.bounds)
        addReceiptView.imageView.image = image /// 가져온 사진
        self.view = addReceiptView
        startScanning()
        
        /// 'X' 버튼
        addReceiptView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Functions
    
//    private func startScanning() {
//        addReceiptView.animateScanningBar()
//        addReceiptView.indicator.startAnimating()
//        self.OCRScan(image: self.image ?? UIImage()) 
//        
//        /// 3초 후 스캔 완료
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            self.addReceiptView.indicator.isHidden = true
//            self.addReceiptView.completeIcon.isHidden = false
//            self.addReceiptView.glowView.isHidden = true
//            self.addReceiptView.scanLabel.text = "인식 완료!"
//            
//            /// 인식 완료 화면 2초 보여주고 화면 전환
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                self.scanningCompleted(receipt: self.receipt)
//            }
//        }
//    }
 
    private func scanningCompleted(receipt: ReceiptResult) {
        addReceiptView.stopScanningBarAnimation()
        addReceiptView.indicator.stopAnimating()
        
        /// 영수증 수정 화면으로 전환
        let editReceiptIngredientsVC = EditReceiptIngredientsViewController()
        editReceiptIngredientsVC.receiptResult = receipt
        editReceiptIngredientsVC.modalPresentationStyle = .fullScreen
        present(editReceiptIngredientsVC, animated: true, completion: nil)
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - API 관련
    
//    /// OCR로 영수증 인식 API 연결
//    private func OCRScan(image: UIImage) {
//        let url = "http://3.35.252.162:8080/OCR/receipt"
//        
//        // 이미지 데이터로 변환
//        guard let imageData = image.pngData() else {
//            print("이미지 변환 실패")
//            return
//        }
//        
//        // multipart/form-data 요청
//        APIClient.shared.upload(url: url, imageData: imageData, name: "file") { (result: Result<ReceiptResponse, Error>) in
//            switch result {
//            case .success(let response):
//                print("영수증 등록 성공")
//                self.receipt = response.result
//            case .failure(let error):
//                print("네트워킹 오류: \(error)")
//            }
//        }
//    }
    
    private func startScanning() {
        addReceiptView.animateScanningBar()
        addReceiptView.indicator.startAnimating()
        
        // 이미지가 nil일 경우를 대비하여 안전하게 처리
        guard let scannedImage = self.image else {
            print("이미지가 존재하지 않습니다.")
            return
        }
        
        self.OCRScan(image: scannedImage)
    }

    private func OCRScan(image: UIImage) {
        let url = "http://3.35.252.162:8080/OCR/receipt"
        
        guard let imageData = image.pngData() else {
            print("이미지 변환 실패")
            return
        }
        
        APIClient.shared.upload(url: url, imageData: imageData, name: "file") { (result: Result<ReceiptResponse, Error>) in
            switch result {
            case .success(let response):
                print("영수증 등록 성공")
                self.receipt = response.result
                
                // 스캔 완료 후 UI 업데이트
                DispatchQueue.main.async {
                    self.addReceiptView.indicator.isHidden = true
                    self.addReceiptView.completeIcon.isHidden = false
                    self.addReceiptView.glowView.isHidden = true
                    self.addReceiptView.scanLabel.text = "인식 완료!"
                    
                    // 인식 완료 화면 2초 보여주고 화면 전환
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.scanningCompleted(receipt: self.receipt)
                    }
                }
            case .failure(let error):
                print("네트워킹 오류: \(error.localizedDescription)")
                // 오류 처리를 위한 UI 업데이트
                DispatchQueue.main.async {
                    self.addReceiptView.indicator.isHidden = true
                    self.addReceiptView.scanLabel.text = "인식 실패"
                    // 필요에 따라 다른 UI 처리를 추가할 수 있음
                }
            }
        }
    }
}
