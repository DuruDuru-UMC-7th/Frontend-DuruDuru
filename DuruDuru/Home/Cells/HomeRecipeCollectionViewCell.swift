//
//  RecipeCollectionViewCell.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/28/25.
//

import UIKit
import SnapKit

class HomeRecipeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Init
    
    static let identifier = "RecipeCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components
    
    /// 음식 이미지
    private let foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8 // 이미지 모서리를 둥글게
        return imageView
    }()
    
    /// 음식 제목
    private let foodTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .left // 왼쪽 정렬
        return label
    }()
    
    /// 재료 태그 컨테이너 (스택뷰)
    private let ingredientsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill // 가로 너비 맞춤
        return stackView
    }()
    
    // MARK: - Setup UI
    
    private func setupUI() {
        contentView.addSubview(foodImageView)
        contentView.addSubview(foodTitleLabel)
        contentView.addSubview(ingredientsStackView)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        foodImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.equalTo(144)
            $0.height.equalTo(108)
        }
        
        foodTitleLabel.snp.makeConstraints {
            $0.top.equalTo(foodImageView.snp.bottom).offset(12)
            $0.left.equalToSuperview()
            $0.width.equalTo(144)
            $0.height.equalTo(22)
        }
        
        ingredientsStackView.snp.makeConstraints {
            $0.top.equalTo(foodTitleLabel.snp.bottom).offset(11)
            $0.left.equalToSuperview().inset(4)
            $0.right.equalToSuperview().inset(4)
            $0.height.equalTo(20)
        }
    }
    
    // MARK: - Configuration
    
    public func configure(with model: HomeRecipeModel) {
        foodImageView.image = UIImage(named: model.imageName)
        foodTitleLabel.text = model.title
        setupIngredients(ingredients: model.ingredients)
    }
    
    private func setupIngredients(ingredients: [String]) {
        // 기존 태그 뷰 제거
        ingredientsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // 최대 3개의 재료를 표시
        let maxVisibleIngredients = 3
        let visibleIngredients = Array(ingredients.prefix(maxVisibleIngredients))
        let additionalCount = ingredients.count - visibleIngredients.count
        
        // 첫 2개의 재료 태그 (초록색)
        for (index, ingredient) in visibleIngredients.enumerated() {
            let label: UILabel
            if index < 2 {
                label = createIngredientLabel(
                    with: ingredient,
                    textColor: UIColor(hex: 0x00C269),
                    backgroundColor: UIColor(hex: 0x00C269, alpha: 0.2)
                )
            } else {
                label = createIngredientLabel(
                    with: ingredient,
                    textColor: UIColor(hex: 0xA0A0A0),
                    backgroundColor: UIColor(hex: 0xE0E0E0, alpha: 0.5)
                )
            }
            ingredientsStackView.addArrangedSubview(label)
        }
        
        // 추가 재료가 있다면 "+N" 태그 추가 (회색)
        if additionalCount > 0 {
            let moreLabel = createIngredientLabel(
                with: "+\(additionalCount)",
                textColor: UIColor(hex: 0xA0A0A0),
                backgroundColor: UIColor(hex: 0xE0E0E0, alpha: 0.5)
            )
            ingredientsStackView.addArrangedSubview(moreLabel)
        }
    }
    
    // 재료 태그 레이블 생성 (크기 자동 조절)
    private func createIngredientLabel(with text: String, textColor: UIColor, backgroundColor: UIColor) -> UILabel {
        let label = PaddedLabel()
        label.text = text
        label.font = .systemFont(ofSize: 12)
        label.textColor = textColor
        label.backgroundColor = backgroundColor
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        
        // 최소 크기 지정 & 자동 크기 조정
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.snp.makeConstraints { make in
            make.height.equalTo(14) // 높이는 고정
        }
        
        return label
    }
}

// MARK: - UILabel 확장 (패딩 적용)
class PaddedLabel: UILabel {
    private let padding = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
    
    override func drawText(in rect: CGRect) {
        let insetRect = rect.inset(by: padding)
        super.drawText(in: insetRect)
    }
    
    override var intrinsicContentSize: CGSize {
        let superSize = super.intrinsicContentSize
        let width = max(superSize.width + padding.left + padding.right, 20) // 최소 width: 20 유지
        let height = max(superSize.height + padding.top + padding.bottom, 14) // 최소 height: 14 유지
        return CGSize(width: width, height: height)
    }
}

// MARK: - UIColor Extension for HEX Support
extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255.0,
            green: CGFloat((hex >> 8) & 0xFF) / 255.0,
            blue: CGFloat(hex & 0xFF) / 255.0,
            alpha: alpha
        )
    }
}
