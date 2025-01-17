//
//  IngredientCategoryCollectionViewCell.swift
//  DuruDuru
//
//  Created by 임효진 on 1/9/25.
//

import UIKit

class IngredientCategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Init
    
    static let identifier = "IngredientCategoryCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: 0xF7F7F8, alpha: 1.0)
        layer.cornerRadius = 4
        addComponents()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components
    
    /// 아이콘
    let icon = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    // 카테고리 이름
    let categoryName = UILabel().then {
        $0.font = .systemFont(ofSize: 11)
        $0.textColor = .black
    }
    
    let container = UIView()
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        addSubview(container)
        container.addSubview(icon)
        container.addSubview(categoryName)
    }
    
    /// 오토레이아웃 설정
    private func constraints() {
        icon.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        categoryName.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.right.equalToSuperview()
            $0.left.equalTo(icon.snp.right).offset(4)
        }
        
        container.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(7)
            $0.bottom.equalToSuperview().offset(7)
        }
    }
    
    // MARK: - Configuration
    
    public func configure(model: IngredientCategoryModel) {
        self.icon.image = model.icon
        self.categoryName.text = model.categoryName
    }
}
