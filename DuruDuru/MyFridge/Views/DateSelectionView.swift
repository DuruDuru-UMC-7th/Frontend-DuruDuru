//
//  DateSelectionView.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/19/25.
//

import UIKit
import SnapKit

class DateSelectionView: UIView {
    // MARK: - Components
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "식재료 추가하기"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    let topSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    let stepLabel: UILabel = {
        let label = UILabel()
        label.text = "Step.3"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .systemGray
        return label
    }()
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "식재료를 구매한 날짜는 \n언제인가요?"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "선택한 날짜를 기준으로 식재료의 소비기한을 계산해요."
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    let dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "YYYY / MM / DD"
        textField.borderStyle = .roundedRect
        textField.rightView = UIImageView(image: UIImage(systemName: "calendar"))
        textField.rightViewMode = .always
        return textField
    }()
    
    let noMemoryLabel: UILabel = {
        let label = UILabel()
        label.text = "기억이 나지 않습니다"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray
        label.textAlignment = .right
        return label
    }()
    
    let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("식재료 추가", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        return button
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        backgroundColor = .white
        addSubview(backButton)
        addSubview(closeButton)
        addSubview(titleLabel)
        addSubview(topSeparator)
        addSubview(stepLabel)
        addSubview(questionLabel)
        addSubview(descriptionLabel)
        addSubview(dateTextField)
        addSubview(noMemoryLabel)
        addSubview(confirmButton)
    }
    
    private func setupConstraints() {
        backButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(backButton)
            $0.centerX.equalToSuperview()
        }
        
        topSeparator.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        stepLabel.snp.makeConstraints {
            $0.top.equalTo(topSeparator.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
        }
        
        questionLabel.snp.makeConstraints {
            $0.top.equalTo(stepLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        dateTextField.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(200)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        noMemoryLabel.snp.makeConstraints {
            $0.top.equalTo(dateTextField.snp.bottom).offset(10)
            $0.trailing.equalTo(dateTextField.snp.trailing)
            $0.leading.equalTo(dateTextField.snp.leading) // 텍스트필드에 맞춤
        }
        
        confirmButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
        }
    }
}
