//
//  CooksView.swift
//  DuruDuru
//
//  Created by 임효진 on 1/8/25.
//

import UIKit

class MyCookingView: UIView {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addComponents()
        constraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components
    
    /// 검색창 라벨
    let searchBarLabel = UILabel().then {
        $0.text = "사용할 식재료를 검색하세요"
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
        $0.minimumInteritemSpacing = 7
    }).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.register(IngredientCategoryCollectionViewCell.self, forCellWithReuseIdentifier: IngredientCategoryCollectionViewCell.identifier)
        $0.showsHorizontalScrollIndicator = false
    }
    
    /// 내 식재료를 활용한 레시피
    private let myRecipe = UILabel().then {
        $0.text = "내 식재료를 활용한 레시피"
        $0.font = .boldSystemFont(ofSize: 18)
    }
    
    /// 식재료 테이블 뷰
    public let ingredientsTableView = UITableView().then {
        $0.register(IngredientsTableViewCell.self, forCellReuseIdentifier: IngredientsTableViewCell.identifier)
        $0.separatorStyle = .none
        $0.allowsSelection = false
    }
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        addSubview(searchBar)
        searchBar.addSubview(searchImageView)
        searchBar.addSubview(searchBarLabel)
        addSubview(allButton)
        addSubview(ingredientCategoryCollectionView)
        addSubview(myRecipe)
        addSubview(ingredientsTableView)
    }
    
    /// 오토레이아웃 설정
    private func constraints() {
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
            $0.left.equalToSuperview().offset(16)
            $0.height.width.equalTo(26)
        }
        
        ingredientCategoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.left.equalTo(allButton.snp.right).offset(7)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(26)
        }
        
        myRecipe.snp.makeConstraints {
            $0.top.equalTo(ingredientCategoryCollectionView.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(16)
        }
        
        ingredientsTableView.snp.makeConstraints {
            $0.top.equalTo(myRecipe.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
}
