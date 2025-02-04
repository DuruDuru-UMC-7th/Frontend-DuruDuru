//
//  ExchangeViewController.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/8/25.
//

import UIKit

class MainExchangeViewController: UIViewController {
    
    // MARK: - Properties
    
    var mainExchangeView: MainExchangeView!
    private var exchangeVC: ExchangeViewController!
    private var eatTogetherVC: EatTogetherViewController!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainExchangeView = MainExchangeView(frame: self.view.bounds)
        self.view = mainExchangeView
        setUpUIBar()
        setupAction()
        exchangeVC = ExchangeViewController()
        eatTogetherVC = EatTogetherViewController()
        add(asChildViewController: exchangeVC)
    }
    
    // MARK: - Function
    
    private func setupAction() {
        /// segmentedControl의 valueChanged 이벤트에 대한 타겟 및 액션 설정
        mainExchangeView.segmentedControl.addTarget(self, action: #selector(segmentChanged(segment:)),for: .valueChanged)
        
        mainExchangeView.locationButton.addTarget(self, action: #selector(didTapLocationButton), for: .touchUpInside)
    }
    
    @objc
    private func segmentChanged(segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            switchToChildViewController(exchangeVC)
        } else {
            switchToChildViewController(eatTogetherVC)
        }
        
        /// 세그먼트의 너비 계산
        let segmentWidth = mainExchangeView.segmentedControl.frame.width / CGFloat(mainExchangeView.segmentedControl.numberOfSegments)
        let selectedSegmentIndex = CGFloat(segment.selectedSegmentIndex)
        
        /// 언더라인 애니메이션
        UIView.animate(withDuration: 0.3) {
            /// 언더라인의 제약 조건 업데이트
            self.mainExchangeView.underline.snp.updateConstraints {
                $0.left.equalTo(self.mainExchangeView.segmentedControl.snp.left).offset(segmentWidth * selectedSegmentIndex)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    /// 동네 설정 버튼 클릭 시 동작
    @objc private func didTapLocationButton() {
        
        print("동네 설정 버튼 클릭")
        
        let settingTownVC = SettingTownViewController()
        settingTownVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(settingTownVC, animated: true)
    }
    
    func setUpUIBar() {
        
        let townButton = UIBarButtonItem(customView: mainExchangeView.locationButton)
        
        let downButton = UIBarButtonItem(customView: mainExchangeView.downImage)
        
        // 상단 바에 버튼 추가
        self.navigationItem.leftBarButtonItems = [townButton, downButton]
    }
    
    /// 자식 뷰 컨트롤러 바꾸기
    private func switchToChildViewController(_ child: UIViewController) {
        /// 현재 자식 뷰 컨트롤러 제거
        for childVC in children {
            childVC.willMove(toParent: nil)
            childVC.view.removeFromSuperview()
            childVC.removeFromParent()
        }
        /// 새 자식 뷰 컨트롤러 추가
        add(asChildViewController: child)
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        mainExchangeView.containerView.addSubview(viewController.view)
        
        // Auto Layout을 사용할 수 있도록 제약 조건 설정
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: mainExchangeView.containerView.topAnchor),
            viewController.view.leadingAnchor.constraint(equalTo: mainExchangeView.containerView.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: mainExchangeView.containerView.trailingAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: mainExchangeView.containerView.bottomAnchor)
        ])
        
        viewController.didMove(toParent: self)
    }
    
}
