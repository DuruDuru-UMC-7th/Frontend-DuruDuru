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
    
    var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleView.layer.cornerRadius = circleView.frame.width / 2 // 동적으로 원형 설정
    }
    
    // MARK: - Add Components
    
    private func addComponents() {
        addSubview(circleView)
        circleView.addSubview(expiryLabel)
        circleView.addSubview(imageView)
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
        
        // 원 내부 텍스트 (소비기한)
        expiryLabel.snp.makeConstraints {
            $0.center.equalTo(circleView) // 원의 중심
        }
        
        // 원 아래 텍스트 (식재료 이름)
        ingredientNameLabel.snp.makeConstraints {
            $0.top.equalTo(circleView.snp.bottom).offset(8) // 이름이 보일 공간 확보
            $0.centerX.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview().offset(-5)
        }
    }
    
    // MARK: - Configure Cell
    
    func configure(with model: IngredientsModel) {
        expiryLabel.text = "D-3" // e.g., "D-3"
        ingredientNameLabel.text = model.name // e.g., "콩나물"
//        imageView.image = UIImage(named: model.image) // e.g., "콩나물"
    }
    
    func configureSimple(with minorCategory: String) {
        expiryLabel.text = "" // 단순 모델에서는 소비기한 표시 안 함
        ingredientNameLabel.text = minorCategory // e.g., "우유"
    }
}
