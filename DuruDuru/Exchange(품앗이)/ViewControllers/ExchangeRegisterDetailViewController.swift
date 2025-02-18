//
//  ExchangeRegisterDetailViewController.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/28/25.
//

import UIKit
import PhotosUI

class ExchangeRegisterDetailViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    // MARK: - Properties
    private let detailView = ExchangeRegisterDetailView() // 커스텀 뷰
    var ingredient: MyIngredient? // 선택된 식재료
    private var quantity: Int = 0
    private var selectedMethod: String? = nil
    private var isUnitDropDownView: Bool = false
    private var unitDropDownView: UnitDropdownView!
    private var images: [UIImage]?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setupActions() // 버튼 동작 설정
        setUpUI()
        detailView.configure(with: ingredient!)
        detailView.descriptionTextView.delegate = self
        // 키보드 동작을 위한 제스쳐
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        detailView.ingredientImageView.isUserInteractionEnabled = true
        detailView.ingredientImageView.addGestureRecognizer(tapGesture)
    }
    
    override func loadView() {
        self.view = detailView // 커스텀 뷰 설정
    }
    
    // MARK: - Actions
    
    private func setUpUI() {
        // 상단바
        let backImage = UIImage(systemName: "chevron.left")
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(didTapBackButton))
        self.navigationItem.leftBarButtonItem = backButton
        backButton.tintColor = .black
        
        let closeImage = UIImage(systemName: "xmark")
        let closeButton = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(didTapCloseButton))
        self.navigationItem.rightBarButtonItem = closeButton
        closeButton.tintColor = .black
        
        self.title = "품앗이 등록하기"
    }
    
    private func setupActions() {
        detailView.minusButton.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
        detailView.plusButton.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        detailView.unitButton.addTarget(self, action: #selector(didTapUnitButton), for: .touchUpInside)
        detailView.shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        detailView.exchangeButton.addTarget(self, action: #selector(didTapExchangeButton), for: .touchUpInside)
        detailView.nextButton.addTarget(self, action: #selector(didTapCompleteButton), for: .touchUpInside)
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
        detailView.quantityValueLabel.text = "\(quantity)"
    }
    
    // 단위버튼
    @objc private func didTapUnitButton() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        detailView.unitButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let buttonFrame = detailView.unitButton.convert(detailView.unitButton.bounds, to: window)
        if unitDropDownView == nil {
            unitDropDownView = UnitDropdownView()
            unitDropDownView?.frame = CGRect(
                x: buttonFrame.origin.x,
                y: buttonFrame.origin.y + buttonFrame.height,
                width: buttonFrame.width,
                height: 0
            )
            
            // 드롭다운 선택 시 버튼 업데이트
            unitDropDownView?.didSelectUnit = { [weak self] (selectedUnit: String) in
                guard let self = self else { return }
                
                self.detailView.unitButtonTitle.text = selectedUnit
                self.hideDropdown(unitDropDownView)
                self.unitDropDownView = nil
                self.isUnitDropDownView = false
            }
        }
        
        // 드롭다운이 이미 보이는지 확인
        if isUnitDropDownView {
            // 드롭다운이 보이면 숨김
            self.hideDropdown(unitDropDownView)
            isUnitDropDownView = false
        } else {
            // 드롭다운 추가
            detailView.addSubview(unitDropDownView)
            UIView.animate(withDuration: 0.2) {
                self.unitDropDownView.frame.size.height = 150
                self.unitDropDownView.backgroundColor = UIColor.white
            }
            
            detailView.addSubview(detailView.line)
            detailView.line.snp.makeConstraints {
                $0.top.equalTo(detailView.unitButton.snp.bottom)
                $0.centerX.equalTo(detailView.unitButton)
                $0.width.equalTo(92)
                $0.height.equalTo(1)
            }
            detailView.line2.isHidden = false
            isUnitDropDownView = true
        }
    }
    
    // 드롭다운 숨기기 메서드
    private func hideDropdown(_ dropdownView: UnitDropdownView) {
        print("숨기기")
        detailView.unitButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        detailView.line2.isHidden = true
        dropdownView.removeFromSuperview()
        UIView.animate(withDuration: 0.2, animations: {
            dropdownView.frame.size.height = 0
        }) { _ in
            dropdownView.removeFromSuperview()
        }
    }
    
    @objc private func didTapShareButton() {
        selectedMethod = "나눔"
        detailView.updateButtonStyle(
            selectedButton: detailView.shareButton,
            deselectedButton: detailView.exchangeButton
        )
    }
    
    @objc private func didTapExchangeButton() {
        selectedMethod = "교환"
        detailView.updateButtonStyle(
            selectedButton: detailView.exchangeButton,
            deselectedButton: detailView.shareButton
        )
    }
    
    // 품앗이 등록 완료
    @objc private func didTapCompleteButton() {
        if let navigationController = self.navigationController {
            navigationController.popToRootViewController(animated: true)
        } else {
            let mainVC = ExchangeViewController()
            mainVC.modalPresentationStyle = .fullScreen
            present(mainVC, animated: true, completion: nil)
        }
    }
    
    @objc private func imageViewTapped() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 10 // 선택할 수 있는 이미지의 최대 개수 (0은 무제한)
        configuration.filter = .images // 이미지만 선택 가능하도록 필터링
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    // MARK: - UITextViewDelegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        // 키보드가 나타날 때 추가 동작이 필요하면 여기에 작성
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        // 키보드가 사라질 때 추가 동작이 필요하면 여기에 작성
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" { // Return 키가 눌렸을 때
            textView.resignFirstResponder() // 키보드 숨기기
            return false // 기본 동작 방지
        }
        return true
    }
}

extension ExchangeRegisterDetailViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        // 선택된 이미지가 없으면 종료
        guard !results.isEmpty else { return }
        
        // 임시 배열 초기화 (순서 보장을 위해)
        var imagesTemp = [UIImage?](repeating: nil, count: results.count)
        let dispatchGroup = DispatchGroup()
        
        // 모든 이미지 비동기 로드
        for (index, result) in results.enumerated() {
            dispatchGroup.enter()
            let itemProvider = result.itemProvider
            
            // 이미지 로드 시작
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                    DispatchQueue.main.async {
                        defer { dispatchGroup.leave() }
                        guard let self = self, let image = image as? UIImage else { return }
                        
                        // 임시 배열에 저장 (순서 보장)
                        imagesTemp[index] = image
                        
                        // 첫 번째 이미지는 즉시 표시
                        if index == 0 {
                            self.detailView.ingredientImageView.image = image
                        }
                    }
                }
            } else {
                dispatchGroup.leave()
            }
        }
        
        // 모든 이미지 로드 완료 후 처리
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            
            // nil 제거 후 images 배열에 저장
            self.images = imagesTemp.compactMap { $0 }
            print("모든 이미지 로드 완료: \(self.images?.count)장")
        }
    }
}

