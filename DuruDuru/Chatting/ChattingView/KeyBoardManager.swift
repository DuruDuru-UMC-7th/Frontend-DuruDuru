//
//  KeyBoardManager.swift
//  DuruDuru
//
//  Created by 한지강 on 2/21/25.
//

import SwiftUI
import Combine

final class KeyboardHeightHelper: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0

    private var cancellables = Set<AnyCancellable>()

    init() {
        // keyboardWillShow/Hide 노티피케이션 구독
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .sink { notification in
                guard let userInfo = notification.userInfo,
                      let endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
                self.keyboardHeight = endFrame.height
            }
            .store(in: &cancellables)

        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { _ in
                self.keyboardHeight = 0
            }
            .store(in: &cancellables)
    }
}

import UIKit

extension UIApplication {
    func endEditing(_ force: Bool) {
        windows
            .first { $0.isKeyWindow }?
            .endEditing(force)
    }
}
