//
//  ChattingViewController.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/8/25.
//

import UIKit
import SwiftUI

class ChattingViewController: UIViewController {
    private var hostingController: UIHostingController<ChattingTabView>?

    override func viewDidLoad() {
        super.viewDidLoad()

        // SwiftUI 뷰를 UIHostingController로 감싸기
        let swiftUIView = ChattingTabView()
        let hostingController = UIHostingController(rootView: swiftUIView)

        self.hostingController = hostingController

        addChild(hostingController)
        hostingController.view.frame = view.bounds
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("🟢 ChattingViewController appeared! 강제 새로고침 실행")
        NotificationCenter.default.post(name: NSNotification.Name("ChattingTabViewRefresh"), object: nil)
    }
}
