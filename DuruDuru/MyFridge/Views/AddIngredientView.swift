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
    let topSeparator = UIView().then {
        $0.backgroundColor = UIColor.systemGreen
    }
    
    let topSeparator2 = UIView().then {
        $0.backgroundColor = UIColor(hex: 0x37383C
                                     , alpha: 0.16)
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
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    /// 수량 레이블
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "수량"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    /// 수량 감소 버튼
    let minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("−", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.backgroundColor = UIColor.systemGray6
        button.layer.cornerRadius = 8
        return button
    }()
    
    /// 수량 증가 버튼
    let plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.backgroundColor = UIColor.systemGray6
        button.layer.cornerRadius = 8
        return button
    }()
    
    /// 수량 표시 레이블
    let quantityValueLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let nextButton = UIButton().then {
        $0.setTitle("종류 설정하러 가기", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.backgroundColor = .systemGray4
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 8
        $0.isEnabled = false
    }

    func updateNextButtonState(isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
        nextButton.backgroundColor = isEnabled ? .systemGreen : .systemGray4
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
        addSubview(topSeparator)
        addSubview(topSeparator2)
        addSubview(stepLabel)
        addSubview(instructionLabel)
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(nameTextField)
        addSubview(quantityLabel)
        addSubview(minusButton)
        addSubview(quantityValueLabel)
        addSubview(plusButton)
        addSubview(nextButton)
    }
    
    // MARK: - 오토레이아웃 설정
    
    private func setupConstraints() {
        topSeparator.snp.makeConstraints {
            $0.top.equalToSuperview().offset(98)
            $0.leading.equalToSuperview()
            $0.height.equalTo(2)
            $0.width.equalTo(UIScreen.main.bounds.width * (1 / 3))
        }
        
        topSeparator2.snp.makeConstraints {
            $0.top.equalToSuperview().offset(98)
            $0.leading.equalTo(topSeparator.snp.trailing)
            $0.height.equalTo(2)
            $0.trailing.equalToSuperview()
        }
        
        stepLabel.snp.makeConstraints {
            $0.top.equalTo(topSeparator.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
        }
        
        instructionLabel.snp.makeConstraints {
            $0.top.equalTo(stepLabel.snp.bottom).offset(0)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        imageView.snp.makeConstraints {
            $0.top.equalTo(instructionLabel.snp.bottom).offset(10)
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
            $0.height.equalTo(36)
        }
        
        quantityLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
        }
        
        minusButton.snp.makeConstraints {
            $0.top.equalTo(quantityLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(26)
        }
        
        quantityValueLabel.snp.makeConstraints {
            $0.centerY.equalTo(minusButton)
            $0.leading.equalTo(minusButton.snp.trailing).offset(6)
            $0.width.equalTo(50)
            $0.height.equalTo(40)
        }
        
        plusButton.snp.makeConstraints {
            $0.centerY.equalTo(minusButton)
            $0.leading.equalTo(quantityValueLabel.snp.trailing).offset(6)
            $0.width.height.equalTo(26)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
    }
}

