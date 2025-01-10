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
        backgroundColor = UIColor(ciColor: CIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1.0))
        layer.cornerRadius = 10
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
    }
    
    let container = UIView()
    
    let likeButton = UIButton().then {
        $0.setImage(UIImage(named: "heart"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
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
            $0.edges.equalToSuperview()
        }
        
        likeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5) // 상단 여백
            $0.trailing.equalToSuperview().offset(-5) // 우측 여백
            $0.width.height.equalTo(20) 
        }
    }
}
