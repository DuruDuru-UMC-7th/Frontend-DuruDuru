//
//  DateSelectionView.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/19/25.
//

import UIKit
import SnapKit

class DateSelectionView: UIView {
    // MARK: - UI Components
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
        view.backgroundColor = UIColor.systemGreen
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
        textField.textAlignment = .center
        
        // LeftView에 Calendar 아이콘 추가
//        let iconView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
//        let iconImageView = UIImageView(image: UIImage(systemName: "calendar"))
//        iconImageView.tintColor = .gray
//        iconView.addSubview(iconImageView)
//        textField.leftView = iconView
//        textField.leftViewMode = .always
//        
        
        return textField
    }()
    
    let noMemoryLabel: UILabel = {
        let label = UILabel()
        label.text = "기억이 나지 않습니다"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray
        
        // 밑줄 스타일 추가
        let attributedString = NSAttributedString(
            string: "기억이 나지 않습니다",
            attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue]
        )
        label.attributedText = attributedString
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
    
    // MARK: - Setup Methods
    private func setupUI() {
        backgroundColor = .white
        [backButton, closeButton, titleLabel, topSeparator, stepLabel, questionLabel,
         descriptionLabel, dateTextField, noMemoryLabel, confirmButton].forEach { addSubview($0) }
    }
    
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
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(237.5)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        noMemoryLabel.snp.makeConstraints {
            $0.top.equalTo(dateTextField.snp.bottom).offset(10)
            $0.trailing.equalTo(dateTextField.snp.trailing)
        }
        
        confirmButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
        }
    }
}
