//
//  IngredientsCircleCollectionViewCell.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/12/25.
//

import UIKit
import SnapKit

class IngredientsCircleCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Init
    
    static let identifier = "IngredientsCircleCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = frame.size.width / 2 // 셀을 동그라미로 만들기
        contentView.clipsToBounds = true
        contentView.backgroundColor = .lightGray
        addComponents()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components
    
    /// 남은 소비기한 라벨
    private let expiryLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 14)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    /// 식재료 이름 라벨
    private let ingredientNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    // MARK: - Add Components
    
    private func addComponents() {
        contentView.addSubview(expiryLabel)
        contentView.addSubview(ingredientNameLabel)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        expiryLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.centerX.equalToSuperview()
        }
        
        ingredientNameLabel.snp.makeConstraints {
            $0.top.equalTo(expiryLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Configure Cell
    
    func configure(with model: IngredientModel) {
        expiryLabel.text = model.daysRemaining
        ingredientNameLabel.text = model.name
    }
}

