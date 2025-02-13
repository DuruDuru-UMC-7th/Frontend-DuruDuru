//
//  AddIngredientViewController.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/19/25.
//

import UIKit

class AddIngredientViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private let addIngredientView = AddIngredientView()
    private var quantity: Int = 0
    private var image: UIImage?
    private var ingredientId: Int?
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = addIngredientView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        addIngredientView.nameTextField.delegate = self
        navigationItem.hidesBackButton = true
        
        setUpUI()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        addIngredientView.imageView.isUserInteractionEnabled = true
        addIngredientView.imageView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions 설정
    
    private func setUpUI() {
        // 상단바
        let closeImage = UIImage(systemName: "xmark")
        let closeButton = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(didTapCloseButton))
        self.navigationItem.rightBarButtonItem = closeButton
        closeButton.tintColor = .black
        
        self.title = "식재료 추가하기"
    }
    
    private func setupActions() {
        addIngredientView.nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        addIngredientView.minusButton.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
        addIngredientView.plusButton.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        addIngredientView.nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapCloseButton() {
        
        if let presentingVC = presentingViewController {
            presentingVC.dismiss(animated: true, completion: nil)
        } else if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
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
        let ingredientName = addIngredientView.nameTextField.text ?? ""
        let request = SetIngredientRequest(ingredientName: ingredientName, count: quantity)
        
        // 식재료 등록
        setIngredeint(setIngredientRequest: request) { [weak self] in
            // 이미지가 선택된 경우에만 이미지 등록
            if let image = self?.image, let ingredientId = self?.ingredientId {
                self?.setIngredeintImage(image: image, ingredientId: ingredientId)
            }
        }
        
        let nextVC = IngredientTypeViewController() // 종류 설정 화면
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let isNotEmpty = !(textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        addIngredientView.updateNextButtonState(isEnabled: isNotEmpty)
    }
    
    // textField return 누를때 동작
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addIngredientView.nameTextField.resignFirstResponder()
        return true
    }
    
    @objc private func imageViewTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary // 앨범에서 사진 선택
        imagePicker.allowsEditing = false // 편집 허용 여부
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                addIngredientView.imageView.image = selectedImage
                self.image = selectedImage
            }
            picker.dismiss(animated: true, completion: nil)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    
    // MARK: - API 관련
    
    // 식재료 등록 API
    func setIngredeint(setIngredientRequest: SetIngredientRequest, completion: @escaping () -> Void) {
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
                    self.ingredientId = response.result?.ingredientId // 옵셔널 처리
                    print("ingredientId: ", self.ingredientId)
                    completion() // 클로저 호출
                case .failure(let error):
                    print("네트워킹 오류: \(error)")
                }
            }
        } catch {
            print("인코딩 오류: \(error)")
        }
    }
    
    // 식재료 이미지 등록 API
    func setIngredeintImage(image: UIImage, ingredientId: Int) {
        let url = "http://3.35.252.162:8080/ingredient/\(ingredientId)/photo"
        
        // 이미지 데이터로 변환
        guard let imageData = image.pngData() else {
            print("이미지 변환 실패")
            return
        }
        
        // multipart/form-data 요청
        APIClient.shared.upload(url: url, imageData: imageData, name: "image") { (result: Result<SetIngredientImageResponse, Error>) in
            switch result {
            case .success(let response):
                print("식재료 이미지 등록 성공")
            case .failure(let error):
                print("식재료 이미지 등록 네트워킹 오류: \(error)")
            }
        }
    }
}

            
