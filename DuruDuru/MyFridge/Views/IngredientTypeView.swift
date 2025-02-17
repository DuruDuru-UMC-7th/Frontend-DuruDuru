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
    let topSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGreen
        return view
    }()
    
    let topSeparator2 = UIView().then {
        $0.backgroundColor = UIColor(hex: 0x37383C
                                     , alpha: 0.16)
    }
    
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

    let allButton = UIButton().then {
        $0.setImage(UIImage(systemName: "line.horizontal.3")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.backgroundColor = UIColor(hex: 0x474747, alpha: 1.0)
        $0.tintColor = .white
        $0.layer.cornerRadius = 4
    }
    
    let ingredientCategoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.estimatedItemSize = .init(width: 60, height: 26)
        $0.minimumInteritemSpacing = 4
    }).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = true
        $0.register(IngredientCategoryCollectionViewCell.self, forCellWithReuseIdentifier: IngredientCategoryCollectionViewCell.identifier)
        $0.showsHorizontalScrollIndicator = false
    }
    
    let ingredientsCircleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumInteritemSpacing = 8 // 좌우 간격
        $0.minimumLineSpacing = 12 // 상하 간격
    }).then {
        $0.backgroundColor = .clear
        $0.register(IngredientsCircleCollectionViewCell.self, forCellWithReuseIdentifier: IngredientsCircleCollectionViewCell.identifier)
        $0.showsVerticalScrollIndicator = false
    }
    
    let dateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("날짜 설정하러 가기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(UIColor(hex: 0x37383C, alpha: 1.0), for: .normal)
        button.backgroundColor = UIColor(hex: 0xF4F4F5, alpha: 1.0)
        button.layer.cornerRadius = 8
        return button
    }()
    
    // 팝업 컨테이너 뷰
    let popupView = UIView().then {
        $0.backgroundColor = UIColor(hex: 0xFAFAFA, alpha: 1.0)
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        $0.tag = 999 // 중복 방지를 위한 태그 설정
        $0.isHidden = true
    }

    // 팝업 제목
    let titleLabel = UILabel().then {
        $0.text = "이렇게 보관할 거예요!"
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textAlignment = .center
    }

    // 팝업 메시지
    let messageLabel = UILabel().then {
        $0.text = "보관 방식에 따라 적용되는 소비기한이 달라져요"
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textAlignment = .center
        $0.textColor = UIColor(hex: 0x4F4F4F, alpha: 1.0)
    }
    
    let storageTyp1 = UIButton().then {
        $0.setTitle("실온", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        $0.setTitleColor(UIColor(hex: 0x9F9F9F, alpha: 1.0), for: .normal)
        $0.backgroundColor = UIColor(hex: 0xEFEFEF, alpha: 1.0)
        $0.layer.cornerRadius = 8
    }
    
    let storageTyp2 = UIButton().then {
        $0.setTitle("냉장", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        $0.setTitleColor(UIColor(hex: 0x9F9F9F, alpha: 1.0), for: .normal)
        $0.backgroundColor = UIColor(hex: 0xEFEFEF, alpha: 1.0)
        $0.layer.cornerRadius = 8
    }
    
    let storageTyp3 = UIButton().then {
        $0.setTitle("냉동", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        $0.setTitleColor(UIColor(hex: 0x9F9F9F, alpha: 1.0), for: .normal)
        $0.backgroundColor = UIColor(hex: 0xEFEFEF, alpha: 1.0)
        $0.layer.cornerRadius = 8
    }
    
    let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
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
        addSubview(topSeparator)
        addSubview(topSeparator2)
        addSubview(stepLabel)
        addSubview(questionLabel)
        addSubview(allButton)
        addSubview(ingredientCategoryCollectionView)
        addSubview(ingredientsCircleCollectionView)
        addSubview(dateButton)
        addSubview(popupView)
        popupView.addSubview(titleLabel)
        popupView.addSubview(messageLabel)
        popupView.addSubview(stackView)
        stackView.addArrangedSubview(storageTyp1)
        stackView.addArrangedSubview(storageTyp2)
        stackView.addArrangedSubview(storageTyp3)
    }
    
    private func setupConstraints() {
        topSeparator.snp.makeConstraints {
            $0.top.equalToSuperview().offset(98)
            $0.leading.equalToSuperview()
            $0.height.equalTo(2)
            $0.width.equalTo(UIScreen.main.bounds.width * (2 / 3))
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
        
        questionLabel.snp.makeConstraints {
            $0.top.equalTo(stepLabel.snp.bottom).offset(0)
            $0.leading.equalToSuperview().offset(16)
        }
        
        allButton.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(26)
        }
        
        ingredientCategoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(10)
            $0.left.equalTo(allButton.snp.right).offset(8)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(26)
        }
        
        ingredientsCircleCollectionView.snp.makeConstraints {
            $0.top.equalTo(ingredientCategoryCollectionView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(dateButton.snp.top).offset(-20)
        }
        // 날짜 설정 버튼
        dateButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-16) // Safe Area 기준 하단 배치
        }
        
        popupView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(136)
            $0.bottom.equalTo(dateButton.snp.top).offset(-28)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(23)
            $0.top.equalToSuperview().offset(20)
        }
        
        messageLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(16)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        storageTyp1.snp.makeConstraints {
            $0.height.equalTo(42)
            $0.width.equalTo((UIScreen.main.bounds.width - 92)/3)
        }
        
        storageTyp2.snp.makeConstraints {
            $0.height.equalTo(42)
            $0.width.equalTo((UIScreen.main.bounds.width - 92)/3)
        }
        
        storageTyp3.snp.makeConstraints {
            $0.height.equalTo(42)
            $0.width.equalTo((UIScreen.main.bounds.width - 92)/3)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(42)
            $0.top.equalTo(messageLabel.snp.bottom).offset(15)
        }
    }
}
