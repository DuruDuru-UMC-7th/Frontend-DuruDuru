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
    public lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Left"), for: .normal) // 버튼 이미지 설정
        button.contentMode = .scaleAspectFit // 이미지 비율 유지
        button.translatesAutoresizingMaskIntoConstraints = false // Auto Layout 사용 시 필수
        return button
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
    
    /// "휴대폰 번호" 라벨
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .left
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
        self.addSubview(backButton)
        self.addSubview(titleLabel)
        self.addSubview(borderLine)
        self.addSubview(phoneLabel)
        self.addSubview(phoneTextField)
        self.addSubview(applyBtn)
        self.addSubview(numberTextField)
        self.addSubview(nextBtn)
        
    }
    
    /// 오토레이아웃 설정
    private func constraints(){
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(65)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(65)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(115)
            $0.height.equalTo(22)
        }
        
        borderLine.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(9)
            $0.left.equalToSuperview()
            $0.width.equalTo(402)
            $0.height.equalTo(2)
        }
        
        phoneLabel.snp.makeConstraints {
            $0.top.equalTo(borderLine.snp.bottom).offset(259.5)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(370)
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
            $0.top.equalTo(phoneTextField.snp.bottom).offset(11)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(370)
            $0.height.equalTo(52)
        }
        
        nextBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(787)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(370)
            $0.height.equalTo(47)
        }
        
    }

}

