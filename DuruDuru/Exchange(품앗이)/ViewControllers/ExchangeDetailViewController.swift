//
//  ExchangeDetailViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 1/24/25.
//

import UIKit

class ExchangeDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private var exchangeDetailView: ExchangeDetailView!
    private var pageControl: UIPageControl!
    private var images: [UIImage] = [UIImage(named: "자른미역") ?? UIImage(), .duruDuru, .duruDuruLogo, .kakaoLogo, .thumbnail, .thumbnail]
    var tradeId: Int!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exchangeDetailView = ExchangeDetailView(frame: self.view.bounds)
        self.view = exchangeDetailView
        
        setUpUIBar()
        setUpdelegate()
        exchangeDetailView.updateOtherExchangeViewHeight(dataCnt: 10) /// 다른 품앗이보기 height 설정
        exchangeDetailView.pageControl.numberOfPages = images.count /// 이미지 pageControl
        
        // API 요청
        getTrade(tradeId: tradeId)
    }
    
    // MARK: - Functions
    
    func setUpUIBar() {
        
        /// 상단네비게이션바 투명으로
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
        /// 뒤로 가기 버튼
        let backButton = UIBarButtonItem(image: .arrow3, style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
        backButton.tintColor = .black
        
        /// 내보내기 이미지
        let exportButton = UIBarButtonItem(image: .export, style: .plain, target: self, action: #selector(imageButtonTapped))
        exportButton.tintColor = .black
        
        /// moreButton 추가
        let moreButton = UIBarButtonItem(image: .moreButton, style: .plain, target: self, action: #selector(moreButtonTapped))
        moreButton.tintColor = .black
        
        /// moreButton 오른쪽 간격
        let space2 = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space2.width = 8
        
        /// 오른쪽 바 버튼 항목 설정
        self.navigationItem.rightBarButtonItems = [space2, moreButton, exportButton]
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func imageButtonTapped() {
        print("내보내기 버튼 눌림")
    }
    
    @objc func moreButtonTapped() {
        print("더보기 버튼 눌림")
    }
    
    func setUpdelegate() {
        exchangeDetailView.imageCollectionView.dataSource = self
        exchangeDetailView.imageCollectionView.delegate = self
        exchangeDetailView.otherExchangeCollectionView.dataSource = self
        exchangeDetailView.otherExchangeCollectionView.delegate = self
    }
    
    // MARK: - API 관련
    
    private func getTrade(tradeId: Int) {
        let url = "http://3.35.252.162:8080/trade/\(tradeId)"
        
        APIClient.shared.request(url, method: .get, parameters: nil) { (result: Result<TradeResponse, Error>) in
            switch result {
            case .success(let response):
                if let trade = response.result {
                    self.exchangeDetailView.configure(trade: trade)
                } else {
                    print("에러: trade 값이 nil입니다.")
                }
            case .failure(let error):
                print("네트워킹 오류: \(error)")
            }
        }
    }
}
    
    // MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
    
    extension ExchangeDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            if collectionView == exchangeDetailView.imageCollectionView {
                return 1
            } else if collectionView == exchangeDetailView.otherExchangeCollectionView {
                return 1
            }
            return 0
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == exchangeDetailView.imageCollectionView {
                return images.count
            } else if collectionView == exchangeDetailView.otherExchangeCollectionView {
                return 10
            }
            return 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == exchangeDetailView.imageCollectionView {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                
                cell.contentView.subviews.forEach { $0.removeFromSuperview() }
                
                _ = UIImageView(image: images[indexPath.item]).then {
                    $0.contentMode = .scaleAspectFill
                    $0.clipsToBounds = true
                    cell.contentView.addSubview($0)
                    $0.snp.makeConstraints { make in
                        make.edges.equalToSuperview()
                    }
                }
                
                return cell
            } else if collectionView == exchangeDetailView.otherExchangeCollectionView {
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: OtherExchangeCollectionViewCell.identifier,
                    for: indexPath
                ) as? OtherExchangeCollectionViewCell else {
                    print("cell")
                    return UICollectionViewCell()
                }
                return cell
            }
            return UICollectionViewCell()
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            if collectionView == exchangeDetailView.imageCollectionView {
                return exchangeDetailView.imageCollectionView.bounds.size
            } else if collectionView == exchangeDetailView.otherExchangeCollectionView {
                return CGSize(width: 173, height: 130)
            }
            return CGSize(width: 100, height: 100)
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
            exchangeDetailView.pageControl.currentPage = pageIndex
        }
    }
    
