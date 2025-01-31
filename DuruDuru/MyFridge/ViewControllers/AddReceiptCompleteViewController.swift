//
//  AddReceiptViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 1/31/25.
//

import UIKit

class : UIViewController {
    
    var image: UIImage?
    private var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 뷰가 화면에 나타날 때 자동으로 스캔 시작
        startScanning()
    }
    
    private func setupImageView() {
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        view.addSubview(imageView)
    }
    
    private func startScanning() {
        // 애니메이션 시작
        let scanningView = UIView(frame: imageView.bounds)
        scanningView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        scanningView.alpha = 0
        imageView.addSubview(scanningView)
        
        // 애니메이션
        UIView.animate(withDuration: 1.5, animations: {
            scanningView.alpha = 1
        }) { _ in
            // 스캔 완료 후 새로운 뷰 컨트롤러로 이동
            self.scanningCompleted()
        }
    }
    
    private func scanningCompleted() {
        // 스캔 결과를 보여줄 새로운 뷰 컨트롤러 생성
        let scanResultVC = ScanResultViewController()
        // 필요한 데이터 전달
        // scanResultVC.scannedData = ...
        
        // 새로운 뷰 컨트롤러로 이동
        navigationController?.pushViewController(scanResultVC, animated: true)
    }
}
