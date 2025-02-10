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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        selectionStyle = .none
        addComponents()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        $0.setImage(UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate), for: .normal) // 채워진 하트 이미지 사용
        $0.tintColor = .white
    }
    
    /// 레시피 이름
    let recipeName = UILabel().then {
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .black
    }
    
    /// 태크 스택 뷰
    let tagsStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
    }
    
    /// 구분 선
    let dividedLine = UIView().then {
        $0.backgroundColor = UIColor(hex: 0xDCDCDC, alpha: 1.0)
    }
    
    // MARK: - Function
    
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
//        if let imageURL = URL(string: recipe.titleImage) {
//            titleImage.kf.setImage(with: imageURL)
//        }
        titleImage.image = UIImage(named: recipe.titleImage)
        recipeName.text = recipe.recipeName
        tags = recipe.tags
        
        for tag in tags {
            let tagLabel = createTagLabel(text: tag)
            tagsStackView.addArrangedSubview(tagLabel)
        }
    }
    
    /// 태그 라벨
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
