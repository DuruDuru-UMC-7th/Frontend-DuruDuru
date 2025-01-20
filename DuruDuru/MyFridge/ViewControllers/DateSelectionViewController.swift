//
//  DateSelectionViewController.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/19/25.
//

import UIKit

class DateSelectionViewController: UIViewController {
    // MARK: - Properties
    
    private let dateSelectionView = DateSelectionView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = dateSelectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        navigationItem.hidesBackButton = true
        
    }
    
    // MARK: - Setup
    
    private func setupActions() {
        // "식재료 추가" 버튼을 눌렀을 때 동작
        dateSelectionView.confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        // "뒤로가기" 버튼 액션
        dateSelectionView.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func didTapConfirmButton() {
        print("식재료 추가 완료")
        // 다음 화면으로 이동하거나 데이터를 저장하는 로직 추가
    }

    @objc private func didTapBackButton() {
        // 이전 화면으로 이동
        navigationController?.popViewController(animated: true)
    }
}
