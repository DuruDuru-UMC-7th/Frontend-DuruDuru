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
    
    /// 뒤로 가기 버튼
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    /// 닫기 버튼
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    /// 제목 레이블
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "식재료 추가하기"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    /// 상단 구분선
    let topSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGreen
        return view
    }()
    
    /// 식재료 이미지
    let ingredientImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.systemGray5 // 임시 배경색
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    /// 식재료 이름 레이블
    let ingredientNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    /// 소비기한 레이블
    let expiryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        return label
    }()
    
    /// 수량 레이블
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "수량"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    /// 수량 감소 버튼
    let minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("−", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 4
        return button
    }()
    
    /// 수량 증가 버튼
    let plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 4
        return button
    }()
    
    /// 수량 표시 레이블
    let quantityValueLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        return label
    }()
    
    /// 단위 선택 버튼 (드롭다운)
    let unitButton: UIButton = {
        let button = UIButton()
        button.setTitle("단위", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 4
        return button
    }()
    
    /// 설명 라벨
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "설명"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    /// 설명 텍스트뷰
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 8
        textView.font = .systemFont(ofSize: 16)
        textView.text = "품앗이 할 식재료의 상태를 자세히 설명해주세요.\n건강하고 알뜰한 품앗이 문화를 함께 만들어나가요!"
        textView.textColor = .systemGray
        return textView
    }()
    
    /// 방식 라벨
    let methodLabel: UILabel = {
        let label = UILabel()
        label.text = "방식"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    /// 나눔 버튼
    let shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("나눔", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 8
        return button
    }()
    
    /// 교환 버튼
    let exchangeButton: UIButton = {
        let button = UIButton()
        button.setTitle("교환", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 8
        return button
    }()

    /// 하단 "다음으로" 버튼
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("다음으로", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        return button
    }()
    
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
        addSubview(backButton)
        addSubview(closeButton)
        addSubview(titleLabel)
        addSubview(topSeparator)
        addSubview(ingredientImageView)
        addSubview(ingredientNameLabel)
        addSubview(expiryLabel)
        addSubview(quantityLabel)
        addSubview(minusButton)
        addSubview(quantityValueLabel)
        addSubview(plusButton)
        addSubview(unitButton)
        addSubview(descriptionLabel)
        addSubview(descriptionTextView)
        addSubview(methodLabel)
        addSubview(shareButton)
        addSubview(exchangeButton)
        addSubview(nextButton)
    }
    
    // MARK: - 오토레이아웃 설정
    
    private func setupConstraints() {
        backButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(-20)
            $0.leading.equalToSuperview().offset(16)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(-20)
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
        
        ingredientImageView.snp.makeConstraints {
            $0.top.equalTo(topSeparator.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(80)
        }
        
        ingredientNameLabel.snp.makeConstraints {
            $0.top.equalTo(ingredientImageView)
            $0.leading.equalTo(ingredientImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        expiryLabel.snp.makeConstraints {
            $0.top.equalTo(ingredientNameLabel.snp.bottom).offset(8)
            $0.leading.equalTo(ingredientImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        quantityLabel.snp.makeConstraints {
            $0.top.equalTo(ingredientImageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
        }
        
        minusButton.snp.makeConstraints {
            $0.top.equalTo(quantityLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(40)
        }
        
        quantityValueLabel.snp.makeConstraints {
            $0.centerY.equalTo(minusButton)
            $0.leading.equalTo(minusButton.snp.trailing).offset(8)
            $0.width.equalTo(50)
            $0.height.equalTo(40)
        }
        
        plusButton.snp.makeConstraints {
            $0.centerY.equalTo(minusButton)
            $0.leading.equalTo(quantityValueLabel.snp.trailing).offset(8)
            $0.width.height.equalTo(40)
        }
        
        unitButton.snp.makeConstraints {
            $0.centerY.equalTo(minusButton)
            $0.leading.equalTo(plusButton.snp.trailing).offset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(300) // 기존 컴포넌트 아래에 적절히 위치
            $0.leading.equalToSuperview().offset(16)
        }
        
        descriptionTextView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(150)
        }
        
        methodLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionTextView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
        }
        
        shareButton.snp.makeConstraints {
            $0.top.equalTo(methodLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
        
        exchangeButton.snp.makeConstraints {
            $0.centerY.equalTo(shareButton)
            $0.leading.equalTo(shareButton.snp.trailing).offset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
        
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
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
}



