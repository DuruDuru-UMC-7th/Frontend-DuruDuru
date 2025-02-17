//
//  ChattingViewController.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/8/25.
//

import UIKit
import SwiftUI

class ChattingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // SwiftUI 뷰를 UIHostingController로 감싸기
        let swiftUIView = ChattingTabView()
        let hostingController = UIHostingController(rootView: swiftUIView)

        addChild(hostingController)
        hostingController.view.frame = view.bounds
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
}
