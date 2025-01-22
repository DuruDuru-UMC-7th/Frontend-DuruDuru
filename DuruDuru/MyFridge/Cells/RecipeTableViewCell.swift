//
//  RecipeTableViewCell.swift
//  DuruDuru
//
//  Created by 임효진 on 1/13/25.
//

import UIKit
import SwiftUI

class RecipeTableViewCell: UITableViewCell {
    
    // MARK: - Init
    
    static let identifier: String = "recipeTableViewCell"
    var tags = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    private func setupDelegate(){
//        tagCollectionView.delegate = self
//        tagCollectionView.dataSource = self
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .default
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        selectionStyle = .none
        addComponents()
        constraints()
//        setupDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        updateCollectionViewHeight()
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleImage.image = nil
        self.recipeName.text = nil
    }
    
    // MARK: - Components
    
    /// 대표 이미지
    let titleImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }
    
    let container = UIView().then {
        $0.layer.cornerRadius = 12
    }
    
    /// 좋아요 버튼
    let likeButton = UIButton().then {
        $0.setImage(UIImage(named: "Heart"), for: .normal)
    }
    
    /// 레시피 이름
    let recipeName = UILabel().then {
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .black
    }
    
//    /// 태그
//    let tagCollectionView = UICollectionView(frame: .zero, collectionViewLayout: LeftAlignedCollectionViewFlowLayout().then {
//        $0.minimumInteritemSpacing = 4
//        $0.minimumLineSpacing = 4
//        $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }).then {
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.backgroundColor = .clear
//        $0.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
//    }
    
    /// 태크 스택 뷰
    let tagsStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
    }
    
    /// 구분 선
    let dividedLine = UIView().then {
        $0.backgroundColor = UIColor(hex: 0xDCDCDC, alpha: 1.0)
    }
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        addSubview(container)
        addSubview(recipeName)
        addSubview(tagsStackView)
        container.addSubview(titleImage)
        container.addSubview(likeButton)
        addSubview(dividedLine)
    }
    
    /// 오토레이아웃 설정
    private func constraints() {
        container.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(158.57)
        }
        
        titleImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        likeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13)
            $0.trailing.equalToSuperview().offset(-11.6)
            $0.width.height.equalTo(20)
        }
        
        recipeName.snp.makeConstraints {
            $0.top.equalTo(container.snp.bottom).offset(12)
            $0.left.equalToSuperview()
        }
        
        tagsStackView.snp.makeConstraints {
            $0.top.equalTo(recipeName.snp.bottom).offset(5)
            $0.left.equalToSuperview()
        }
        
        dividedLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(tagsStackView.snp.bottom).offset(23)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
            
        }
    }
    
    public func configure(recipe: RecipeModel) {
        if let imageURL = URL(string: recipe.titleImage) {
            titleImage.kf.setImage(with: imageURL)
        }
        recipeName.text = recipe.recipeName
        tags = recipe.tags
        
        for tag in tags {
            let tagLabel = createTagLabel(text: tag)
            tagsStackView.addArrangedSubview(tagLabel)
        }
    }
    
    private func createTagLabel(text: String) -> UIView {
        let containerView = UIView().then {
            $0.backgroundColor = UIColor(hex: 0xEAEBEC)
            $0.layer.cornerRadius = 4
            $0.layer.masksToBounds = true
        }
        
        let label = UILabel().then {
            $0.text = text
            $0.font = .systemFont(ofSize: 11)
            $0.textAlignment = .center
        }
        
        containerView.addSubview(label)
        
        /// 레이블의 패딩 설정
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(6)
            $0.trailing.equalToSuperview().offset(-6)
            $0.top.equalToSuperview().offset(4)
            $0.bottom.equalToSuperview().offset(-4)
        }
        
        return containerView
    }
}

//extension RecipeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return tags.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as! TagCollectionViewCell
//        cell.tagLabel.text = tags[indexPath.item]
//        return cell
//    }
//    
//    // UICollectionViewDelegateFlowLayout
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let text = tags[indexPath.item]
//        let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 11)]).width + 16 // Padding 추가
//        return CGSize(width: width, height: 22) // 높이는 고정
//    }
//    
//    func updateCollectionViewHeight() {
//        // UICollectionView의 콘텐츠 높이에 맞추어 높이를 업데이트
//        tagCollectionView.layoutIfNeeded() // 레이아웃을 즉시 계산
//        let contentHeight = tagCollectionView.collectionViewLayout.collectionViewContentSize.height
//        
//        tagCollectionView.snp.updateConstraints { make in
//            make.height.equalTo(contentHeight) // 콘텐츠 높이에 맞게 높이 설정
//        }
//    }
//    
//    func collectionViewHeight() -> CGFloat {
//        return tagCollectionView.collectionViewLayout.collectionViewContentSize.height
//    }
//}
