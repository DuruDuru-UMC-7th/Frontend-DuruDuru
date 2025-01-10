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
    
    // MARK: - Property

    /// 내 식재료를 활용한 레시피
    private let myRecipe = UILabel().then {
        $0.text = "내 식재료를 활용한 레시피"
        $0.font = .boldSystemFont(ofSize: 18)
    }
    
    let allButton = UIButton().then {
        $0.setImage(.allCategory, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.backgroundColor = UIColor(ciColor: CIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1.0))
        $0.layer.cornerRadius = 10
    }
    
    let ingredientCategoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.estimatedItemSize = .init(width: 66, height: 26)
        $0.minimumInteritemSpacing = 8
    }).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = true
        $0.register(IngredientCategoryCollectionViewCell.self, forCellWithReuseIdentifier: IngredientCategoryCollectionViewCell.identifier)
        $0.showsHorizontalScrollIndicator = false
    }
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        addSubview(myRecipe)
        addSubview(allButton)
        addSubview(ingredientCategoryCollectionView)
    }
    
    /// 오토레이아웃 설정
    private func constraints() {
        myRecipe.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28)
            $0.leading.equalToSuperview().offset(16)
        }
        
        allButton.snp.makeConstraints {
            $0.top.equalTo(myRecipe.snp.bottom).offset(24)
            $0.left.equalToSuperview().offset(16)
            $0.height.width.equalTo(26)
        }
        
        ingredientCategoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(myRecipe.snp.bottom).offset(24)
            $0.left.equalTo(allButton.snp.right).offset(8)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(26)
        }
    }
}
