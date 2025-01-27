//
//  ProfileEditView.swift
//  DuruDuru
//
//  Created by 임효진 on 1/28/25.
//

import UIKit

class ProfileEditView: UIView {
    
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
    
    // MARK: - Components
    
    private let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.image = .thumbnail
        $0.layer.cornerRadius = 53
    }
    
    private let nicknameLabel = UILabel().then {
        $0.text = "닉네임"
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = .black
    }
    
    private let nicknameTextField = PaddedTextField(padding: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)).then {
        $0.placeholder = "닉네임을 2글자 이상 입력하세요."
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(hex: 0x70737C, alpha: 0.16)?.cgColor
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    private let genderLabel = UILabel().then {
        $0.text = "성별"
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = .black
    }
    
    private let maleButton = UIButton().then {
        $0.setTitle("남성", for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 13)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(hex: 0x37383C, alpha: 0.61)
        $0.layer.cornerRadius = 6
    }
    
    private let femaleButton = UIButton().then {
        $0.setTitle("여성", for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 13)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(hex: 0x37383C, alpha: 0.61)
        $0.layer.cornerRadius = 6
    }
    
    // MARK: - Constaints & Add Function
    
    private func addComponents() {
        addSubview(profileImageView)
        addSubview(nicknameLabel)
        addSubview(nicknameTextField)
        addSubview(genderLabel)
        addSubview(maleButton)
        addSubview(femaleButton)
    }
    
    private func constraints() {
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(120)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(106)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(16)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
        
        genderLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(16)
        }
        
        maleButton.snp.makeConstraints {
            $0.top.equalTo(genderLabel.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(32)
        }
        
        femaleButton.snp.makeConstraints {
            $0.top.equalTo(genderLabel.snp.bottom).offset(10)
            $0.left.equalTo(maleButton.snp.right).offset(13)
            $0.width.equalTo(80)
            $0.height.equalTo(32)
        }
    }
}

class PaddedTextField: UITextField {
    let padding: UIEdgeInsets

    init(padding: UIEdgeInsets) {
        self.padding = padding
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        self.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        super.init(coder: coder)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
