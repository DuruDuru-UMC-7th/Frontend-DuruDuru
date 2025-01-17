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
    var indexPath: IndexPath?  /// 셀 인덱스
    var recipes: [RecipeModel] = [] /// 레시피 더미데이터 변수
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupDelegate(){
        recipeCollectionView.delegate = self
        recipeCollectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        selectionStyle = .none
        self.clipsToBounds = false
        self.contentView.clipsToBounds = false
        addComponents()
        constraints()
        setupDelegate()
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
        $0.itemSize = CGSize(width: 173, height: 130)
        $0.minimumInteritemSpacing = 16
    }).then {
        $0.backgroundColor = .clear
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
            $0.height.equalTo(130)
        }
        
        dividedLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(recipeCollectionView.snp.bottom).offset(16.25)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
            
        }
    }
    
    @objc func recipeViewButtonClicked() {
        guard let indexPath = indexPath else { return }
        cellDelegate?.recipeViewButtonTapped(at: indexPath)
    }
    
    // MARK: - Configuration
    
    public func configure(model: IngredientModel) {
        self.recipes = model.recipes
        self.ingredientName.text = model.name
    }
    
}

protocol IngredientsTableViewCellDelegate: AnyObject {
    func recipeViewButtonTapped(at indexPath: IndexPath)
}

extension IngredientsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCollectionViewCell.identifier, for: indexPath) as! RecipeCollectionViewCell
        
        if let imageURL = URL(string: recipes[indexPath.row].titleImage) {
            cell.titleImage.kf.setImage(with: imageURL)
        }

        return cell
    }
}


