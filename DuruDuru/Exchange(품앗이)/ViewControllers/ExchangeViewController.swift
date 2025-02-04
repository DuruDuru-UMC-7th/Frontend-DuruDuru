//
//  ExchangeViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 1/23/25.
//

import UIKit

class ExchangeViewController: UIViewController {
    
    // MARK: - Properties
    
    private var exchangeView: ExchangeView!
    private var isFloatingExpanded = false
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exchangeView = ExchangeView(frame: self.view.bounds)
        self.view = exchangeView
        setupDelegate()
        setupActions()
        exchangeView.updateTableViewHeight(dataCnt: 14)
    }
    
    private func setupDelegate(){
        exchangeView.myExchangeCollectionView.dataSource = self
        exchangeView.myExchangeCollectionView.delegate = self
        exchangeView.exchangeTableView.delegate = self
        exchangeView.exchangeTableView.dataSource = self
    }
    
    private func setupActions() {
        exchangeView.floatingButton.addTarget(self, action: #selector(didTapFloatingButton), for: .touchUpInside)
        exchangeView.registerPoomButton.addTarget(self, action: #selector(didTapRegisterPoom), for: .touchUpInside)
        exchangeView.registerTogetherButton.addTarget(self, action: #selector(didTapRegisterTogether), for: .touchUpInside)
    }
    
    /// 플로팅 버튼 클릭 시 동작
    @objc private func didTapFloatingButton() {
        isFloatingExpanded.toggle()
        
        UIView.animate(withDuration: 0.3) {
            self.exchangeView.updateFloatingButtons(isExpanded: self.isFloatingExpanded)
        }
    }
    
    /// "품앗이 등록하기" 버튼 클릭 시 동작
    @objc private func didTapRegisterPoom() {
        let registerVC = ExchangeRegisterViewController()
        registerVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    /// "함께 먹자 등록하기" 버튼 클릭 시 동작
    @objc private func didTapRegisterTogether() {
        let togetherVC = ExchangeRegisterDetailViewController()
        navigationController?.pushViewController(togetherVC, animated: true)
    }
    
    
}

// MARK: - UICollectionView

extension ExchangeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == exchangeView.myExchangeCollectionView {
            return 4
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == exchangeView.myExchangeCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MyExchangeCollectionViewCell.identifier,
                for: indexPath
            ) as? MyExchangeCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
            
        }
        return UICollectionViewCell()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ExchangeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 14
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeTableViewCell.identifier, for: indexPath) as? ExchangeTableViewCell else {
            return UITableViewCell()
        }
        cell.name.text = String(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let exchangeDetailVc = ExchangeDetailViewController()
        exchangeDetailVc.tradeId = 2 /// 임시로 2로 지정
        exchangeDetailVc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(exchangeDetailVc, animated: true)
    }
}
