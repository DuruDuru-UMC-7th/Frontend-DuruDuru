//
//  RecipeCollectionViewCell.swift
//  DuruDuru
//
//  Created by 임효진 on 1/10/25.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Init
    
    static let identifier = "RecipeCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components
    
    /// 레시피 대표 이미지
    let titleImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    let container = UIView().then {
        $0.layer.cornerRadius = 10
    }
    
    let likeButton = UIButton().then {
        $0.setImage(UIImage(named: "Heart"), for: .normal)
    }
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        addSubview(container)
        container.addSubview(titleImage)
        container.addSubview(likeButton)
    }
    
    /// 오토레이아웃 설정
    private func constraints() {
        container.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        likeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13)
            $0.trailing.equalToSuperview().offset(-11.6)
            $0.width.height.equalTo(20)
        }
    }
    
    // MARK: - Configuration
    
    public func configure(imageURL: String) {
        guard let url = URL(string: imageURL) else {
            titleImage.image = nil 
            return
        }
        titleImage.kf.setImage(with: url)
    }
}
