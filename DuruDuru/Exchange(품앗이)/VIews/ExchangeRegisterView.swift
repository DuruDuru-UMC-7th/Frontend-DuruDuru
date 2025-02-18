//
//  ExchangeRegisterView.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/28/25.
//

import UIKit
import SnapKit

class ExchangeRegisterView: UIView {

    // MARK: - UI 컴포넌트
    
    /// 상단 구분선
    let topSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGreen
        return view
    }()
    
    let topSeparator2 = UIView().then {
        $0.backgroundColor = UIColor(hex: 0x37383C
                                     , alpha: 0.16)
    }
    
    /// 안내 문구
    let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "품앗이할 식재료를 선택해주세요"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let searchBarContainer = UIView().then {
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.backgroundColor = UIColor(red: 118/255, green: 118/255, blue: 128/255, alpha: 0.12)
    }

    /// 검색 바
    let searchBar = UISearchBar().then {
        $0.placeholder = "필요한 식재료를 검색하세요"
        $0.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        $0.backgroundColor = .clear
        // 텍스트 필드 접근
        if let textField = $0.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.systemFont(ofSize: 14)
            textField.textColor = UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.6)
            textField.backgroundColor = .clear
        }
    }
    
    /// 원형 식재료 리스트
    let ingredientsCircleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumInteritemSpacing = 8 // 좌우 간격
        $0.minimumLineSpacing = 12 // 상하 간격
    }).then {
        $0.backgroundColor = .clear
        $0.register(IngredientsCircleCollectionViewCell.self, forCellWithReuseIdentifier: IngredientsCircleCollectionViewCell.identifier)
        $0.showsVerticalScrollIndicator = false
    }
    
    /// 하단 "다음으로" 버튼
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("다음으로", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
        button.backgroundColor = UIColor(hex: 0xF4F4F5, alpha: 1.0)
        button.layer.cornerRadius = 10
        button.isEnabled = false
        return button
    }()
    
    func updateNextButtonState(isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
        nextButton.backgroundColor = isEnabled ? UIColor(hex: 0x00C269) : UIColor(hex: 0xF4F4F5, alpha: 1.0)
        nextButton.setTitleColor(isEnabled ? .white : UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
    }
    
    // MARK: - 초기화
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI 설정
    
    private func setupUI() {
        backgroundColor = .white
        addSubview(topSeparator)
        addSubview(topSeparator2)
        addSubview(instructionLabel)
        addSubview(searchBarContainer)
        searchBarContainer.addSubview(searchBar)
        addSubview(ingredientsCircleCollectionView)
        addSubview(nextButton)
    }
    
    // MARK: - 오토레이아웃 설정
    
    private func setupConstraints() {
        topSeparator.snp.makeConstraints {
            $0.top.equalToSuperview().offset(98)
            $0.leading.equalToSuperview()
            $0.height.equalTo(2)
            $0.width.equalTo(UIScreen.main.bounds.width * (1 / 2))
        }
        
        topSeparator2.snp.makeConstraints {
            $0.top.equalToSuperview().offset(98)
            $0.leading.equalTo(topSeparator.snp.trailing)
            $0.height.equalTo(2)
            $0.trailing.equalToSuperview()
        }
        
        instructionLabel.snp.makeConstraints {
            $0.top.equalTo(topSeparator2.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(22)
        }
        
        searchBarContainer.snp.makeConstraints {
            $0.top.equalTo(instructionLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(36)
        }
        
        searchBar.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        ingredientsCircleCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchBarContainer.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(nextButton.snp.top).offset(-20)
        }
        
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(47)
            $0.bottom.equalToSuperview().offset(-40)
        }
    }
}
