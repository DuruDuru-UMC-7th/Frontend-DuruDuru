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
    
    let searchBarContainer = UIView().then {
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.backgroundColor = UIColor(red: 118/255, green: 118/255, blue: 128/255, alpha: 0.12)
    }
    
    /// 검색 바
    let searchBar = UISearchBar().then {
        $0.placeholder = "먹어보고 싶은 요리를 검색해보세요!"
        $0.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        $0.backgroundColor = .clear
        // 텍스트 필드 접근
        if let textField = $0.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.systemFont(ofSize: 14)
            textField.textColor = UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.6)
            textField.backgroundColor = .clear
        }
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
        $0.showsVerticalScrollIndicator = false
    }
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        addSubview(searchBarContainer)
        searchBarContainer.addSubview(searchBar)
        addSubview(orderFilterButton)
        addSubview(recipeTableView)
    }
    
    /// 오토레이아웃 설정
    private func constraints() {
        searchBarContainer.snp.makeConstraints {
            $0.top.equalToSuperview().offset(110)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(36)
        }
        
        searchBar.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        orderFilterButton.snp.makeConstraints {
            $0.top.equalTo(searchBarContainer.snp.bottom).offset(25)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        recipeTableView.snp.makeConstraints {
            $0.top.equalTo(orderFilterButton.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
}
