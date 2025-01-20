//
//  IngredientView.swift
//  DuruDuru
//
//  Created by 임효진 on 1/8/25.
//

import UIKit

class IngredientsView: UIView {
    
    // MARK: - Components
    
    
    /// 검색 바
    let searchBar = UISearchBar().then {
        $0.placeholder = "검색어를 입력하세요"
        $0.searchBarStyle = .minimal
    }
    
    let allButton = UIButton().then {
        $0.setImage(.allCategory, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.backgroundColor = UIColor(ciColor: CIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1.0))
        $0.layer.cornerRadius = 10
    }
    
    let ingredientCategoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.estimatedItemSize = CGSize(width: 66, height: 26)
    }).then {
        $0.showsHorizontalScrollIndicator = false
        $0.register(IngredientCategoryCollectionViewCell.self, forCellWithReuseIdentifier: IngredientCategoryCollectionViewCell.identifier)
    }
    
    // 소비기한 드롭다운 버튼
    let expiryDropdownButton = UIButton().then {
        let configuration = UIButton.Configuration.plain()
        $0.configuration = configuration
        $0.configuration?.image = UIImage(named: "Arrow")
        $0.configuration?.imagePlacement = .trailing // 화살표를 텍스트 오른쪽에 배치
        $0.configuration?.imagePadding = 8 // 텍스트와 이미지 간격
        $0.configuration?.baseForegroundColor = .gray
        $0.configuration?.attributedTitle = AttributedString("소비기한 임박순", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 12)]))
    }
    
    let ingredientsCircleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumInteritemSpacing = 16
        $0.minimumLineSpacing = 16
    }).then {
        $0.backgroundColor = .clear
        $0.register(IngredientsCircleCollectionViewCell.self, forCellWithReuseIdentifier: IngredientsCircleCollectionViewCell.identifier)
        $0.showsVerticalScrollIndicator = false
    }
    
    
    /// 플로팅 버튼
    let floatingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "floating"), for: .normal) // floating.png 이미지
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 4
        return button
    }()
    
    /// 팝업 버튼 1
    let receiptButton: UIButton = {
        let button = UIButton()
        button.setTitle("영수증으로 추가하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.isHidden = true // 초기 상태 숨김
        return button
    }()
    
    /// 팝업 버튼 2
    let manualButton: UIButton = {
        let button = UIButton()
        button.setTitle("직접 추가하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.isHidden = true // 초기 상태 숨김
        return button
    }()
    
    
    
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addComponents()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Add Components
    
    /// 컴포넌트를 뷰에 추가
    private func addComponents() {
        addSubview(searchBar)
        addSubview(allButton)
        addSubview(ingredientCategoryCollectionView)
        addSubview(expiryDropdownButton)
        addSubview(ingredientsCircleCollectionView)
        addSubview(floatingButton)
        addSubview(receiptButton)
        addSubview(manualButton)
    }
    
    // MARK: - Setup Constraints
    
    /// 오토레이아웃 설정
    private func setupConstraints() {
        
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(17)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        allButton.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(26)
        }
        
        ingredientCategoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(20)
            $0.left.equalTo(allButton.snp.right).offset(8)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(26)
        }
        
        expiryDropdownButton.snp.makeConstraints {
            $0.top.equalTo(ingredientCategoryCollectionView.snp.bottom).offset(11)
            $0.trailing.equalToSuperview().offset(-16)
            
        }
        
        ingredientsCircleCollectionView.snp.makeConstraints {
            $0.top.equalTo(expiryDropdownButton.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
        }
        
        
        floatingButton.snp.makeConstraints {
            $0.width.height.equalTo(68)
            $0.trailing.equalToSuperview().offset(5)
            $0.bottom.equalToSuperview().offset(-80)
        }
        
        manualButton.snp.makeConstraints {
            $0.trailing.equalTo(floatingButton.snp.trailing).offset(-16)
            $0.bottom.equalTo(floatingButton.snp.top).offset(-10)
            $0.width.equalTo(162)
            $0.height.equalTo(40)
        }

        receiptButton.snp.makeConstraints {
            $0.trailing.equalTo(floatingButton.snp.trailing).offset(-16)
            $0.bottom.equalTo(manualButton.snp.top).offset(-10)
            $0.width.equalTo(162)
            $0.height.equalTo(40)
        }
    }
}
