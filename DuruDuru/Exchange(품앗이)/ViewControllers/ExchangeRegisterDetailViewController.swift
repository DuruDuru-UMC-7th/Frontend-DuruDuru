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
    var ingredient: MyIngredient! // 선택된 식재료
    private var quantity: Int = 0
    private var tradeType: String = "SHARE"
    private var isUnitDropDownView: Bool = false
    private var unitDropDownView: UnitDropdownView!
    private var images: [UIImage]!
    private var selectedUnit: String?
    private let placeholderText = "품앗이 할 식재료의 상태를 자세히 설명해주세요.\n건강하고 알뜰한 품앗이 문화를 함께 만들어나가요!"
    private var tradeId: Int! = nil
    
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
        
        checkNextButtonActivation()
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
        checkNextButtonActivation()
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
                self.selectedUnit = selectedUnit
                self.hideDropdown(unitDropDownView)
                self.unitDropDownView = nil
                self.isUnitDropDownView = false
                self.checkNextButtonActivation()
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
        tradeType = "SHARE"
        detailView.updateButtonStyle(
            selectedButton: detailView.shareButton,
            deselectedButton: detailView.exchangeButton
        )
    }
    
    @objc private func didTapExchangeButton() {
        tradeType = "EXCHANGE"
        detailView.updateButtonStyle(
            selectedButton: detailView.exchangeButton,
            deselectedButton: detailView.shareButton
        )
    }
    
    // 품앗이 등록 완료
    @objc private func didTapCompleteButton() {
        setTrade { [weak self] tradeId in
            guard let self = self else { return }
            
            if let tradeId = tradeId {
                let exchangeDetailVC = ExchangeDetailViewController()
                exchangeDetailVC.tradeId = tradeId // tradeId를 ExchangeDetailViewController에 전달
                
                // 화면 전환
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(exchangeDetailVC, animated: true)
                }
            } else {
                // 에러 처리 (예: 알림 표시)
                print("tradeId를 가져오는 데 실패했습니다.")
            }
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
        // 플레이스홀더 텍스트일 때 초기화
        if textView.text == placeholderText && textView.textColor == UIColor(hex: 0xB3B3B3, alpha: 1.0) {
            textView.text = ""
            textView.textColor = .black // 실제 입력 텍스트 색상
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        // 텍스트가 비어있으면 플레이스홀더 표시
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = UIColor(hex: 0xB3B3B3, alpha: 1.0)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" { // Return 키가 눌렸을 때
            textView.resignFirstResponder() // 키보드 숨기기
            return false // 기본 동작 방지
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        checkNextButtonActivation()
    }
    
    // nextButton 활성화 조건 체크
    private func checkNextButtonActivation() {
        let isImageSelected = (images?.count ?? 0) >= 1
        let isQuantityValid = quantity > 0
        let isUnitSelected = selectedUnit != nil
        let isDescriptionValid = !detailView.descriptionTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        let isAllValid = isImageSelected && isQuantityValid && isUnitSelected && isDescriptionValid
        
        detailView.updateNextButtonState(isEnabled: isAllValid)
    }
    
    // MARK: - API 관련
    
    // 품앗이 등록 API
    func setTrade(completion: @escaping (Int?) -> Void) {
        let url = "http://3.35.252.162:8080/trade/"
        
        // 쿼리 파라미터
        let queryParameters: [String: Any] = [
            "ingredientId": ingredient.ingredientId
        ]
        
        let queryString = APIClient.shared.createQueryString(from: queryParameters)
        let urlWithQuery = "\(url)?\(queryString)"
        
        // multipart/form-data 요청
        APIClient.shared.uploadTrade(url: urlWithQuery, ingredientCount: self.quantity, body: self.detailView.descriptionTextView.text, tradeType: self.tradeType, images: self.images) { (result: Result<TradeResponse, Error>) in
                switch result {
                case .success(let response):
                    let tradeId = response.result.tradeId
                    completion(tradeId)
                    print("품앗이 등록 성공 \n tradeId: \(response.result.tradeId) \n title: \(response.result.title) \n ingredientCount: \(response.result.ingredientCount) \n tradeType: \(response.result.tradeType)")
                case .failure(let error):
                    print("식재료 이미지 등록 네트워킹 오류: \(error)")
                    completion(nil)
                }
            }
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
            self.checkNextButtonActivation()
        }
    }
}

