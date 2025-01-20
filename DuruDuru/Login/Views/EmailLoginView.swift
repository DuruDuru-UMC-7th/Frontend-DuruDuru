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
    public lazy var backImage: UIImageView = imageView(name: "Left")
    
    /// "이메일로 계속하기" 라벨
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.text = "로그인"
        return label
    }()
    
    /// 이메일 라벨
    private lazy var emailLabel: UILabel = makeLabel(title: "이메일")
    
    /// 이메일 입력 텍스트필드
    public lazy var emailTextField: UITextField = textField(text: "이메일을 입력하세요")
    
    /// 비밀번호 라벨
    private lazy var passwordLabel: UILabel = makeLabel(title: "비밀번호")
    
    /// 비밀번호 입력 텍스트필드 -> 눈알 구현해야함
    public lazy var passwordTextField: UITextField = textField(text: "비밀번호를 입력하세요")

    
    /// 아직 회원이 아니신가요? 라벨
    private lazy var notMemberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        label.text = "아직 회원이 아니신가요?"
        return label
    }()
    
    /// 회원가입(초록색) 버튼 -> 텍스트만 보이도록 설정
    private lazy var signUpButton: UIButton = {
        var config = UIButton.Configuration.plain() // plain 스타일 사용
        config.title = "회원가입" // 버튼 텍스트
        config.titleAlignment = .center
        config.baseForegroundColor = UIColor(hex: 0x00C269) // 텍스트 색상
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var attributes = incoming
            attributes.font = UIFont.systemFont(ofSize: 13, weight: .regular) // 텍스트 폰트
            return attributes
        }

        let button = UIButton(configuration: config)
        return button
    }()
    
    /// 계정 찾기/비밀번호 찾기
    private lazy var searchLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        label.text = "아이디 찾기 · 비밀번호 찾기"
        return label
    }()
    
    /// 로그인하기 버튼
    public lazy var loginBtn: UIButton = {
        let btn = UIButton()
        
        // 버튼 제목
        btn.setTitle("로그인", for: .normal)
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
    

    
    // MARK: - MakeFunction
    
    /// 라벨 함수(이메일, 비밀번호)
    private func makeLabel(title: String) -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .left
        label.text = title
        return label
    }
    
    
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        self.addSubview(backImage)
        self.addSubview(titleLabel)
        self.addSubview(emailLabel)
        self.addSubview(emailTextField)
        self.addSubview(passwordLabel)
        self.addSubview(passwordTextField)
        self.addSubview(notMemberLabel)
        self.addSubview(signUpButton)
        self.addSubview(searchLabel)
        self.addSubview(loginBtn)
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
        
        emailLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(196.5)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(370)
            $0.height.equalTo(22)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(370)
            $0.height.equalTo(52)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(32)
            $0.left.equalToSuperview().offset(16)
            $0.width.greaterThanOrEqualTo(130)
            $0.height.equalTo(22)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(370)
            $0.height.equalTo(52)
        }
        
        notMemberLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(197)
            $0.left.equalToSuperview().offset(102)
            $0.width.greaterThanOrEqualTo(130)
            $0.height.equalTo(22)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(197)
            $0.left.equalTo(notMemberLabel.snp.right)
            $0.width.greaterThanOrEqualTo(34)
            $0.height.equalTo(22)
        }
        
        searchLabel.snp.makeConstraints {
            $0.top.equalTo(notMemberLabel.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.greaterThanOrEqualTo(200)
            $0.height.equalTo(22)
        }
        
        loginBtn.snp.makeConstraints {
            $0.top.equalTo(searchLabel.snp.bottom).offset(22)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(370)
            $0.height.equalTo(47)
        }
        
    }
}



#Preview {
    EmailLoginView()
}
