//
//  MyIngredientCollectionViewCell.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/26/25.
//

import UIKit
import SnapKit
import Kingfisher

class MyIngredientCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Init
    
    static let identifier = "MyIngredientCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    
    private let ingredientImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true // 이미지가 뷰의 경계를 넘어가지 않도록 설정
        return imageView
    }()
    
    private let ingredientNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: - Setup UI
    
    private func setupUI() {
        contentView.addSubview(ingredientImageView)
        contentView.addSubview(ingredientNameLabel)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        ingredientImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(80) // 이미지 크기
        }
        
        ingredientNameLabel.snp.makeConstraints {
            $0.top.equalTo(ingredientImageView.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(4)
        }
        
        // 원형 이미지 적용
        ingredientImageView.layer.cornerRadius = 40 // 이미지 크기(80)의 절반
    }
    
    // MARK: - Configuration
    
    func configure(with model: MyIngredientModel) {
        ingredientNameLabel.text = model.ingredientName

        if let imageUrl = model.ingredientImageUrl, let url = URL(string: imageUrl) {
            ingredientImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        } else {
            ingredientImageView.image = UIImage(named: "placeholder")  // 기본 이미지 설정
        }
    }
}
