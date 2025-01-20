//
//  InputTextfield.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/20/25.
//

//import UIKit
//
//class InputTextfield: UITextField {
//    
//    
//
//    override init (frame: CGRect) {
//        super.init(frame: frame)
//        self.rightView = eyeBtn
//        self.rightViewMode = .always
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private var eyeBtn: UIButton = {
//        
//        var btn = UIButton()
//        
//        btn.addAction(UIAction(handler: { [weak btn] _ in
//            guard let button = btn else { return }
//            let currentImage = button.image(for: .normal)
//            let newImage = (currentImage == UIImage(named: "PWHidden")) ? UIImage(named: "PWShown") : UIImage(named: "PWHidden")
//            button.setImage(newImage, for: .normal)
//        }), for: .touchUpInside)
//        
//        var confiuration = UIButton.Configuration.plain()
//        confiuration.imagePadding = 10
//        confiuration.baseBackgroundColor = .clear
//        
//        btn.setImage(UIImage(named: "PWHidden"), for: .normal)
//        
//        btn.configuration = confiuration
//        
//        return btn
//    }()
//}

import UIKit

class InputTextfield: UITextField {
    
    // 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTextField()
        self.isSecureTextEntry = true // 비밀번호 숨기기 기본값 설정
        self.rightView = eyeBtn
        self.rightViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 테두리 및 스타일 설정
    private func configureTextField() {
        self.layer.cornerRadius = 8 // 둥근 테두리
        self.layer.borderWidth = 1 // 테두리 두께
        self.layer.borderColor = UIColor(hex: 0xBEBEBE)?.cgColor // 테두리 색상
        self.clipsToBounds = true
        
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 1)) // 여백 추가
        
        // Placeholder 설정
        let placeholderText = "비밀번호를 입력하세요 (8자 이상)"
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 14) // 글씨 크기
        ]
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: placeholderAttributes)
    }
    
    // 눈 모양 버튼 (비밀번호 보이기/숨기기)
    private lazy var eyeBtn: UIButton = {
        let btn = UIButton()
        
        btn.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            
            // 현재 이미지에 따라 동작 변경
            let currentImage = btn.image(for: .normal)
            if currentImage == UIImage(named: "PWHidden") {
                btn.setImage(UIImage(named: "PWShown"), for: .normal)
                self.isSecureTextEntry = false // 비밀번호 보이기
            } else {
                btn.setImage(UIImage(named: "PWHidden"), for: .normal)
                self.isSecureTextEntry = true // 비밀번호 숨기기
            }
        }), for: .touchUpInside)
        
        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = 10
        configuration.baseBackgroundColor = .clear
        
        btn.setImage(UIImage(named: "PWHidden"), for: .normal) // 초기 이미지는 PWHidden
        btn.configuration = configuration
        
        return btn
    }()
}
