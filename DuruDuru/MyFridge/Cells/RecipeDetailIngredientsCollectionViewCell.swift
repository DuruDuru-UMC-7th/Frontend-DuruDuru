//
//  TagCollectionViewCell.swift
//  DuruDuru
//
//  Created by 임효진 on 1/21/25.
//

import UIKit

class RecipeDetailIngredientsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Init
    
    static let identifier = "RecipeDetailIngredientsCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: 0xEAEBEC, alpha: 1.0)
        layer.cornerRadius = 4
        addComponents()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components
    
    let tagLabel = UILabel().then {
        $0.textAlignment = .center
        $0.clipsToBounds = true
        $0.font = .systemFont(ofSize: 11)
    }
    
    // MARK: - Constaints & Add Function
    
    private func addComponents() {
        addSubview(tagLabel)
    }
    
    /// 오토레이아웃 설정
    private func constraints() {
        tagLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(6)
            $0.right.left.equalToSuperview().inset(12)
        }
    }
    
    public func configure(tag: String) {
        print("CELL: ", tag)
        tagLabel.text = tag
    }
}
