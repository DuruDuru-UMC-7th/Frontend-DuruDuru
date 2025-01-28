//
//  StorageOptionsPopupView.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/28/25.
//

import UIKit
import SnapKit

class StorageOptionsPopupView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이렇게 보관할 거예요!"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "보관 방식에 따라 적용되는 소비기한이 달라져요."
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }()
    
    let roomTempButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("실온", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    let fridgeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("냉장", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    let freezerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("냉동", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 16
        layer.masksToBounds = true
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(roomTempButton)
        stackView.addArrangedSubview(fridgeButton)
        stackView.addArrangedSubview(freezerButton)
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
}
