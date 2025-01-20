//
//  SingUpThirdView.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/11/25.
//

import UIKit

class SignUpThirdView: UIView {
    
    // MARK: - Init
    
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
    
    /// 뒤로가기
    public lazy var backImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Left")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    /// "회원가입" 라벨
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.text = "회원가입"
        return label
    }()
    
    /// 경계선
    private lazy var borderLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0x00C269)
        return view
    }()
    
    /// 환영합니다 라벨 이미지
    private lazy var welcomeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "WelcomeLabel")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    
    
    
    
    
    /// 약관동의 경계선
    private lazy var bottomBorderLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray/*.withAlphaComponent(0.5)*/
        return view
    }()
    
    
    
    
    
    
    /// 두루두루 시작하기 버튼
    public lazy var startBtn: UIButton = {
        let btn = UIButton()
        
        // 버튼 제목
        btn.setTitle("두루두루 시작하기", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        btn.setTitleColor(.white, for: .normal)
        
        // 배경 색깔 (Hex값)
        btn.backgroundColor = UIColor(hex: 0x00C269)
        
        // 테두리 색깔
        btn.layer.borderColor = UIColor(hex: 0x00C269)?.cgColor
        btn.layer.borderWidth = 1.0
        
        // 모서리 둥글둥글
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 8
        
        return btn
    }()
    
    
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        self.addSubview(backImage)
        self.addSubview(titleLabel)
        self.addSubview(borderLine)
        self.addSubview(welcomeImage)
        
        
        self.addSubview(bottomBorderLine)
        
        self.addSubview(startBtn)
    }
    
    /// 오토레이아웃 설정
    private func constraints(){
        backImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(95)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(95)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(115)
            $0.height.equalTo(22)
        }
        
        borderLine.snp.makeConstraints {
            $0.top.equalTo(backImage.snp.bottom).offset(9)
            $0.left.equalToSuperview()
            $0.width.equalTo(402)
            $0.height.equalTo(2)
        }
        
        welcomeImage.snp.makeConstraints {
            $0.top.equalTo(borderLine.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(371)
            $0.height.equalTo(182)
        }
        
        
        
        bottomBorderLine.snp.makeConstraints {
            $0.top.equalTo(welcomeImage.snp.bottom).offset(381)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(370)
            $0.height.equalTo(1)
        }
        
        
        
        startBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(787)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(370)
            $0.height.equalTo(47)
        }
    }
}
