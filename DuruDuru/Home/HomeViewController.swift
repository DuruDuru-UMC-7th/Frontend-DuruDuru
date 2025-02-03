//
//  HomeViewController.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/8/25.
//


import UIKit
import SnapKit

class HomeViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: - UI Components
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let myIngredientView = MyIngredientView()
    private let nearbyView = NearbyView()
    private let togetherEatView = TogetherEatView()
    private let homeRecipeView = HomeRecipeView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setUpUIBar()
        setupDelegate()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Setup UI
    
    private func setUpUIBar(){
        /// 상단 로고
        let logoImage = UIImageView().then {
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(named: "HomeLogo")
        }
        let titleItem = UIBarButtonItem(customView: logoImage)
        self.navigationItem.leftBarButtonItem = titleItem
        
        /// 상단 알림 아이콘
        let alarmButton = UIBarButtonItem(image: .bell, style: .plain, target: self, action: #selector(alarmButtonTapped))
        alarmButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = alarmButton
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(myIngredientView)
        contentView.addSubview(nearbyView)
        contentView.addSubview(togetherEatView)
        contentView.addSubview(homeRecipeView)
    }
    
    // MARK: - Function
    
    /// delegate
    private func setupDelegate() {
        nearbyView.searchBar.delegate = self
    }
    
    @objc func alarmButtonTapped() {
        print("알람 버튼 눌림")
    }
    
    /// 키보드 delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        /// 키보드 숨기기
        searchBar.resignFirstResponder()
        
        /// 검색 동작
    }

    @objc private func dismissKeyboard() {
        if nearbyView.searchBar.isFirstResponder {
            nearbyView.searchBar.resignFirstResponder()
        } else {
            nearbyView.searchBar.becomeFirstResponder()
        }
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
        }
        
        myIngredientView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top)
            $0.left.right.equalToSuperview()
        }
        
        nearbyView.snp.makeConstraints {
            $0.top.equalTo(myIngredientView.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
        }
        
        togetherEatView.snp.makeConstraints {
            $0.top.equalTo(nearbyView.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
        }
        
        homeRecipeView.snp.makeConstraints {
            $0.top.equalTo(togetherEatView.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
