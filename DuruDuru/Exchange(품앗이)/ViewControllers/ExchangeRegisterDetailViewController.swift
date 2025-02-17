//
//  ExchangeRegisterDetailViewController.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/28/25.
//

import UIKit

class ExchangeRegisterDetailViewController: UIViewController, UITextViewDelegate {
    
    // MARK: - Properties
    private let detailView = ExchangeRegisterDetailView() // 커스텀 뷰
    private var ingredient: IngredientsModel? // 선택된 식재료
    private var quantity: Int = 0
    private var selectedMethod: String? = nil
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setupActions() // 버튼 동작 설정
        setUpUI()
        
        detailView.descriptionTextView.delegate = self
        // 키보드 동작을 위한 제스쳐
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    override func loadView() {
        self.view = detailView // 커스텀 뷰 설정
    }
    
    // MARK: - Configure
    func configure(with ingredient: IngredientsModel) {
        self.ingredient = ingredient
        
        // 전달받은 데이터를 뷰에 반영
        detailView.ingredientNameLabel.text = ingredient.name
        let daysRemaining = ingredient.daysRemaining.replacingOccurrences(of: "D-", with: "")
        detailView.expiryLabel.text = "남은 소비기한 \(daysRemaining)일"
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

        let dropdownView = UnitDropdownView()

        let buttonFrame = detailView.unitButton.convert(detailView.unitButton.bounds, to: window)

        dropdownView.frame = CGRect(
            x: buttonFrame.origin.x,
            y: buttonFrame.origin.y + buttonFrame.height + 5,
            width: buttonFrame.width,
            height: 0
        )

        // 단위 선택 시 버튼 업데이트 + 드롭다운 닫기
        dropdownView.didSelectUnit = { [weak self] selectedUnit in
            guard let self = self else { return }

            self.detailView.unitButton.setTitle("", for: .normal)
            self.detailView.unitButton.setImage(nil, for: .normal)
           
            let unitLabel = UILabel()
            unitLabel.text = selectedUnit
            unitLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            unitLabel.textColor = .black
            unitLabel.textAlignment = .center

            // 기존 서브뷰 제거 후 새롭게 추가
            self.detailView.unitButton.subviews.forEach { $0.removeFromSuperview() }
            self.detailView.unitButton.addSubview(unitLabel)

            unitLabel.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }

            self.hideDropdown(dropdownView)
        }

        // 윈도우에 추가 후 애니메이션 적용
        window.addSubview(dropdownView)
        UIView.animate(withDuration: 0.2) {
            dropdownView.frame.size.height = 150
        }
    }

    // 드롭다운 숨기기
    private func hideDropdown(_ dropdownView: UnitDropdownView) {
        UIView.animate(withDuration: 0.2, animations: {
            dropdownView.alpha = 0
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
    
    @objc private func dismissKeyboard() {
        view.endEditing(true) // 키보드 숨기기
    }
}
