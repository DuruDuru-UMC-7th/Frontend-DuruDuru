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
        view.backgroundColor = .clear
        view.layer.cornerRadius = 59 // 원의 반지름
        view.clipsToBounds = true
        return view
    }()
    
    var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "imageNotFound")
        $0.clipsToBounds = true
    }
    
    /// 식재료 이름 라벨 (원 아래)
    private let ingredientNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    private let count = UILabel().then {
        $0.backgroundColor = UIColor(hex: 0x4BD9B3, alpha: 1.0)
        $0.font = .boldSystemFont(ofSize: 11)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.borderWidth = 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleView.layer.cornerRadius = circleView.frame.width / 2 // 동적으로 원형 설정
    }
    
    // MARK: - Add Components
    
    private func addComponents() {
        addSubview(circleView)
        circleView.addSubview(imageView)
        addSubview(count)
        addSubview(ingredientNameLabel)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        // 원의 크기와 위치
        circleView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(circleView.snp.width) // 원형 유지
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // 원 아래 텍스트 (식재료 이름)
        ingredientNameLabel.snp.makeConstraints {
            $0.top.equalTo(circleView.snp.bottom).offset(8) // 이름이 보일 공간 확보
            $0.centerX.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview().offset(-5)
        }
        
        count.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.width.height.equalTo(30)
        }
    }
    
    // MARK: - Configure Cell
    
    func configure(with model: MyIngredient) {
        ingredientNameLabel.text = model.ingredientName
        if let imageURL = URL(string: model.ingredientImageUrl!) {
            imageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "imageNotFound"))
        } else {
            imageView.image = UIImage(named: "imageNotFound") 
        }
        count.text = String(model.count)
    }
    
    func configureSimple(with minorCategory: String) {
        ingredientNameLabel.text = minorCategory // e.g., "우유"
    }
}
