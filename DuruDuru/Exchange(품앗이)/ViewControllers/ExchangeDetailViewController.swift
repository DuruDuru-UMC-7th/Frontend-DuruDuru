//
//  ExchangeDetailViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 1/24/25.
//

import UIKit
import SwiftUI

class ExchangeDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private var exchangeDetailView: ExchangeDetailView!
    private var pageControl: UIPageControl!
    private var images: [UIImage] = [UIImage(named: "자른미역") ?? UIImage(), .duruDuru, .duruDuruLogo, .kakaoLogo, .thumbnail, .thumbnail]
    var tradeId: Int!
    var otherTradeList: [OtherTrade] = []
    var isLiked: Bool = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exchangeDetailView = ExchangeDetailView(frame: self.view.bounds)
        self.view = exchangeDetailView
        
        setUpUIBar()
        setUpdelegate()
        exchangeDetailView.pageControl.numberOfPages = images.count /// 이미지 pageControl
        exchangeDetailView.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        exchangeDetailView.actionButton.addTarget(self, action: #selector(requestTradeTapped), for: .touchUpInside)
        
        // API 요청
        getTrade(tradeId: tradeId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // API 요청
        getOtherTrade(tradeId: self.tradeId)
    }
    
    // MARK: - Functions
    
    func setUpUIBar() {
        
        /// 상단네비게이션바 투명으로
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
        /// 뒤로 가기 버튼
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
        backButton.tintColor = .black
        
        /// 내보내기 이미지
        let exportButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(imageButtonTapped)) // 'push'를 유효한 아이콘으로 변경
            exportButton.tintColor = .black
        
        /// moreButton 추가
        let moreButton = UIBarButtonItem(image: UIImage(named: "moreButton"), style: .plain, target: self, action: #selector(moreButtonTapped))
        moreButton.tintColor = .black
        
        /// moreButton 오른쪽 간격
        let space2 = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space2.width = 8
        
        /// 오른쪽 바 버튼 항목 설정
        self.navigationItem.rightBarButtonItems = [space2, moreButton, exportButton]
    }
    
    @objc func backButtonTapped() {
        if let presentingVC = presentingViewController {
            presentingVC.dismiss(animated: true, completion: nil)
        } else if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        } else {
        }
    }
    
    @objc func imageButtonTapped() {
        print("내보내기 버튼 눌림")
    }
    
    @objc func moreButtonTapped() {
        print("더보기 버튼 눌림")
    }
    
    /// 품앗이 요청: 채팅방 접속
    @objc func requestTradeTapped() {
        ChattingRoomMakeAPI.shared.createChatRoom(tradeId: self.tradeId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let chatRoomId):
                    print("채팅방 생성 성공: \(chatRoomId)")
                    let chatView = ChatView(chatRoomId: chatRoomId,
                                            username: self.exchangeDetailView.profileName.text ?? "")
                    let hostingController = UIHostingController(rootView: chatView)
                    self.navigationController?.pushViewController(hostingController, animated: true)
                case .failure(let error):
                    print("채팅방 생성 실패: \(error.localizedDescription)")
                }
            }
        }
    }
    
    @objc func likeButtonTapped() {
        if isLiked {
            // 좋아요를 눌렀을 경우 좋아요 취소
            exchangeDetailView.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            exchangeDetailView.likeButton.tintColor = UIColor(hex: 0x00C269, alpha: 1.0)
            isLiked = false
            deleteLikeTrade(tradeId: self.tradeId)
        } else {
            exchangeDetailView.likeButton.setImage(UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
            exchangeDetailView.likeButton.tintColor = UIColor(hex: 0x00C269, alpha: 1.0)
            isLiked = true
            likeTrade(tradeId: self.tradeId)
        }
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
                self.exchangeDetailView.configure(trade: response.result)
                self.isLiked = response.result.liked
                if self.isLiked {
                    self.exchangeDetailView.likeButton.setImage(UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
                    self.exchangeDetailView.likeButton.tintColor = UIColor(hex: 0x00C269, alpha: 1.0)
                }
            case .failure(let error):
                print("네트워킹 오류: \(error)")
            }
        }
    }
    
    private func getOtherTrade(tradeId: Int) {
        let url = "http://3.35.252.162:8080/trade/other-trade"
        
        let queryParameters: [String: Any] = [
            "tradeId": tradeId // 임시로 넣은 memberId
        ]
        
        let queryString = APIClient.shared.createQueryString(from: queryParameters)
        let urlWithQuery = "\(url)?\(queryString)"
        
        APIClient.shared.request(urlWithQuery, method: .get) { (result: Result<OtherTradeResponse, Error>) in
            switch result {
            case .success(let response):
                print("다른 품앗이 둘러보기 조회 성공: \(response.result.totalCount)")
                self.otherTradeList = response.result.tradeList
                self.exchangeDetailView.updateOtherExchangeViewHeight(dataCnt: self.otherTradeList.count)
                self.exchangeDetailView.otherExchangeCollectionView.reloadData()
            case .failure(let error):
                print("네트워킹 오류: \(error)")
            }
        }
    }
    
    // 품앗이 찜하기
    private func likeTrade(tradeId: Int) {
        let url = "http://3.35.252.162:8080/trade/like/\(tradeId)"
        
        APIClient.shared.request(url, method: .post) { (result: Result<LikeTradeResponse, Error>) in
            switch result {
            case .success(let response):
                print("품앗이 좋아요 성공 memberId: \(response.result.memberId), tradeId: \(response.result.tradeId)")
                self.getLikeCount(tradeId: self.tradeId)
            case .failure(let error):
                print("네트워킹 오류: \(error)")
            }
        }
    }
    
    // 품앗이 찜 취소
    private func deleteLikeTrade(tradeId: Int) {
        let url = "http://3.35.252.162:8080/trade/like/\(tradeId)/delete"
        
        APIClient.shared.request(url, method: .delete) { (result: Result<DeleteLikeTradeResponse, Error>) in
            switch result {
            case .success(let response):
                print(response.message)
                self.getLikeCount(tradeId: self.tradeId)
            case .failure(let error):
                print("네트워킹 오류: \(error)")
            }
        }
    }
    
    // 품앗이 찜 개수 조회
    private func getLikeCount(tradeId: Int) {
        let url = "http://3.35.252.162:8080/trade/like/\(tradeId)/count"
        
        APIClient.shared.request(url, method: .get) { (result: Result<TradeLikeCountResponse, Error>) in
            switch result {
            case .success(let response):
                self.exchangeDetailView.likeCount.text = "\(response.result.likeCount)"
                print("찜 개수 조회 성공 tradeId: \(response.result.tradeId), likeCount: \(response.result.likeCount)")
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
                return otherTradeList.count
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
                    return UICollectionViewCell()
                }
                return cell
            }
            return UICollectionViewCell()
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            if collectionView == exchangeDetailView.imageCollectionView {
                return exchangeDetailView.imageCollectionView.bounds.size
            }
//            else if collectionView == exchangeDetailView.otherExchangeCollectionView {
//                return CGSize(width: 173, height: 130)
//            }
            return CGSize(width: 100, height: 100)
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
            exchangeDetailView.pageControl.currentPage = pageIndex
        }
    }
    
