//
//  AddIngredientViewController.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/19/25.
//

import UIKit

class AddIngredientViewController: UIViewController {

    // MARK: - UI Components
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "식재료 추가하기"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private let topSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    private let stepLabel: UILabel = {
        let label = UILabel()
        label.text = "Step.1"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .gray
        return label
    }()
    
    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "추가할 식재료의\n사진과 이름을 입력해주세요."
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    

    private let imageView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        let icon = UIImageView(image: UIImage(systemName: "camera"))
        icon.tintColor = .darkGray
        view.addSubview(icon)
        icon.snp.makeConstraints { $0.center.equalToSuperview() }
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "식재료이름"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .gray
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "식재료 이름"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("종류 설정하러 가기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(backButton)
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(topSeparator)
        view.addSubview(stepLabel)
        view.addSubview(instructionLabel)
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(nextButton)
        
        navigationItem.hidesBackButton = true
        
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(backButton)
            $0.centerX.equalToSuperview()
        }
        
        topSeparator.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(13)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1) 
        }
        
        stepLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        
        instructionLabel.snp.makeConstraints {
            $0.top.equalTo(stepLabel.snp.bottom).offset(9)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        imageView.snp.makeConstraints {
            $0.top.equalTo(instructionLabel.snp.bottom).offset(19)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(view.frame.width * 0.5)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
    }
    
    // MARK: - Actions
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapNextButton() {
        let nextVC = IngredientTypeViewController() // 종류 설정 화면
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
