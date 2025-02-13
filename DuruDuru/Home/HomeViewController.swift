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
    private let homeRecipeView = HomeRecipeView()

    // 옵션 뷰 관련
    private let darkBackgroundView = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        $0.isHidden = true
    }

    private let optionsView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 30
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.isHidden = true
    }

    private let filterLabel = UILabel().then {
        $0.text = "정렬"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .black
    }

    private let recentFilter = UIButton().then {
        $0.setTitle("최신 등록순", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    }

    private let nearExpiryDateFilter = UIButton().then {
        $0.setTitle("소비기한 임박순", for: .normal)
        $0.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }

    private let farExpiryFilter = UIButton().then {
        $0.setTitle("소비기한 여유순", for: .normal)
        $0.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }

    private let menuCloseButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .black
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setUpUIBar()
        setupDelegate()
        setupButtonActions()
    }

    // MARK: - Setup UI

    private func setUpUIBar() {
        let logoImage = UIImageView().then {
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(named: "HomeLogo")
        }
        let titleItem = UIBarButtonItem(customView: logoImage)
        self.navigationItem.leftBarButtonItem = titleItem

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
        contentView.addSubview(homeRecipeView)

        // 옵션 뷰 추가 (scrollView가 아니라 view에 추가!)
        view.addSubview(darkBackgroundView)
        view.addSubview(optionsView)

        optionsView.addSubview(filterLabel)
        optionsView.addSubview(recentFilter)
        optionsView.addSubview(nearExpiryDateFilter)
        optionsView.addSubview(farExpiryFilter)
        optionsView.addSubview(menuCloseButton)
    }

    private func setupDelegate() {
        nearbyView.searchBar.delegate = self
    }

    private func setupButtonActions() {
        nearbyView.recentButton.addTarget(self, action: #selector(didTapRecentButton), for: .touchUpInside)
        menuCloseButton.addTarget(self, action: #selector(didTapMenuCloseButton), for: .touchUpInside)

        // 버튼 클릭 시 텍스트 변경 기능 추가
        recentFilter.addTarget(self, action: #selector(didTapRecentFilter), for: .touchUpInside)
        nearExpiryDateFilter.addTarget(self, action: #selector(didTapNearExpiryFilter), for: .touchUpInside)
        farExpiryFilter.addTarget(self, action: #selector(didTapFarExpiryFilter), for: .touchUpInside)
    }

    // MARK: - Button Actions

    @objc private func alarmButtonTapped() {
    }

    @objc private func didTapRecentButton() {
        let visibleFrame = scrollView.bounds

        darkBackgroundView.isHidden = false
        optionsView.isHidden = false

        optionsView.snp.remakeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(185)
        }
    }

    @objc private func didTapMenuCloseButton() {
        darkBackgroundView.isHidden = true
        optionsView.isHidden = true
    }

    // 정렬 버튼 클릭 시 텍스트 변경
    @objc private func didTapRecentFilter() {
        updateSelectedFilter(recentFilter)
    }

    @objc private func didTapNearExpiryFilter() {
        updateSelectedFilter(nearExpiryDateFilter)
    }

    @objc private func didTapFarExpiryFilter() {
        updateSelectedFilter(farExpiryFilter)
    }

    private func updateSelectedFilter(_ selectedButton: UIButton) {
        // 모든 버튼 기본 스타일로 변경
        recentFilter.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
        nearExpiryDateFilter.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
        farExpiryFilter.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)

        // 선택된 버튼 강조
        selectedButton.setTitleColor(.black, for: .normal)
        selectedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)

        // 드롭다운 버튼의 텍스트 변경
        nearbyView.recentButton.configuration?.attributedTitle = AttributedString(
            selectedButton.title(for: .normal) ?? "",
            attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 12)])
        )

        // 옵션 창 닫기
        didTapMenuCloseButton()
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

        homeRecipeView.snp.makeConstraints {
            $0.top.equalTo(nearbyView.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        darkBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        optionsView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(185)
            $0.bottom.equalToSuperview().offset(185) // 처음에는 화면 아래에 숨김
        }

        filterLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.leading.equalToSuperview().offset(16)
        }

        recentFilter.snp.makeConstraints {
            $0.top.equalTo(filterLabel.snp.bottom).offset(21)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(17)
        }

        nearExpiryDateFilter.snp.makeConstraints {
            $0.top.equalTo(recentFilter.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(17)
        }

        farExpiryFilter.snp.makeConstraints {
            $0.top.equalTo(nearExpiryDateFilter.snp.bottom).offset(20)
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
