//
//  AddIngredientView.swift
//  DuruDuru
//
//  Created by 윤시진 on 2/9/25.
//

import UIKit
import SnapKit

class AddIngredientView: UIView {

    // MARK: - UI Components
    
    let backButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.tintColor = .black
    }
    
    let closeButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .black
    }
    
    let titleLabel = UILabel().then {
        $0.text = "식재료 추가하기"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textAlignment = .center
    }
    
    let topSeparator = UIView().then {
        $0.backgroundColor = UIColor.systemGreen
    }
    
    let stepLabel = UILabel().then {
        $0.text = "Step.1"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .gray
    }
    
    let instructionLabel = UILabel().then {
        $0.text = "추가할 식재료의\n사진과 이름을 입력해주세요."
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.textAlignment = .left
    }
    
    let imageView = UIView().then {
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        let icon = UIImageView(image: UIImage(systemName: "camera"))
        icon.tintColor = .darkGray
        $0.addSubview(icon)
        icon.snp.makeConstraints { $0.center.equalToSuperview() }
    }
    
    let nameLabel = UILabel().then {
        $0.text = "식재료이름"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .gray
    }
    
    let nameTextField = UITextField().then {
        $0.placeholder = "식재료 이름"
        $0.borderStyle = .roundedRect
    }
    
    let nextButton = UIButton().then {
        $0.setTitle("종류 설정하러 가기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.backgroundColor = .systemGreen
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 8
    }

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI 설정
    
    private func setupUI() {
        backgroundColor = .white
        addSubview(backButton)
        addSubview(closeButton)
        addSubview(titleLabel)
        addSubview(topSeparator)
        addSubview(stepLabel)
        addSubview(instructionLabel)
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(nameTextField)
        addSubview(nextButton)
    }
    
    // MARK: - 오토레이아웃 설정
    
    private func setupConstraints() {
        backButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(-30)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(44)
        }

        closeButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(-30)
            $0.trailing.equalToSuperview().offset(-16)
            $0.width.height.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(backButton)
            $0.centerX.equalToSuperview()
        }
        
        topSeparator.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(13)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        stepLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        
        instructionLabel.snp.makeConstraints {
            $0.top.equalTo(stepLabel.snp.bottom).offset(9)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        imageView.snp.makeConstraints {
            $0.top.equalTo(instructionLabel.snp.bottom).offset(19)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(UIScreen.main.bounds.width * 0.5)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
    }
}

