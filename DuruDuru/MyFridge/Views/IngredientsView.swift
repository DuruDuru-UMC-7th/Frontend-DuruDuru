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
    
    /// 검색창
    let searchBar = UITextField().then {
        $0.backgroundColor = UIColor(red: 118/255, green: 118/255, blue: 128/255, alpha: 0.12)
        $0.layer.cornerRadius = 10
    }
    
    /// 검색창 이미지
    let searchImageView = UIImageView().then {
        $0.image = UIImage(named: "Search")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
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
        $0.minimumLineSpacing = 7 // 상하 간격
        $0.estimatedItemSize = .init(width: 118, height: 145)// 셀 크기
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
    
    /// 팝업 버튼 1
    let receiptButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "AddRecipe"), for: .normal)
        button.isHidden = true // 초기 상태 숨김
        return button
    }()

    /// 팝업 버튼 2
    let manualButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "AddButton"), for: .normal)
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
        searchBar.addSubview(searchImageView)
        searchBar.addSubview(searchBarLabel)
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
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(36)
        }
        
        searchImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(7)
            $0.bottom.equalToSuperview().offset(-7)
            $0.left.equalToSuperview().offset(8)
        }
        
        searchBarLabel.snp.makeConstraints {
            $0.left.equalTo(searchImageView.snp.right).offset(5)
            $0.top.equalToSuperview().offset(7)
            $0.bottom.equalToSuperview().offset(-7)
        }
        
        allButton.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
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
            $0.width.height.equalTo(68)
            $0.trailing.equalToSuperview().offset(-5)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        manualButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-0)
            $0.bottom.equalTo(floatingButton.snp.top).offset(-10)
            $0.width.equalTo(162)
            $0.height.equalTo(40)
        }

        receiptButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(manualButton.snp.top).offset(-10)
            $0.width.equalTo(162)
            $0.height.equalTo(40)
        }
    }
}
