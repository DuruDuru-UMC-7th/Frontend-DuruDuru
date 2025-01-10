//
//  IngredientsTableViewCell.swift
//  DuruDuru
//
//  Created by 임효진 on 1/10/25.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {
    
    // MARK: - Init
    
    static let identifier: String = "IngredientsTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        addComponents()
        constraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.icon.image = nil
        self.ingredientName.text = nil
    }
    
    // MARK: - Components
    
    /// 아이콘
    let icon = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    /// 카테고리 이름
    let ingredientName = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .black
    }
    
    /// 레시피 페이지 버튼
    private let recipeViewButton = UIButton().then {
        $0.setImage(.arrow2, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 0
    }
    
    /// 레시피 
    let recipeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.estimatedItemSize = .init(width: 173, height: 135)
        $0.minimumInteritemSpacing = 8
    }).then {
        //$0.backgroundColor = .black
        $0.isScrollEnabled = true
        $0.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: RecipeCollectionViewCell.identifier)
        $0.showsHorizontalScrollIndicator = false
    }
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        addSubview(icon)
        addSubview(ingredientName)
        addSubview(recipeViewButton)
        addSubview(recipeCollectionView)
    }
    
    /// 오토레이아웃 설정
    private func constraints() {
        icon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28)
            $0.left.equalToSuperview().offset(16)
        }
        
        ingredientName.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.left.equalTo(icon.snp.right).offset(7)
        }
        
        recipeViewButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.right.equalToSuperview().offset(-16)
        }
        
        recipeCollectionView.snp.makeConstraints {
            $0.top.equalTo(ingredientName.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-22)
            $0.height.equalTo(135)
        }
        
    }
    
    // MARK: - Configuration
    
    ///  임시로 재료 카테고리 모델 사용
    public func configure(model: IngredientCategoryModel) {
        self.icon.image = model.icon
        self.ingredientName.text = model.categoryName
    }

}
