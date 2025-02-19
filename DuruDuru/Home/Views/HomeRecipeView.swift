//
//  HomeRecipeView.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/26/25.
//

import UIKit
import SnapKit

class HomeRecipeView: UIView {
    
    private var recipes: [HomeRecipeModel] = []
    
    // MARK: - Components
    
    /// 제목 레이블
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "남은 재료로 뚝딱 한끼"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    /// "레시피 더 보러가기" 버튼
    let seeMoreButton = UIButton().then {
        let configuration = UIButton.Configuration.plain()
        $0.configuration = configuration
        $0.configuration?.image = UIImage(named: "Right")
        $0.configuration?.imagePlacement = .trailing // 화살표를 텍스트 오른쪽에 배치
        $0.configuration?.imagePadding = 8 // 텍스트와 이미지 간격
        $0.configuration?.baseForegroundColor = .gray
        $0.configuration?.attributedTitle = AttributedString("레시피 더 보러가기", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 12)]))
    }
    
    /// 컬렉션 뷰 레이아웃 설정
    private let collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        return layout
    }()
    
    /// 레시피 목록을 위한 컬렉션 뷰
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(HomeRecipeCollectionViewCell.self, forCellWithReuseIdentifier: HomeRecipeCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    /// 더미 데이터 (HomeRecipeModel에서 관리)
    //private let recipes = HomeRecipeModel.dummyRecipe()
    
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
        addSubview(titleLabel)
        addSubview(seeMoreButton)
        addSubview(collectionView)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(16)
        }
        
        seeMoreButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.right.equalToSuperview().offset(-16)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(17)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(176)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension HomeRecipeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return recipes.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(
//            withReuseIdentifier: HomeRecipeCollectionViewCell.identifier,
//            for: indexPath
//        ) as? HomeRecipeCollectionViewCell else {
//            return UICollectionViewCell()
//        }
//        cell.configure(with: recipes[indexPath.item])
//        return cell
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 144, height: 176) // 셀 크기
    }
    
    func updateRecipes(_ newRecipes: [HomeRecipeModel]) {
        self.recipes = newRecipes
        self.collectionView.reloadData()
    }
    
    // MARK: - UICollectionView DataSource 수정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeRecipeCollectionViewCell.identifier,
            for: indexPath
        ) as? HomeRecipeCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: recipes[indexPath.item])
        return cell
    }
    
}

// MARK: - SwiftUI Preview

