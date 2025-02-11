//
//  IngredientView.swift
//  DuruDuru
//
//  Created by 임효진 on 1/8/25.
//

import UIKit

class IngredientsView: UIView {
    
    // MARK: - Components
    
    
    /// 검색창 라벨
    let searchBarLabel = UILabel().then {
        $0.text = "필요한 식재료를 검색하세요"
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.6)
    }
    
    let searchBarContainer = UIView().then {
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.backgroundColor = UIColor(red: 118/255, green: 118/255, blue: 128/255, alpha: 0.12)
    }
    
    /// 검색 바
    let searchBar = UISearchBar().then {
        $0.placeholder = "필요한 식재료를 검색하세요"
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
        $0.minimumInteritemSpacing = 8 // 좌우 간격
        $0.minimumLineSpacing = 12 // 상하 간격
    }).then {
        $0.backgroundColor = .clear
        $0.register(IngredientsCircleCollectionViewCell.self, forCellWithReuseIdentifier: IngredientsCircleCollectionViewCell.identifier)
        $0.showsVerticalScrollIndicator = false
    }
    
    /// 플로팅 버튼
    let floatingButton = UIButton().then {
        $0.setImage(UIImage(named: "exchangeFloating"), for: .normal)
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 0.3
        $0.layer.shadowRadius = 7
    }
    
    /// 영수등으로 추가하기 버튼
    let receiptButton = UIButton().then {
        let configuration = UIButton.Configuration.plain()
        $0.configuration = configuration
        $0.configuration?.image = UIImage(named: "AddRecipe")
        $0.configuration?.imagePlacement = .leading
        $0.configuration?.imagePadding = 5
        $0.configuration?.attributedTitle = AttributedString("영수증으로 추가하기", attributes: AttributeContainer([.font: UIFont.boldSystemFont(ofSize: 14.5), .foregroundColor: UIColor.white]))
        $0.backgroundColor = UIColor(hex: 0x00C269)
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        $0.isHidden = true
    }
    
    /// 직접 추가하기 버튼
    let manualButton = UIButton().then {
        let configuration = UIButton.Configuration.plain()
        $0.configuration = configuration
        $0.configuration?.image = UIImage(named: "AddButton")
        $0.configuration?.imagePlacement = .leading
        $0.configuration?.imagePadding = 5
        $0.configuration?.attributedTitle = AttributedString("직접 추가하기", attributes: AttributeContainer([.font: UIFont.boldSystemFont(ofSize: 14.5), .foregroundColor: UIColor.white]))
        $0.backgroundColor = UIColor(hex: 0x00C269)
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        $0.isHidden = true
    }
    
    let darkBackgroundView = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        $0.isHidden = true // 처음에는 숨김
    }
    
    // 메뉴 뷰
    let optionsView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 30
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.isHidden = true
    }
    
    let filterLabel = UILabel().then {
        $0.text = "정렬"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .black
    }
    
    let recentFilter = UIButton().then {
        $0.setTitle("최신 등록순", for: .normal)
        $0.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    let nearExpiryDateFilter = UIButton().then {
        $0.setTitle("소비기한 임박순", for: .normal)
        $0.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    let farExpiryFilter = UIButton().then {
        $0.setTitle("소비기한 여유순", for: .normal)
        $0.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    let menuCloseButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .black
    }
    
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
        addSubview(searchBarContainer)
        searchBarContainer.addSubview(searchBar)
        addSubview(allButton)
        addSubview(ingredientCategoryCollectionView)
        addSubview(expiryDropdownButton)
        addSubview(ingredientsCircleCollectionView)
        addSubview(floatingButton)
        addSubview(receiptButton)
        addSubview(manualButton)
        addSubview(darkBackgroundView)
        addSubview(optionsView)
        optionsView.addSubview(filterLabel)
        optionsView.addSubview(recentFilter)
        optionsView.addSubview(nearExpiryDateFilter)
        optionsView.addSubview(farExpiryFilter)
        optionsView.addSubview(menuCloseButton)
    }
    
    // MARK: - Setup Constraints
    
    /// 오토레이아웃 설정
    private func setupConstraints() {
        
        searchBarContainer.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
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
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.left.equalTo(allButton.snp.right).offset(8)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(26)
        }
        
        expiryDropdownButton.snp.makeConstraints {
            $0.top.equalTo(ingredientCategoryCollectionView.snp.bottom).offset(11)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        ingredientsCircleCollectionView.snp.makeConstraints {
            $0.top.equalTo(expiryDropdownButton.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview()
        }
        
        
        floatingButton.snp.makeConstraints {
            $0.width.height.equalTo(95)
            $0.trailing.equalToSuperview().offset(-5)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        manualButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(floatingButton.snp.top).offset(-10)
            $0.width.equalTo(126)
            $0.height.equalTo(40)
        }
        
        receiptButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(manualButton.snp.top).offset(-10)
            $0.width.equalTo(160)
            $0.height.equalTo(40)
        }
        
        darkBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview() // 전체 화면을 채움
        }
        
        optionsView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(185)
        }
        
        filterLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.leading.equalToSuperview().offset(16)
        }
        
        recentFilter.snp.makeConstraints {
            $0.top.equalTo(filterLabel.snp.bottom).offset(21)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(17)
        }
        
        nearExpiryDateFilter.snp.makeConstraints {
            $0.top.equalTo(recentFilter.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(17)
        }
        
        farExpiryFilter.snp.makeConstraints {
            $0.top.equalTo(nearExpiryDateFilter.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(17)
        }
        
        menuCloseButton.snp.makeConstraints {
            $0.centerY.equalTo(filterLabel)
            $0.trailing.equalToSuperview().offset(-16)
            $0.width.height.equalTo(24)
        }
    }
}
