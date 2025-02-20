//
//  ChattingViewController.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/8/25.
//

import SwiftUI

// ChattingViewController.swift
class ChattingViewController: UIViewController {
    private var hostingController: UIHostingController<ChattingTabView>?

    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: false)

        super.viewDidLoad()
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
               additionalSafeAreaInsets.bottom = tabBarHeight - 1500
               
        additionalSafeAreaInsets.top = -50
        if let tabBar = self.tabBarController?.tabBar {
            tabBar.isTranslucent = false
            tabBar.backgroundColor = .white
        }
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .white

        let swiftUIView = ChattingTabView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        self.hostingController = hostingController

        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)

        // Auto Layout으로 전체 채우기
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: tabBarHeight+83)
        ])
    }
}
