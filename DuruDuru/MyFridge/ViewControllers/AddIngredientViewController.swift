//
//  AddIngredientViewController.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/19/25.
//

import UIKit


class AddIngredientViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var setIngredientRequest: SetIngredientRequest!
    
    // MARK: - UI Components
    private let topSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGreen
        return view
    }()
    
    private let stepLabel: UILabel = {
        let label = UILabel()
        label.text = "Step.1"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .gray
        label.textAlignment = .center
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
    
    private let count: UILabel = {
        let label = UILabel()
        label.text = "수량"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    let countLabel = UILabel().then {
        $0.text = "0"
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 24)
    }
    
    let decrementButton = UIButton().then {
        $0.setImage(UIImage(systemName: "minus"), for: .normal)
        $0.layer.cornerRadius = 8.91
        $0.backgroundColor = UIColor(hex: 0xF4F4F5)
        $0.tintColor = .black
    }
    
    let incrementButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.layer.cornerRadius = 8.91
        $0.backgroundColor = UIColor(hex: 0xF4F4F5)
        $0.tintColor = .black
    }
    
class AddIngredientViewController: UIViewController, UITextFieldDelegate {

    
    private let addIngredientView = AddIngredientView()

    private var quantity: Int = 0
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = addIngredientView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        addIngredientView.nameTextField.delegate = self
        navigationItem.hidesBackButton = true
    }
    
    // MARK: - Actions 설정
   
    private func setupUI() {
        // 상단바
        let backImage = UIImage(systemName: "chevron.left")
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(didTapBackButton))
        self.navigationItem.leftBarButtonItem = backButton
        backButton.tintColor = .black
        
        self.title = "식재료 추가하기"

        view.backgroundColor = .white
        view.addSubview(topSeparator)
        view.addSubview(stepLabel)
        view.addSubview(instructionLabel)
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(nextButton)
        view.addSubview(count)
        view.addSubview(countLabel)
        view.addSubview(decrementButton)
        view.addSubview(incrementButton)
        
        navigationItem.hidesBackButton = true
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        decrementButton.addTarget(self, action: #selector(decrementButtonClicked), for: .touchUpInside)
        incrementButton.addTarget(self, action: #selector(incrementButtonClicked), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        topSeparator.snp.makeConstraints {
            $0.top.equalToSuperview().offset(98)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(2)
        }
        
        stepLabel.snp.makeConstraints {
            $0.top.equalTo(topSeparator.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(22)
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
      
    private func setupActions() {
        addIngredientView.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        addIngredientView.closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        addIngredientView.nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        addIngredientView.minusButton.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
        addIngredientView.plusButton.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapCloseButton() {
        
        if let presentingVC = presentingViewController {
            presentingVC.dismiss(animated: true, completion: nil)
        } else if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        } else {
        }
        
        count.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(22)
        }
        
        decrementButton.snp.makeConstraints {
            $0.width.height.equalTo(26)
            $0.top.equalTo(count.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(16)
        }
        
        countLabel.snp.makeConstraints {
            $0.width.height.equalTo(22)
            $0.top.equalTo(count.snp.bottom).offset(17)
            $0.leading.equalTo(decrementButton.snp.trailing).offset(18)
        }
        
        incrementButton.snp.makeConstraints {
            $0.width.height.equalTo(26)
            $0.top.equalTo(count.snp.bottom).offset(15)
            $0.leading.equalTo(countLabel.snp.trailing).offset(18)
        }
    }
    
    @objc private func didTapMinusButton() {
        if quantity > 0 { // 0 이하로 내려가지 않음
            quantity -= 1
            updateQuantityLabel()
        }
    }
    
    @objc private func didTapPlusButton() {
        quantity += 1
        updateQuantityLabel()
    }
    
    private func updateQuantityLabel() {
        addIngredientView.quantityValueLabel.text = "\(quantity)"
    }
    
    @objc private func didTapNextButton() {
        guard let ingredientName = nameTextField.text, !ingredientName.isEmpty,
              let countText = countLabel.text, let ingredientCount = Int(countText) else {
            // 입력 값이 올바르지 않을 경우 처리
            print("식재료 이름과 수량을 입력해 주세요.")
            return
        }
        
        setIngredientRequest = SetIngredientRequest(ingredientName: ingredientName, count: ingredientCount)
        
        // API 호출
        setTown(setIngredientRequest: setIngredientRequest)
        let nextVC = IngredientTypeViewController() // 종류 설정 화면
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // '-' 버튼 클릭시
    @objc func decrementButtonClicked() {
        guard let currentCount = Int(countLabel.text ?? "0"), currentCount > 1 else { return }
        
        let newCount = currentCount - 1
        countLabel.text = "\(newCount)"
    }
    
    // '+' 버튼 클릭시
    @objc func incrementButtonClicked() {
        guard let currentCount = Int(countLabel.text ?? "0") else { return }
        
        let newCount = currentCount + 1
        countLabel.text = "\(newCount)"
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addIngredientView.nameTextField.resignFirstResponder()
        return true
    }
    
    // MARK: - API 관련
    
    // 식재료 등록 API
    func setTown(setIngredientRequest: SetIngredientRequest) {
        let url = "http://3.35.252.162:8080/ingredient/"
        
        // 쿼리 파라미터
        let queryParameters: [String: Any] = [
            "memberId": 2, /// 임시로 넣은 memberId
        ]
        
        let queryString = APIClient.shared.createQueryString(from: queryParameters)
        let urlWithQuery = "\(url)?\(queryString)"
        let requestBody = setIngredientRequest
        
        // API 요청
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(requestBody)
            let jsonParameters = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
            
            APIClient.shared.request(urlWithQuery, method: .post, parameters: jsonParameters) { (result: Result<SetIngredientResponse, Error>) in
                switch result {
                case .success(let response):
                    print("!!식재료 이름 등록 성공!!")
                    print(response)
                case .failure(let error):
                    print("네트워킹 오류: \(error)")
                }
            }
        } catch {
            print("인코딩 오류: \(error)")
        }
    }
}
