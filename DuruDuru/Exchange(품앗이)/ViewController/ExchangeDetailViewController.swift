//
//  ExchangeDetailViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 1/24/25.
//

import UIKit

class ExchangeDetailViewController: UIViewController {
    
    private var exchangeDetailView: ExchangeDetailView!
    private var pageControl: UIPageControl!
    private var images: [UIImage] = [.thumbnail, .duruDuru, .duruDuruLogo, .kakaoLogo, .thumbnail, .thumbnail]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exchangeDetailView = ExchangeDetailView(frame: self.view.bounds)
        self.view = exchangeDetailView
        
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
        
        setUpdelegate()
        exchangeDetailView.pageControl.numberOfPages = images.count
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
    }
}

extension ExchangeDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return exchangeDetailView.imageCollectionView.bounds.size
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        exchangeDetailView.pageControl.currentPage = pageIndex
    }
}

