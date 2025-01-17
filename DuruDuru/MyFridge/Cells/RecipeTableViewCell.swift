//
//  RecipeTableViewCell.swift
//  DuruDuru
//
//  Created by 임효진 on 1/13/25.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    // MARK: - Init
    
    static let identifier: String = "recipeTableViewCell"
    
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
        $0.setImage(UIImage(named: "heart"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// 레시피 이름
    let recipeName = UILabel().then {
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .black
    }
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        addSubview(container)
        addSubview(recipeName)
        container.addSubview(titleImage)
        container.addSubview(likeButton)
    }
    
    /// 오토레이아웃 설정
    private func constraints() {
        container.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.width.equalTo(370)
            $0.height.equalTo(158.57)
        }
        
        titleImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        likeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5)
            $0.width.height.equalTo(20)
        }
        
        recipeName.snp.makeConstraints {
            $0.top.equalTo(container.snp.bottom).offset(12)
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-56)
        }
    }
    
}
