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
        
        let exchangeVC = UINavigationController(rootViewController: ExchangeViewController())
        exchangeVC.tabBarItem = UITabBarItem(title: "품앗이", image: UIImage(named: "Exchange"), tag: 3)
        
        let chattingVC = UINavigationController(rootViewController: ChattingViewController())
        chattingVC.tabBarItem = UITabBarItem(title: "채팅", image: UIImage(named: "Chatting"), tag: 4)
        
        let myPageVC = UINavigationController(rootViewController: MyPageViewController())
        myPageVC.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(named: "MyPage"), tag: 5)
        
        self.viewControllers = [homeVC, fridgeVC, exchangeVC, chattingVC, myPageVC]
        
    }
    
    /// 클릭 시, 검은색으로 칠해지도록 Aprrearance 조정 함수
    private func appearance() {
        let barAppearance = UITabBarAppearance()
        barAppearance.stackedLayoutAppearance.selected.iconColor = UIColor.black
        barAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.black]
        barAppearance.stackedLayoutAppearance.selected.badgeBackgroundColor = UIColor.black
        barAppearance.stackedLayoutAppearance.normal.badgeBackgroundColor = UIColor.black
        
        self.tabBar.standardAppearance = barAppearance
        self.tabBar.backgroundColor = .white
    }
           

}
