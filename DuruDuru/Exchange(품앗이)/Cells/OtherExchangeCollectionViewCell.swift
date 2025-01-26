//
//  OtherExchangeCollectionViewCell.swift
//  DuruDuru
//
//  Created by 임효진 on 1/26/25.
//

import UIKit

class OtherExchangeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Init
    
    static let identifier = "OtherExchangeCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
        constraints()
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 대표 이미지
    let titleImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.image = .thumbnail
    }
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        addSubview(titleImage)
    }
    
    /// 오토레이아웃 설정
    private func constraints() {
        titleImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
