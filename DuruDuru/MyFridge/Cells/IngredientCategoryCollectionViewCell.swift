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
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components
    
    /// 아이콘
    let icon = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    /// 카테고리 이름
    let categoryName = UILabel().then {
        $0.font = .systemFont(ofSize: 11, weight: .medium)
        $0.textColor = .black
    }
    
    /// StackView
    let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 6
    }

    // MARK: - Constraints & Add Function
    
    private func addComponents() {
        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(categoryName)
        addSubview(stackView)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.right.equalToSuperview().inset(8)
        }

        icon.snp.makeConstraints {
            $0.width.height.equalTo(20)
        }
    }
    
    // MARK: - Configuration
    
    public func configure(model: IngredientCategoryModel) {
        self.icon.image = model.icon
        self.categoryName.text = model.categoryName
    }
}
