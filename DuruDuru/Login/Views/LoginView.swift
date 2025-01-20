//
//  LoginView.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/4/25.
//

import UIKit


/// Hex 값을 UIColor로 변환
extension UIColor {
    convenience init?(hex: Int?, alpha: CGFloat = 1.0) {
        guard let hex = hex else {
            return nil
        }
        let red = CGFloat((hex >> 16) & 0xFF) / 255.0
        let green = CGFloat((hex >> 8) & 0xFF) / 255.0
        let blue = CGFloat(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}


class LoginView: UIView {

    // MARK: -Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addComponents()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: -Property
    
    /// 배경 이미지
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LoginBackground")
        imageView.contentMode = .scaleAspectFill // 이미지가 전체를 덮음
        imageView.clipsToBounds = true
        return imageView
    }()
    
    /// 5초 가입 말풍선
    private lazy var balloonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Balloon")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    /// 5초 가입 라벨
    private lazy var balloonLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.text = "5초만에 간편하게 가입하기!"
        return label
    }()
    
    
    /// 카카오로 계속하기 버튼
    public lazy var kakaoBtn = continueButton(title: "카카오로 계속하기", titleColorHex: 0x3B1F1E, backgroundColorHex: 0xFAE301, borderColorHex: 0xFAE301, imageName: "KakaoLogo")
    
    /// 네이버로 계속하기 버튼
    public lazy var naverBtn = continueButton(title: "네이버로 계속하기", titleColorHex: 0xFFFFFF, backgroundColorHex: 0x1DC800, borderColorHex: 0x1DC800, imageName: "NaverLogo")
    
    /// Apple로 계속하기 버튼
    public lazy var appleBtn = continueButton(title: "Apple로 계속하기", titleColorHex: 0x3B1F1E, backgroundColorHex: 0xFFFFFF, borderColorHex: 0xFFFFFF, imageName: "AppleLogo")
    
    /// 이메일로 계속하기 버튼(투명)
    public lazy var emailBtn = continueButton(title: "이메일로 계속하기", titleColorHex: 0xFFFFFF, backgroundColorHex: nil, borderColorHex: 0xFFFFFF, imageName: "EmailLogo")
    
    
    
    // MARK: MakeFunction
    
    /// 계속하기 버튼
    private func continueButton(
        title: String,
        titleColorHex: Int?,
        backgroundColorHex: Int?,
        borderColorHex: Int?,
        imageName: String?
    ) -> UIButton {
        let btn = UIButton()
        
        // 버튼 제목
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        // 제목 색깔 (Hex값 또는 기본값)
        if let titleColorHex = titleColorHex {
            btn.setTitleColor(UIColor(hex: titleColorHex), for: .normal)
        } else {
            btn.setTitleColor(.white, for: .normal)
        }
        
        // 배경 색깔 (Hex값 또는 .clear)
        if let backgroundColorHex = backgroundColorHex {
            btn.backgroundColor = UIColor(hex: backgroundColorHex)
        } else {
            btn.backgroundColor = .clear
        }
        
        // 테두리 색깔
        if let borderColorHex = borderColorHex {
            btn.layer.borderColor = UIColor(hex: borderColorHex)?.cgColor
            btn.layer.borderWidth = 1.0
        }
        
        // 이미지 추가 (왼쪽)
        if let imageName = imageName, let image = UIImage(named: imageName) {
            btn.setImage(image, for: .normal)
            
            // 이미지와 텍스트 간의 간격 조정
            btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8) // 이미지의 위치
            btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8) // 텍스트의 위치
        }
        
        // 패딩 조정
        btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        
        // 모서리 둥글둥글
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 8
        
        return btn
    }
    
    
    
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        self.addSubview(backgroundImageView) //젤 위에 와야함 (배경 먼저 깔고 -> 아래 버튼 까는거임)
        self.addSubview(balloonImageView)
        self.addSubview(balloonLabel)
        self.addSubview(kakaoBtn)
        self.addSubview(naverBtn)
        self.addSubview(appleBtn)
        self.addSubview(emailBtn)
    }
    
    /// 오토레이아웃 설정
    private func constraints(){
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        balloonImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(488)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(221)
            $0.height.equalTo(51.3)
        }
        
        balloonLabel.snp.makeConstraints {
            $0.top.equalTo(balloonImageView.snp.top).offset(9.15)
            $0.left.equalTo(balloonImageView.snp.left).offset(33)
            $0.width.greaterThanOrEqualTo(153)
            $0.height.equalTo(22)
        }
        
        kakaoBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(542)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(361)
            $0.height.equalTo(47)
        }
        
        naverBtn.snp.makeConstraints {
            $0.top.equalTo(kakaoBtn.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(361)
            $0.height.equalTo(47)
        }
        
        appleBtn.snp.makeConstraints {
            $0.top.equalTo(naverBtn.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(361)
            $0.height.equalTo(47)
        }
        
        emailBtn.snp.makeConstraints {
            $0.top.equalTo(appleBtn.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(361)
            $0.height.equalTo(47)
        }
    }

}
