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
    let orderFilterButton = UIButton().then {
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
    
    
    /// 옵션뷰
    
    let darkBackgroundView = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        $0.isHidden = true // 처음에는 숨김
    }
    
    // 메뉴 뷰
    let optionsView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 30
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.isHidden = true
    }
    
    let filterLabel = UILabel().then {
        $0.text = "정렬"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .black
    }
    
    let moreFilter = UIButton().then {
        $0.setTitle("찜 많은 순", for: .normal)
        $0.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    let recentFilter = UIButton().then {
        $0.setTitle("최신 등록순", for: .normal)
        $0.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    let menuCloseButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .black
    }
    
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        addSubview(searchBarContainer)
        searchBarContainer.addSubview(searchBar)
        addSubview(orderFilterButton)
        addSubview(recipeTableView)
        
        addSubview(darkBackgroundView)
        addSubview(optionsView)
        optionsView.addSubview(filterLabel)
        optionsView.addSubview(moreFilter)
        optionsView.addSubview(recentFilter)
        optionsView.addSubview(menuCloseButton)
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
        
        darkBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview() // 전체 화면을 채움
        }
        
        optionsView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(148)
        }
        
        filterLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.leading.equalToSuperview().offset(16)
        }
        
        moreFilter.snp.makeConstraints {
            $0.top.equalTo(filterLabel.snp.bottom).offset(21)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(17)
        }
        
        recentFilter.snp.makeConstraints {
            $0.top.equalTo(moreFilter.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(17)
        }
        
        menuCloseButton.snp.makeConstraints {
            $0.centerY.equalTo(filterLabel)
            $0.trailing.equalToSuperview().offset(-16)
            $0.width.height.equalTo(24)
        }
    }
}
