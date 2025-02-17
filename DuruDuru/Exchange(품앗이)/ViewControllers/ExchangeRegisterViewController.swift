//
//  ExchangeRegisterViewController.swift
//  DuruDuru
//
//  Created by 윤시진 on 1/28/25.
//

import UIKit

class ExchangeRegisterViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: - Properties
    private var exchangeRegisterView: ExchangeRegisterView!
//    private var ingredients: [IngredientsModel] = IngredientsModel.dummy()
    private var selectedIngredient: IngredientsModel?
    private var selectedCircleCellIndex: IndexPath?
    var ingredients: [MyIngredient] = []
    var searchText: String?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exchangeRegisterView = ExchangeRegisterView(frame: self.view.bounds)
        self.view = exchangeRegisterView
        navigationItem.hidesBackButton = true
        hidesBottomBarWhenPushed = true
        setupActions()
        setupCollectionView()
        setUpUI()
        
        exchangeRegisterView.searchBar.delegate = self
        
        /// 키보드 동작을 위한 제스쳐
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Setup
    
    private func setUpUI() {
        // 상단바
        let closeImage = UIImage(systemName: "xmark")
        let closeButton = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(didTapCloseButton))
        self.navigationItem.rightBarButtonItem = closeButton
        closeButton.tintColor = .black
        
        self.title = "품앗이 등록하기"
    }
    
    private func setupActions() {
        exchangeRegisterView.nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }

    private func setupCollectionView() {
        exchangeRegisterView.ingredientsCircleCollectionView.delegate = self
        exchangeRegisterView.ingredientsCircleCollectionView.dataSource = self
    }
    
    @objc private func didTapCloseButton() {
        if let presentingVC = presentingViewController {
            presentingVC.dismiss(animated: true, completion: nil)
        } else if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }

    @objc private func didTapNextButton() {
        guard let selectedIngredient = selectedIngredient else {
            let alert = UIAlertController(title: "선택 오류", message: "식재료를 선택해주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)
            return
        }
        let detailVC = ExchangeRegisterDetailViewController()
        detailVC.configure(with: selectedIngredient)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        /// 키보드 숨기기
        exchangeRegisterView.searchBar.resignFirstResponder()
    }
    
    // 키보드 숨기기
    @objc private func dismissKeyboard() {
        // 키보드가 나타나 있을 때만 숨기기
        if exchangeRegisterView.searchBar.isFirstResponder {
            exchangeRegisterView.searchBar.resignFirstResponder()
            }
        }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        selectedIngredient = ingredients[indexPath.row]
//    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ExchangeRegisterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: IngredientsCircleCollectionViewCell.identifier,
            for: indexPath
        ) as? IngredientsCircleCollectionViewCell else {
            return UICollectionViewCell()
        }
        let ingredient = ingredients[indexPath.item]
        cell.configure(with: ingredient) // 셀에 데이터 설정
        
        if indexPath == selectedCircleCellIndex {
            cell.circleView.layer.borderWidth = 3 // 테두리 두께 설정
            cell.circleView.layer.borderColor = UIColor(hex: 0x4BD9B3, alpha: 1.0).cgColor
        } else {
            cell.circleView.layer.borderWidth = 0 // 테두리 두께 설정
            cell.circleView.layer.borderColor = UIColor(.clear).cgColor
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == exchangeRegisterView.ingredientsCircleCollectionView {
            let screenWidth = UIScreen.main.bounds.width
            let cellSpacing: CGFloat = 5
            let totalSpacing = cellSpacing * 4
            let cellWidth = (screenWidth - totalSpacing - 32) / 3 // 3열 유지

            return CGSize(width: cellWidth, height: cellWidth + 30) // 기존보다 더 키움
        }
        return CGSize(width: 66, height: 26)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        selectedIngredient = ingredients[indexPath.row]
//    }
}
