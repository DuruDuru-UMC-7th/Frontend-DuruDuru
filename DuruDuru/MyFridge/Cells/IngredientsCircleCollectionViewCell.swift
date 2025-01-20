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
    
    private let circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 59 // 원의 반지름
        view.clipsToBounds = true
        return view
    }()
    
    /// 남은 소비기한 라벨 (원 내부)
    private let expiryLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 14)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    /// 식재료 이름 라벨 (원 아래)
    private let ingredientNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Add Components
    
    private func addComponents() {
        addSubview(circleView)
        circleView.addSubview(expiryLabel)
        addSubview(ingredientNameLabel)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        // 원의 크기와 위치
        circleView.snp.makeConstraints {
            $0.top.right.left.equalToSuperview()
            $0.height.width.equalTo(118)
        }
        
        // 원 내부 텍스트 (소비기한)
        expiryLabel.snp.makeConstraints {
            $0.center.equalTo(circleView) // 원의 중심
        }
        
        // 원 아래 텍스트 (식재료 이름)
        ingredientNameLabel.snp.makeConstraints {
            $0.top.equalTo(circleView.snp.bottom)
            // 원 아래에 위치
            $0.centerX.equalToSuperview() // 수평 중앙 정렬
            $0.bottom.equalToSuperview().offset(-5)
        }
    }
    
    // MARK: - Configure Cell
    
    func configure(with model: IngredientsModel) {
        expiryLabel.text = model.daysRemaining // e.g., "D-3"
        ingredientNameLabel.text = model.name // e.g., "콩나물"
    }
}
