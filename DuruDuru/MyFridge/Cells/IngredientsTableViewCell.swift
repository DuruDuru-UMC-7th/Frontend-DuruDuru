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
    weak var cellDelegate: IngredientsTableViewCellDelegate?
    var indexPath: IndexPath?  /// 셀으 인덱스
    
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
        selectionStyle = .none
        self.clipsToBounds = false
        self.contentView.clipsToBounds = false
        addComponents()
        constraints()
        
        self.recipeViewButton.addTarget(self, action: #selector(recipeViewButtonClicked), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.ingredientName.text = nil
    }
    
    // MARK: - Components
    
    /// 식재료 이름
    let ingredientName = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .black
    }
    
    /// 레시피 페이지 버튼
    let recipeViewButton = UIButton().then {
        $0.setImage(.arrow2, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }
    
    /// 레시피
    let recipeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.estimatedItemSize = .init(width: 173, height: 135)
        $0.minimumInteritemSpacing = 8
    }).then {
        $0.isScrollEnabled = true
        $0.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: RecipeCollectionViewCell.identifier)
        $0.showsHorizontalScrollIndicator = false
    }
    
    /// 구분 선
    let dividedLine = UIView().then {
        $0.backgroundColor = UIColor(hex: 0xDCDCDC, alpha: 1.0)
    }
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        addSubview(ingredientName)
        addSubview(recipeViewButton)
        addSubview(recipeCollectionView)
        addSubview(dividedLine)
    }
    
    /// 오토레이아웃 설정
    private func constraints() {
        
        ingredientName.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.left.equalToSuperview().offset(16)
        }
        
        recipeViewButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        recipeCollectionView.snp.makeConstraints {
            $0.top.equalTo(recipeViewButton.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-22)
            $0.height.equalTo(135)
        }
        
        dividedLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(recipeCollectionView.snp.bottom).offset(16.25)
            $0.left.right.equalToSuperview().inset(16)
            
        }
        
    }
    
    // MARK: - Configuration
    
    ///  임시로 재료 카테고리 모델 사용
    public func configure(model: IngredientCategoryModel) {
        self.ingredientName.text = model.categoryName
    }
    
    // MARK: - Function
    
    @objc func recipeViewButtonClicked() {
        guard let indexPath = indexPath else { return }
        cellDelegate?.recipeViewButtonTapped(at: indexPath)
    }
    
}

protocol IngredientsTableViewCellDelegate: AnyObject {
    func recipeViewButtonTapped(at indexPath: IndexPath)
}

