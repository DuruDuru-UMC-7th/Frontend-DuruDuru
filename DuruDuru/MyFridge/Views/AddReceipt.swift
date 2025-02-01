//
//  AddReceiptComplete.swift
//  DuruDuru
//
//  Created by 임효진 on 1/31/25.
//

import UIKit
import NVActivityIndicatorView

class AddReceiptView: UIView {
    
    private var scanningAnimation: UIViewPropertyAnimator?
    private var isAnimating = true
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addComponents()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components
    
    var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private var scanningView = UIView().then {
        $0.layer.borderColor = UIColor(hex: 0x00C269).cgColor
        $0.layer.borderWidth = 5
    }
    
    var glowView = UIView().then {
        $0.backgroundColor = UIColor.clear
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.borderWidth = 10
        $0.layer.cornerRadius = 5
        $0.layer.shadowColor = UIColor.white.cgColor
        $0.layer.shadowOpacity = 1
        $0.layer.shadowRadius = 8.4
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.masksToBounds = false
    }
    
    let scanLabel = UILabel().then {
        $0.text = "인식중..."
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 18)
        $0.textColor = .white
    }
    
    let indicator = NVActivityIndicatorView(frame: CGRect(x: (UIScreen.main.bounds.width - 73) / 2, y: UIScreen.main.bounds.height - 173, width: 73, height: 73),
                                            type: .circleStrokeSpin,
                                            color: .white,
                                            padding: 0)
    
    let backButton = UIButton().then {
        $0.setImage(.whiteXButton, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }
    
    var completeIcon = UIImageView().then {
        $0.image = .completeIcon
        $0.contentMode = .scaleAspectFit
        $0.isHidden = true
    }
    
    // MARK: - Constaints & Add Function
    
    func addComponents() {
        addSubview(imageView)
        addSubview(glowView)
        glowView.addSubview(scanningView)
        addSubview(scanLabel)
        addSubview(backButton)
        addSubview(indicator)
        addSubview(completeIcon)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        glowView.snp.makeConstraints {
            $0.width.equalTo(361)
            $0.height.equalTo(5)
            $0.centerX.equalToSuperview()
        }
        
        scanningView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(0.5)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(67)
            $0.right.equalToSuperview().offset(-40)
            $0.width.height.equalTo(24)
        }
        
        scanLabel.snp.makeConstraints {
            $0.centerX.equalTo(indicator)
            $0.bottom.equalTo(indicator.snp.top).offset(-10)
        }
        
        completeIcon.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-100)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Function
    
    func animateScanningBar() {
        if isAnimating {
            
            /// 초기 위치
            scanningView.transform = CGAffineTransform(translationX: 0, y: +100)
            
            /// 애니메이션 설정
            scanningAnimation = UIViewPropertyAnimator(duration: 2.5, curve: .easeInOut) {
                self.scanningView.transform = CGAffineTransform(translationX: 0, y: self.frame.height - 150)
            }
            
            scanningAnimation?.addCompletion { _ in
                UIView.animate(withDuration: 2.5, delay: 0, options: [.curveEaseInOut], animations: {
                    self.scanningView.transform = CGAffineTransform(translationX: 0, y: +100)
                }) { _ in
                    if self.isAnimating {
                        self.animateScanningBar()
                    }
                }
            }
            
            scanningAnimation?.startAnimation()
        }
    }
    
    func stopScanningBarAnimation() {
        print("애니메이션 중지")
        scanningAnimation?.stopAnimation(true)
        isAnimating = false // 애니메이션 상태를 중지로 변경
    }
}
