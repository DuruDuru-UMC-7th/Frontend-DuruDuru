//
//  EmailLoginView.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/8/25.
//

import UIKit

class EmailLoginView: UIView {
    
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
    
    /// 뒤로가기
    public lazy var backImage: UIImageView = imageView(name: "Back")
    
    /// "이메일로 계속하기" 라벨
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.text = "이메일로 계속하기"
        return label
    }()
    
    /// Logo 그림
    private lazy var logoImage: UIImageView = imageView(name: "Logo")
    
    /// 이메일 입력 텍스트필드
    public lazy var emailTextField: UITextField = textField(text: "이메일을 입력하세요")
    
    /// 비밀번호 입력 텍스트필드 -> 눈알 구현해야함
    public lazy var passwordTextField: UITextField = textField(text: "비밀번호를 입력하세요")
    
    /// 계정 찾기/비밀번호 찾기
    private lazy var searchLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        label.text = "계정 찾기 · 비밀번호 찾기"
        return label
    }()
    
    /// 아직 회원이 아니신가요? 라벨
    private lazy var notMemberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        label.text = "아직 회원이 아니신가요?"
        return label
    }()
    
    /// 회원가입(초록색) 라벨 -> 눌리도록 만들어야함
    private lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: 0x00C269)
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        label.text = "회원가입"
        return label
    }()
    
    /// 로그인하기 버튼
    public lazy var loginBtn: UIButton = {
        let btn = UIButton()
        
        // 버튼 제목
        btn.setTitle("로그인하기", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        btn.setTitleColor(.white, for: .normal)
        
        // 배경 색깔 (Hex값)
        btn.backgroundColor = UIColor(hex: 0x272727)
        
        // 테두리 색깔
        btn.layer.borderColor = UIColor(hex: 0x272727)?.cgColor
        btn.layer.borderWidth = 1.0
        
        // 모서리 둥글둥글
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 8
        
        return btn
    }()
    
    
    
    // MARK: - MakeFunction
    
    /// 이미지뷰 함수
    private func imageView(name: String) -> UIImageView {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: name)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }
    
    /// 텍스트필드 함수
    private func textField(text: String) -> UITextField {
        let textField = UITextField()
        
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 1))
        
        // placeholder 텍스트 속성 설정
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 14) // 글씨 크기
        ]
        textField.attributedPlaceholder = NSAttributedString(string: text, attributes: placeholderAttributes)
        
        // 테두리
        textField.layer.cornerRadius = 8  // 둥글게 만드는 속성
        textField.layer.borderWidth = 1    // 테두리 두께
        textField.layer.borderColor = UIColor(hex: 0xBEBEBE)?.cgColor // 테두리 색상
        textField.clipsToBounds = true  // 모서리가 잘리도록 설정
        
        return textField
    }
    
    
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        self.addSubview(backImage)
        self.addSubview(titleLabel)
        self.addSubview(logoImage)
        self.addSubview(emailTextField)
        self.addSubview(passwordTextField)
        self.addSubview(searchLabel)
        self.addSubview(notMemberLabel)
        self.addSubview(signUpLabel)
        self.addSubview(loginBtn)
    }
    
    /// 오토레이아웃 설정
    private func constraints(){
        backImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(57)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(7)
            $0.height.equalTo(14)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(53)
            $0.left.equalTo(backImage.snp.right).offset(117)
            $0.width.equalTo(115)
            $0.height.equalTo(22)
        }
        
        logoImage.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(176)
            $0.left.equalToSuperview().offset(123.98)
            $0.width.equalTo(143.54)
            $0.height.equalTo(42.39)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom).offset(55.61)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(361)
            $0.height.equalTo(52)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(22)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(361)
            $0.height.equalTo(52)
        }
        
        searchLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(22)
            $0.left.equalToSuperview().offset(248)
            $0.width.greaterThanOrEqualTo(129)
            $0.height.equalTo(22)
        }
        
        notMemberLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(257)
            $0.left.equalToSuperview().offset(110)
            $0.width.greaterThanOrEqualTo(130)
            $0.height.equalTo(22)
        }
        
        signUpLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(257)
            $0.left.equalTo(notMemberLabel.snp.right)
            $0.width.greaterThanOrEqualTo(34)
            $0.height.equalTo(22)
        }
        
        loginBtn.snp.makeConstraints {
            $0.top.equalTo(signUpLabel.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(361)
            $0.height.equalTo(47)
        }
        
    }
}
