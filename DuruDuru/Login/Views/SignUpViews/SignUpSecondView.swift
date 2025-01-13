//
//  SingUpSecondView.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/9/25.
//

import UIKit

class SignUpSecondView: UIView {

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
        imageView.image = UIImage(named: "Line2")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    /// "휴대폰 번호" 라벨
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        label.text = "휴대폰 번호"
        return label
    }()
    
    /// 휴대폰 번호 텍스트필드
    public lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 1))
        
        // placeholder 텍스트 속성 설정
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hex: 0xBEBEBE) ?? UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 14) // 글씨 크기
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "휴대폰 번호를 입력하세요", attributes: placeholderAttributes)
        
        // 테두리
        textField.layer.cornerRadius = 8  // 둥글게 만드는 속성
        textField.layer.borderWidth = 1    // 테두리 두께
        textField.layer.borderColor = UIColor(hex: 0xBEBEBE)?.cgColor // 테두리 색상
        textField.clipsToBounds = true  // 모서리가 잘리도록 설정
        
        return textField
    }()
    
    /// 인증번호 요청 버튼
    public lazy var applyBtn: UIButton = {
        let btn = UIButton()
        
        // 버튼 제목
        btn.setTitle("인증번호 요청", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        btn.setTitleColor(.white, for: .normal)
        
        // 배경 색깔 (Hex값)
        btn.backgroundColor = UIColor(hex: 0x4D4D4D)
        
        // 테두리 색깔
        btn.layer.borderColor = UIColor(hex: 0x4D4D4D)?.cgColor
        btn.layer.borderWidth = 1.0
        
        // 모서리 둥글둥글
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 8
        
        return btn
    }()
    
    /// 인증번호 입력 텍스트필드
    public lazy var numberTextField: UITextField = {
        let textField = UITextField()
        
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 1))
        
        // placeholder 텍스트 속성 설정
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hex: 0xB3B3B3) ?? UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 14) // 글씨 크기
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "인증번호를 입력하세요", attributes: placeholderAttributes)
        
        // 배경색 설정
        textField.backgroundColor = UIColor(hex: 0xF4F4F4) // 텍스트 필드 내부 색상
        
        // 테두리
        textField.layer.cornerRadius = 8  // 둥글게 만드는 속성
        textField.layer.borderWidth = 1    // 테두리 두께
        textField.layer.borderColor = UIColor(hex: 0xBEBEBE)?.cgColor // 테두리 색상
        textField.clipsToBounds = true  // 모서리가 잘리도록 설정
        
        return textField
    }()
    
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
    
    

    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        self.addSubview(backImage)
        self.addSubview(titleLabel)
        self.addSubview(lineImage)
        self.addSubview(phoneLabel)
        self.addSubview(phoneTextField)
        self.addSubview(applyBtn)
        self.addSubview(numberTextField)
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
        
        phoneLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(326)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(69)
            $0.height.equalTo(22)
        }
        
        phoneTextField.snp.makeConstraints {
            $0.top.equalTo(phoneLabel.snp.bottom).offset(11)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(237)
            $0.height.equalTo(52)
        }
        
        applyBtn.snp.makeConstraints {
            $0.top.equalTo(phoneLabel.snp.bottom).offset(11)
            $0.left.equalTo(phoneTextField.snp.right).offset(8)
            $0.width.equalTo(116)
            $0.height.equalTo(52)
        }
        
        numberTextField.snp.makeConstraints{
            $0.top.equalTo(phoneTextField.snp.bottom).offset(12)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(361)
            $0.height.equalTo(52)
        }
        
        nextBtn.snp.makeConstraints {
            $0.top.equalTo(numberTextField.snp.bottom).offset(292)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(361)
            $0.height.equalTo(47)
        }
        
    }

}
