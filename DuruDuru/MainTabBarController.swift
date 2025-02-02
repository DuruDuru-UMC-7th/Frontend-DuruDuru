//
//  MainTabBarController.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/8/25.
//

import UIKit

/// 탭바컨트롤러
class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
        appearance()
    }
    
    
    /// 탭바 설정 함수
    private func setupTabBar() {
        self.tabBar.backgroundColor = .white
        self.tabBar.isTranslucent = false
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "Home"), tag: 1)
        
        let fridgeVC = UINavigationController(rootViewController: MyFridgeViewController())
        fridgeVC.tabBarItem = UITabBarItem(title: "나의냉장고", image: UIImage(named: "MyFridge"), tag: 2)
        
        let exchangeVC = UINavigationController(rootViewController: MainExchangeViewController())
        exchangeVC.tabBarItem = UITabBarItem(title: "품앗이", image: UIImage(named: "Exchange"), tag: 3)
        
        let chattingVC = UINavigationController(rootViewController: ChattingViewController())
        chattingVC.tabBarItem = UITabBarItem(title: "채팅", image: UIImage(named: "Chatting"), tag: 4)
        
        let myPageVC = UINavigationController(rootViewController: MyPageViewController())
        myPageVC.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(named: "MyPage"), tag: 5)
        
        self.viewControllers = [homeVC, fridgeVC, exchangeVC, chattingVC, myPageVC]
        
        // 아이콘 크기 및 위치 조정
        for item in tabBar.items ?? [] {
            item.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -2, right: 0) // 아이콘 위치 조정
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0) // 타이틀 위치 조정
        }
    }
    
    /// 클릭 시, 검은색으로 칠해지도록 Aprrearance 조정 함수
    private func appearance() {
        let barAppearance = UITabBarAppearance()
        barAppearance.stackedLayoutAppearance.selected.iconColor = UIColor.systemGreen
        barAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemGreen]
        barAppearance.stackedLayoutAppearance.selected.badgeBackgroundColor = UIColor.black
        barAppearance.stackedLayoutAppearance.normal.badgeBackgroundColor = UIColor.black
        
        self.tabBar.standardAppearance = barAppearance
        self.tabBar.backgroundColor = .white
    }
           

}
