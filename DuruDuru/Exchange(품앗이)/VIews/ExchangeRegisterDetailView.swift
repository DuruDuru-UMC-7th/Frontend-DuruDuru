//
//  ExchangeRegisterDetailView.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/28/25.
//

import UIKit
import SnapKit

class ExchangeRegisterDetailView: UIView {
    
    // MARK: - UI 컴포넌트
    
    let topSeparator = UIView().then {
        $0.backgroundColor = UIColor.systemGreen
    }
    
    let topSeparator2 = UIView().then {
        $0.backgroundColor = UIColor(hex: 0x37383C
                                     , alpha: 0.16)
    }
    
    /// 식재료 이미지
    let ingredientImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.systemGray5 // 임시 배경색
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    /// 식재료 이름 레이블
    let ingredientNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    /// 소비기한 레이블
    let expiryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "남은 소비기한"
        return label
    }()
    
    let expiryValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    /// 수량 레이블
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "수량"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    /// 수량 감소 버튼
    let minusButton = UIButton().then {
        $0.setImage(UIImage(systemName: "minus"), for: .normal)
        $0.layer.cornerRadius = 8.91
        $0.backgroundColor = UIColor(hex: 0xF4F4F5, alpha: 1.0)
        $0.tintColor = .black
    }
    
    /// 수량 증가 버튼
    let plusButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.layer.cornerRadius = 8.91
        $0.backgroundColor = UIColor(hex: 0xF4F4F5, alpha: 1.0)
        $0.tintColor = .black
    }
    
    /// 수량 표시 레이블
    let quantityValueLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    /// 단위 버튼 (UILabel + UIImageView 조합)
    let unitButton = UIButton().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(hex: 0x70737C, alpha: 0.52).cgColor
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.backgroundColor = .white
    }
    
    let unitButtonTitle = UILabel().then {
        $0.text = "단위"
        $0.textColor = UIColor(hex: 0x37383C, alpha: 0.61)
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textAlignment = .center
    }
    
    let unitButtonImage = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = UIColor(hex: 0x37383C, alpha: 0.61)
        $0.contentMode = .scaleAspectFill
    }
    
    let line = UIView().then {
        $0.backgroundColor = .white
    }
    
    let line2 = UIView().then {
        $0.backgroundColor = .white
        $0.isHidden = true
    }

    /// 설명 라벨
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "설명"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    /// 설명 텍스트뷰
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 8
        textView.font = .systemFont(ofSize: 14)
        textView.text = "품앗이 할 식재료의 상태를 자세히 설명해주세요.\n건강하고 알뜰한 품앗이 문화를 함께 만들어나가요!"
        textView.textColor = .systemGray
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 10, right: 10)

        return textView
    }()
    
    /// 방식 라벨
    let methodLabel: UILabel = {
        let label = UILabel()
        label.text = "방식"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    /// 나눔 버튼
    let shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("나눔", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 6
        return button
    }()
    
    /// 교환 버튼
    let exchangeButton: UIButton = {
        let button = UIButton()
        button.setTitle("교환", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 6
        return button
    }()

    /// 하단 "품앗이 등록 완료" 버튼
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("품앗이 등록 완료", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
        button.backgroundColor = UIColor(hex: 0xF4F4F5, alpha: 1.0)
        button.layer.cornerRadius = 10
        button.isEnabled = false
        return button
    }()
    
    func updateNextButtonState(isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
        nextButton.backgroundColor = isEnabled ? UIColor(hex: 0x00C269) : UIColor(hex: 0xF4F4F5, alpha: 1.0)
        nextButton.setTitleColor(isEnabled ? .white : UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
    }
    
    // MARK: - 초기화
    
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
        addSubview(ingredientImageView)
        addSubview(ingredientNameLabel)
        addSubview(expiryLabel)
        addSubview(expiryValueLabel)
        addSubview(quantityLabel)
        addSubview(minusButton)
        addSubview(quantityValueLabel)
        addSubview(plusButton)
        addSubview(unitButton)
        unitButton.addSubview(unitButtonTitle)
        unitButton.addSubview(unitButtonImage)
        addSubview(line2)
        addSubview(descriptionLabel)
        addSubview(descriptionTextView)
        addSubview(methodLabel)
        addSubview(shareButton)
        addSubview(exchangeButton)
        addSubview(nextButton)
    }
    
    // MARK: - 오토레이아웃 설정
    
    private func setupConstraints() {
        topSeparator.snp.makeConstraints {
            $0.top.equalToSuperview().offset(98)
            $0.leading.equalToSuperview()
            $0.height.equalTo(2)
            $0.width.equalTo(UIScreen.main.bounds.width * (3 / 4))
        }
        
        topSeparator2.snp.makeConstraints {
            $0.top.equalToSuperview().offset(98)
            $0.leading.equalTo(topSeparator.snp.trailing)
            $0.height.equalTo(2)
            $0.trailing.equalToSuperview()
        }
        
        ingredientImageView.snp.makeConstraints {
            $0.top.equalTo(topSeparator.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(118)
        }
        
        ingredientNameLabel.snp.makeConstraints {
            $0.top.equalTo(topSeparator.snp.bottom).offset(38.5)
            $0.leading.equalTo(ingredientImageView.snp.trailing).offset(15)
            $0.height.equalTo(22)
        }
        
        expiryLabel.snp.makeConstraints {
            $0.top.equalTo(ingredientNameLabel.snp.bottom).offset(18.5)
            $0.leading.equalTo(ingredientImageView.snp.trailing).offset(15)
            $0.height.equalTo(22)
        }
        
        expiryValueLabel.snp.makeConstraints {
            $0.top.equalTo(ingredientNameLabel.snp.bottom).offset(18.5)
            $0.leading.equalTo(expiryLabel.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(22)
        }
        
        quantityLabel.snp.makeConstraints {
            $0.top.equalTo(ingredientImageView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(22)
        }
        
        minusButton.snp.makeConstraints {
            $0.top.equalTo(quantityLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(26)
        }
        
        quantityValueLabel.snp.makeConstraints {
            $0.centerY.equalTo(minusButton)
            $0.leading.equalTo(minusButton.snp.trailing).offset(12)
            $0.width.equalTo(32)
            $0.height.equalTo(22)
        }
        
        plusButton.snp.makeConstraints {
            $0.centerY.equalTo(minusButton)
            $0.leading.equalTo(quantityValueLabel.snp.trailing).offset(12)
            $0.width.height.equalTo(26)
        }
        
        unitButton.snp.makeConstraints {
            $0.centerY.equalTo(minusButton)
            $0.leading.equalTo(plusButton.snp.trailing).offset(10)
            $0.width.equalTo(94)
            $0.height.equalTo(36)
        }
        
        unitButtonTitle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
            $0.height.equalTo(22)
        }
        
        unitButtonImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.width.equalTo(14)
        }
        
        line2.snp.makeConstraints {
            $0.bottom.equalTo(unitButton.snp.bottom)
            $0.centerX.equalTo(unitButton)
            $0.width.equalTo(92)
            $0.height.equalTo(1)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(quantityLabel.snp.bottom).offset(67)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(22)
        }
        
        descriptionTextView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(186)
        }
        
        methodLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionTextView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(22)
        }
        
        shareButton.snp.makeConstraints {
            $0.top.equalTo(methodLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(32)
        }
        
        exchangeButton.snp.makeConstraints {
            $0.centerY.equalTo(shareButton)
            $0.leading.equalTo(shareButton.snp.trailing).offset(13)
            $0.width.equalTo(80)
            $0.height.equalTo(32)
        }
        
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(47)
            $0.bottom.equalToSuperview().offset(-40)
        }
    }
    // MARK: - 버튼 스타일 업데이트
    func updateButtonStyle(selectedButton: UIButton, deselectedButton: UIButton) {
        selectedButton.setTitleColor(.white, for: .normal)
        selectedButton.backgroundColor = .systemGreen
        selectedButton.layer.borderColor = UIColor.systemGreen.cgColor
        
        deselectedButton.setTitleColor(.systemGray, for: .normal)
        deselectedButton.backgroundColor = .white
        deselectedButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func configure(with ingredient: MyIngredient) {
        ingredientNameLabel.text = ingredient.ingredientName
        if let expiryDate = expiryDateFormatter.date(from: ingredient.expiryDate) {
            expiryValueLabel.text = dDay(from: expiryDate)
        } else {
            expiryValueLabel.text = "만료일 형식 오류"
        }
    }
    
    func dDay(from date: Date) -> String {
        let calendar = Calendar.current
        let now = Date()

        let components = calendar.dateComponents([.year, .month, .day], from: now, to: date)
        
        // 연도, 월, 일 추출
        let years = components.year ?? 0
        let months = components.month ?? 0
        let days = components.day ?? 0

        // 결과 문자열을 구성
        if years > 0 {
            return "\(years)년 \(months)개월"
        } else if months > 0 {
            if days > 15 {
                return "\(months + 1)개월"
            } else {
                return "\(months)개월"
            }
        } else if days >= 0 {
            return "\(days)일"
        } else {
            return "지났습니다"
        }
    }
    
    let expiryDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}



