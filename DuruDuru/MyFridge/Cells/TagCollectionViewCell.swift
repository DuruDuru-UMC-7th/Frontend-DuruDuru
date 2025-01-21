//
//  TagCollectionViewCell.swift
//  DuruDuru
//
//  Created by 임효진 on 1/21/25.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Init
    
    static let identifier = "TagCollectionViewCell"
    
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

    let tagLbl = UILabel().then {
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 11)
        
    }
    
    // MARK: - Constaints & Add Function
    
    private func addComponents() {
        addSubview(tagLbl)
    }
    
    /// 오토레이아웃 설정
    private func constraints() {
        tagLbl.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - Configuration
    
    public func configure(tag: String) {
        self.tagLbl.text = tag
    }
}
