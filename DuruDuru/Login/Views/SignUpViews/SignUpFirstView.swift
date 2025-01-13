//
//  SingUpFirstView.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/9/25.
//

import UIKit

class SignUpFirstView: UIView {

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
    public lazy var backImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Back")
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
    private lazy var lineImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Line1")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    /// "이름" 라벨
    private lazy var nameLabel: UILabel = makeLabel(title: "이름")
    
    /// "이메일" 라벨
    private lazy var emailLabel: UILabel = makeLabel(title: "이메일")
    
    /// "비밀번호" 라벨
    private lazy var passwordLabel: UILabel = makeLabel(title: "비밀번호")
    
    /// 이름 텍스트필드
    public lazy var nameTextField: UITextField = textField(text: "이름을 입력하세요")
    
    /// 이메일 텍스트필드
    public lazy var emailTextField: UITextField = textField(text: "이메일을 입력하세요")
    
    /// 비밀번호 텍스트필드
    public lazy var passwordTextField: UITextField = textField(text: "비밀번호를 입력하세요 (8자 이상)")
    
    /// 다음으로 버튼
    public lazy var nextBtn: UIButton = {
        let btn = UIButton()
        
        // 버튼 제목
        btn.setTitle("다음으로", for: .normal)
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
    
    /// 라벨 함수(이름, 이메일, 비밀번호)
    private func makeLabel(title: String) -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        label.text = title
        return label
    }
    
    /// 텍스트필드 함수
    private func textField(text: String) -> UITextField {
        let textField = UITextField()
        
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 1))
        
        // placeholder 텍스트 속성 설정
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hex: 0xBEBEBE) ?? UIColor.lightGray,
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
        self.addSubview(lineImage)
        self.addSubview(nameLabel)
        self.addSubview(emailLabel)
        self.addSubview(passwordLabel)
        self.addSubview(nameTextField)
        self.addSubview(emailTextField)
        self.addSubview(passwordTextField)
        self.addSubview(nextBtn)
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
            $0.left.equalTo(backImage.snp.right).offset(146)
            $0.width.equalTo(56)
            $0.height.equalTo(22)
        }
        
        lineImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(90)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            //$0.width.equalTo(393)
            $0.height.equalTo(1)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(179)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(26)
            $0.height.equalTo(22)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(361)
            $0.height.equalTo(52)
        }
        
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(39)
            $0.height.equalTo(22)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(361)
            $0.height.equalTo(52)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(52)
            $0.height.equalTo(22)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(361)
            $0.height.equalTo(52)
        }
        
        nextBtn.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(290)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(361)
            $0.height.equalTo(47)
        }
    }
}
