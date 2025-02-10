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

    let searchBarContainer = UIView().then {
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.backgroundColor = UIColor(red: 118/255, green: 118/255, blue: 128/255, alpha: 0.12)
    }
    
    /// 검색 바
    let searchBar = UISearchBar().then {
        $0.placeholder = "식재료 이름으로 검색하기"
        $0.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        $0.backgroundColor = .clear
        // 텍스트 필드 접근
        if let textField = $0.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.systemFont(ofSize: 14)
            textField.textColor = UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.6)
            textField.backgroundColor = .clear
        }
    }
    
    let allButton = UIButton().then {
        $0.setImage(.allCategory, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.backgroundColor = UIColor(hex: 0xF7F7F8, alpha: 1.0)
        $0.layer.cornerRadius = 4
    }
    
    let ingredientCategoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.estimatedItemSize = .init(width: 60, height: 26)
        $0.minimumInteritemSpacing = 8
    }).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = true
        $0.register(IngredientCategoryCollectionViewCell.self, forCellWithReuseIdentifier: IngredientCategoryCollectionViewCell.identifier)
        $0.showsHorizontalScrollIndicator = false
    }
    
    let ingredientsCircleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumInteritemSpacing = 8 // 좌우 간격
        $0.minimumLineSpacing = 7 // 상하 간격
        $0.estimatedItemSize = .init(width: 118, height: 145)// 셀 크기
    }).then {
        $0.backgroundColor = .clear
        $0.register(IngredientsCircleCollectionViewCell.self, forCellWithReuseIdentifier: IngredientsCircleCollectionViewCell.identifier)
        $0.showsVerticalScrollIndicator = false
    }
    
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
        addSubview(topSeparator)
        addSubview(topSeparator2)
        addSubview(stepLabel)
        addSubview(questionLabel)
        addSubview(searchBarContainer)
        searchBarContainer.addSubview(searchBar)
        addSubview(allButton)
        addSubview(ingredientCategoryCollectionView)
        addSubview(ingredientsCircleCollectionView)
        addSubview(dateButton)
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
        
        searchBarContainer.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(36)
        }
        
        searchBar.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        allButton.snp.makeConstraints {
            $0.top.equalTo(searchBarContainer.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(26)
        }
        
        ingredientCategoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchBarContainer.snp.bottom).offset(10)
            $0.left.equalTo(allButton.snp.right).offset(8)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(26)
        }
        
        ingredientsCircleCollectionView.snp.makeConstraints {
            $0.top.equalTo(ingredientCategoryCollectionView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview()
        }
        // 날짜 설정 버튼
        dateButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-16) // Safe Area 기준 하단 배치
        }
    }


}
