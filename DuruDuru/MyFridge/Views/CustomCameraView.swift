//
//  CustomCameraView.swift
//  DuruDuru
//
//  Created by 임효진 on 1/31/25.
//

import UIKit

class CustomCameraView: UIView {

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components
    
    let backButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.tintColor = .white
    }
    
    let captureButton = UIButton().then {
        $0.setImage(.shutter, for: .normal)
    }
    
    let albumButton = UIButton().then {
        let configuration = UIButton.Configuration.plain()
        $0.configuration = configuration
        if let albumImage = UIImage(named: "album")?.withRenderingMode(.alwaysTemplate) {
            $0.configuration?.image = albumImage
            $0.tintColor = .white
        }
        $0.configuration?.imagePlacement = .top
        $0.configuration?.imagePadding = 5
        $0.configuration?.attributedTitle = AttributedString("갤러리", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 11)]))
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    }
    
    let tipView = UIView().then {
        $0.backgroundColor = UIColor(hex: 0x171719, alpha: 0.52)
        $0.layer.cornerRadius = 10
    }
    
    private let tipLabel = UILabel().then {
        $0.text = "TIP"
        $0.textColor = .white
        $0.font = .boldSystemFont(ofSize: 14)
    }
    
    private let tipContentLabel = UILabel().then {
        $0.text = "구매 날짜가 잘 보이도록 영수증을 찍어주세요"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 11)
    }
    
    private let tipSubContentLabel = UILabel().then {
        $0.text = "온라인 주문내역을 캡쳐해 업로드 할 수 있어요!"
        $0.textColor = UIColor(hex: 0xA8A8A8)
        $0.font = .systemFont(ofSize: 11)
    }
    
    let tipCloseButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.tintColor = .white
    }

    private let cameraGuide = UIImageView().then {
        $0.image = .guide
    }
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        addSubview(captureButton)
        addSubview(albumButton)
        addSubview(tipView)
        addSubview(cameraGuide)
        addSubview(backButton)
        tipView.addSubview(tipLabel)
        tipView.addSubview(tipContentLabel)
        tipView.addSubview(tipSubContentLabel)
        tipView.addSubview(tipCloseButton)
    }
    
    /// 오토레이아웃 설정
    private func constraints() {
        captureButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(60)
            $0.height.width.equalTo(72)
        }
        
        albumButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(60)
            $0.left.equalToSuperview().offset(36)
        }
        
        tipView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(captureButton.snp.top).offset(-16)
            $0.height.equalTo(54)
            $0.width.equalTo(258)
        }
        
        tipLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
        }
        
        tipContentLabel.snp.makeConstraints {
            $0.left.equalTo(tipLabel.snp.right).offset(8)
            $0.top.equalToSuperview().offset(14)
        }
        
        tipSubContentLabel.snp.makeConstraints {
            $0.left.equalTo(tipLabel.snp.right).offset(8)
            $0.bottom.equalToSuperview().offset(-13)
        }
        
        tipCloseButton.snp.makeConstraints {
            $0.top.right.equalToSuperview().inset(4)
            $0.width.height.equalTo(16)
        }
        
        cameraGuide.snp.makeConstraints {
            $0.bottom.equalTo(tipView.snp.top).offset(-5)
            $0.left.right.equalToSuperview().inset(3)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(67)
            $0.right.equalToSuperview().offset(-16)
            $0.width.height.equalTo(24)
        }
    }
}
