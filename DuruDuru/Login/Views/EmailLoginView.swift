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
    public lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Left"), for: .normal) // 버튼 이미지 설정
        button.contentMode = .scaleAspectFit // 이미지 비율 유지
        button.translatesAutoresizingMaskIntoConstraints = false // Auto Layout 사용 시 필수
        return button
    }()
    
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
    lazy var emailTextField: UITextField = textField(text: "이메일을 입력하세요")
    
    /// 비밀번호 라벨
    private lazy var passwordLabel: UILabel = makeLabel(title: "비밀번호")
    
    /// 비밀번호 입력 텍스트필드
    lazy var passwordTextField: InputTextfield = InputTextfield()
    
    
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
    lazy var signUpButton: UIButton = {
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
        self.addSubview(backButton)
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
        let screenHeight = UIScreen.main.bounds.height
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            $0.left.equalToSuperview().offset(16)
            $0.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        emailLabel.snp.makeConstraints{
            let topOffset = screenHeight < 700 ? 100 : 196.5  // 여백 조정
            $0.top.equalTo(titleLabel.snp.bottom).offset(topOffset)
            $0.left.equalToSuperview().offset(16)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(52)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.left.equalTo(emailTextField.snp.left)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(10)
            $0.left.equalTo(emailTextField.snp.left)
            $0.right.equalTo(emailTextField.snp.right)
            $0.height.equalTo(52)
        }
        
        notMemberLabel.snp.makeConstraints {
            let bottomOffset = screenHeight < 700 ? 50 : 197  // 여백 조정
            $0.top.equalTo(passwordTextField.snp.bottom).offset(bottomOffset)
            $0.centerX.equalToSuperview()
        }
        
        signUpButton.snp.makeConstraints {
            $0.centerY.equalTo(notMemberLabel.snp.centerY)
            $0.left.equalTo(notMemberLabel.snp.right).offset(5)
        }
        
        searchLabel.snp.makeConstraints {
            $0.top.equalTo(notMemberLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        
        loginBtn.snp.makeConstraints {
            let bottomOffset = screenHeight < 700 ? -10 : -20  // 여백조정
            $0.top.equalTo(searchLabel.snp.bottom).offset(20)
            $0.left.equalTo(emailTextField.snp.left)
            $0.right.equalTo(emailTextField.snp.right)
            $0.height.equalTo(47)
            $0.bottom.lessThanOrEqualTo(self.safeAreaLayoutGuide.snp.bottom).offset(bottomOffset)
        }
    }
}
