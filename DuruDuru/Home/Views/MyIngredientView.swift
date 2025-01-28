//
//  HomeHeaderWithIngredientView.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/25/25.
//

import UIKit
import SnapKit

class MyIngredientView: UIView {
    
    // MARK: - Properties
    
    private let ingredients: [MyIngredientModel] = MyIngredientModel.dummyIngredient()
    
    // MARK: - UI Components
    
    /// 상단 로고
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "HomeLogo")
        return imageView
    }()
    
    /// 상단 알림 아이콘
    private lazy var bellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Bell")
        return imageView
    }()
    
    /// "나의 식재료" 제목
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "나의 식재료"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    /// "냉장고 열기" 버튼
    private let openFridgeButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "Right")
        config.imagePlacement = .trailing
        config.imagePadding = 8
        config.baseForegroundColor = .gray
        config.attributedTitle = AttributedString("냉장고 열기", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 12)]))
        button.configuration = config
        return button
    }()
    
    /// 컬렉션 뷰 레이아웃 설정
    private let collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        return layout
    }()
    
    /// 컬렉션 뷰
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(MyIngredientCollectionViewCell.self, forCellWithReuseIdentifier: MyIngredientCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        addSubview(logoImage)
        addSubview(bellImage)
        addSubview(titleLabel)
        addSubview(openFridgeButton)
        addSubview(collectionView)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        /// 로고 및 알림 아이콘 배치
        logoImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(16.5)
            $0.width.equalTo(96)
            $0.height.equalTo(24)
        }
        
        bellImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.right.equalToSuperview().offset(-16.5)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        /// 나의 식재료 제목 & 버튼 배치
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(16)
        }
        
        openFridgeButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.right.equalToSuperview().offset(-16)
        }
        
        /// 컬렉션 뷰 배치
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(103) // 이미지 포함 높이
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension MyIngredientView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MyIngredientCollectionViewCell.identifier,
            for: indexPath
        ) as? MyIngredientCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: ingredients[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 73, height: 103) // 셀 크기 조정
    }
}
