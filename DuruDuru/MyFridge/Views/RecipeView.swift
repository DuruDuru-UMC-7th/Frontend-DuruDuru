//
//  RecipeView.swift
//  DuruDuru
//
//  Created by 임효진 on 1/12/25.
//

import UIKit

class RecipeView: UIView {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
        constraints()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components
    
    /// 검색창 라벨
    let searchBarLabel = UILabel().then {
        $0.text = "먹어보고 싶은 요리를 검색해보세요!"
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.6)
    }
    
    /// 검색창
    let searchBar = UITextField().then {
        $0.backgroundColor = UIColor(red: 118/255, green: 118/255, blue: 128/255, alpha: 0.12)
        $0.layer.cornerRadius = 10
    }
    
    /// 검색창 이미지
    let searchImageView = UIImageView().then {
        $0.image = UIImage(named: "Search")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// 순서 필터  메뉴
    private let orderFilterButton = UIButton().then {
        let configuration = UIButton.Configuration.plain()
        $0.configuration = configuration
        $0.configuration?.image = UIImage(named: "Arrow")
        $0.configuration?.imagePlacement = .trailing
        $0.configuration?.imagePadding = 5
        $0.configuration?.baseForegroundColor = .gray
        $0.configuration?.attributedTitle = AttributedString("찜 많은순", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 12)]))
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    }
    
    /// 레시피 테이블 뷰
    public let recipeTableView = UITableView().then {
        $0.register(RecipeTableViewCell.self, forCellReuseIdentifier: RecipeTableViewCell.identifier)
        $0.separatorStyle = .singleLine
        $0.allowsSelection = true
        $0.isUserInteractionEnabled = true
    }
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        addSubview(searchBar)
        searchBar.addSubview(searchImageView)
        searchBar.addSubview(searchBarLabel)
        addSubview(orderFilterButton)
        addSubview(recipeTableView)
    }
    
    /// 오토레이아웃 설정
    private func constraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(110)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(36)
        }
        
        searchImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(7)
            $0.bottom.equalToSuperview().offset(-7)
            $0.left.equalToSuperview().offset(8)
        }
        
        searchBarLabel.snp.makeConstraints {
            $0.left.equalTo(searchImageView.snp.right).offset(5)
            $0.top.equalToSuperview().offset(7)
            $0.bottom.equalToSuperview().offset(-7)
        }
        
        orderFilterButton.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(25)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        recipeTableView.snp.makeConstraints {
            $0.top.equalTo(orderFilterButton.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
}
