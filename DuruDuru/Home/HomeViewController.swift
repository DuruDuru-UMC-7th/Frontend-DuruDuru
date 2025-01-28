//
//  HomeViewController.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/8/25.
//


import UIKit
import SnapKit

class HomeViewController: UIViewController {

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
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(myIngredientView)
        contentView.addSubview(nearbyView)
        contentView.addSubview(togetherEatView)
        contentView.addSubview(homeRecipeView)
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
