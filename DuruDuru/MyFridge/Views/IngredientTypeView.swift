//
//  IngredientTypeView.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/19/25.
//

import UIKit
import SnapKit

class IngredientTypeView: UIView {

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
        label.text = "Step.2"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .systemGray
        return label
    }()
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "식재료의 종류는 무엇인가요?"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "잘 모르겠다면 툴팁을 열어 식재료 종류 분류 기준을 확인하세요."
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()
    
    let leftStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    let pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .white
        picker.layer.cornerRadius = 8
        picker.clipsToBounds = true
        return picker
    }()

    
    let tooltipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.tintColor = .darkGray
        return button
    }()

    let tooltipLabel: UILabel = {
        let label = UILabel()
        label.text = "식재료 종류 분류 기준 확인하기"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .darkGray
        return label
    }()
    
    
    let dateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("날짜 설정하러 가기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
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
        addSubview(leftStackView)
        addSubview(pickerView)
        addSubview(tooltipButton)
        addSubview(tooltipLabel)
        addSubview(dateButton)
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
            $0.top.equalTo(stepLabel.snp.bottom).offset(9)
            $0.leading.equalToSuperview().offset(16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(9)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        leftStackView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(100)
            $0.bottom.equalToSuperview().offset(-350)
        }

        pickerView.snp.makeConstraints {
            $0.top.equalTo(leftStackView.snp.top)
            $0.leading.equalTo(leftStackView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(leftStackView.snp.bottom)
        }
        
        // 툴팁 버튼
        tooltipButton.snp.makeConstraints {
            $0.top.equalTo(pickerView.snp.bottom).offset(210) // pickerView 아래
            $0.centerX.equalToSuperview().offset(-80) // 약간 왼쪽으로
        }

        // 툴팁 라벨
        tooltipLabel.snp.makeConstraints {
            $0.centerY.equalTo(tooltipButton)
            $0.leading.equalTo(tooltipButton.snp.trailing).offset(8) // 버튼 오른쪽에 텍스트 배치
        }

        // 날짜 설정 버튼
        dateButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-16) // Safe Area 기준 하단 배치
        }
    }


}
