//
//  ExchangeView.swift
//  DuruDuru
//
//  Created by 임효진 on 1/23/25.
//

import UIKit

class MainExchangeView: UIView {
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
        constraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components
    
    /// 주소 바꾸기 버튼
    private let locationButton = UIButton().then {
        let configuration = UIButton.Configuration.plain()
        $0.configuration = configuration
        $0.configuration?.image = UIImage(named: "underIcon")
        $0.configuration?.imagePlacement = .trailing
        $0.configuration?.imagePadding = 5
        $0.configuration?.baseForegroundColor = .black
        $0.configuration?.attributedTitle = AttributedString("공릉동", attributes: AttributeContainer([.font: UIFont.boldSystemFont(ofSize: 16)]))
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    }
    
    /// 프로필 버튼
    private let profileButton = UIButton().then {
        $0.setImage(UIImage(named: "profile")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .black
    }
    
    /// 검색 버튼
    private let searchButton = UIButton().then {
        $0.setImage(UIImage(named: "search")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .black
    }
    
    /// 알람 버튼
    private let alarmButton = UIButton().then {
        $0.setImage(UIImage(named: "alarm")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .black
    }
    
    /// 세그먼트
    let segmentedControl = UISegmentedControl(items: ["품앗이", "함께 먹자"]).then {
        $0.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        $0.setBackgroundImage(UIImage(), for: .selected, barMetrics: .default)
        $0.setBackgroundImage(UIImage(), for: .highlighted, barMetrics: .default)
        $0.setDividerImage(UIImage(), forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        $0.selectedSegmentIndex = 0
        $0.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                .font: UIFont.systemFont(ofSize: 14, weight: .light),
            ],
            for: .normal
        )
        $0.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                .font: UIFont.systemFont(ofSize: 14, weight: .bold),
            ],
            for: .selected
        )
    }
    
    /// 세그먼트 밑줄
    let underline = UIView().then {
        $0.backgroundColor = UIColor(hex: 0x00C269, alpha: 1.0)
    }
    
    let containerView = UIView()
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        addSubview(locationButton)
        addSubview(profileButton)
        addSubview(searchButton)
        addSubview(alarmButton)
        addSubview(segmentedControl)
        addSubview(underline)
        addSubview(containerView)
    }
    
    /// 오토레이아웃 설정
    private func constraints() {
        locationButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(54)
            $0.left.equalToSuperview().offset(16)
        }
        
        alarmButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(54)
            $0.right.equalToSuperview().offset(-16)
        }
        
        searchButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(54)
            $0.right.equalTo(alarmButton.snp.left).offset(-16)
        }
        
        profileButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(54)
            $0.right.equalTo(searchButton.snp.left).offset(-16)
        }
        
        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(locationButton.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        underline.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.width.equalTo(segmentedControl.snp.width).dividedBy(segmentedControl.numberOfSegments)
            $0.top.equalTo(segmentedControl.snp.bottom).offset(3)
            $0.left.equalTo(segmentedControl.snp.left)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(underline.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
    }

}
