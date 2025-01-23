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
        addSubview(segmentedControl)
        addSubview(underline)
        addSubview(containerView)
    }
    
    /// 오토레이아웃 설정
    private func constraints() {
        segmentedControl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(75)
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
