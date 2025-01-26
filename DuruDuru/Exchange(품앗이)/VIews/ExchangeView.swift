//
//  ExchangeView.swift
//  DuruDuru
//
//  Created by 임효진 on 1/23/25.
//

import UIKit

class ExchangeView: UIView {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components
    
    /// 스크롤 뷰
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
        $0.showsHorizontalScrollIndicator = false
    }
    
    let contentView = UIView()
    
    /// "나의 품앗이 목록"  라벨
    let myExchageLabel = UILabel().then {
        $0.text = "나의 품앗이 목록"
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    /// 나의 품앗이 목록
    let myExchangeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.minimumInteritemSpacing = 10
        $0.minimumLineSpacing = 10
        $0.estimatedItemSize = .init(width: 180, height: 80)// 셀 크기
    }).then {
        $0.backgroundColor = .clear
        $0.register(MyExchangeCollectionViewCell.self, forCellWithReuseIdentifier: MyExchangeCollectionViewCell.identifier)
        $0.showsVerticalScrollIndicator = false
    }
    
    /// 구분선
    let dividedLine = UIView().then {
        $0.backgroundColor = UIColor(hex: 0xDCDCDC, alpha: 1.0)
    }
    
    /// "나와 가까운 품앗이"  라벨
    let closeExchageLabel = UILabel().then {
        $0.text = "나와 가까운 품앗이"
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    /// 나눔 버튼
    let shareButton = UIButton().then {
        $0.setTitle("나눔", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
        $0.layer.cornerRadius = 6
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 13)
    }
    
    /// 교환 버튼
    let exchangeButton = UIButton().then {
        $0.setTitle("교환", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
        $0.layer.cornerRadius = 6
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 13)
    }
    
    /// 품앗이 테이블 뷰
    public let exchangeTableView = UITableView().then {
        $0.register(ExchangeTableViewCell.self, forCellReuseIdentifier: ExchangeTableViewCell.identifier)
        $0.separatorStyle = .none
        $0.isScrollEnabled = false

    }
    
    /// 플로팅 버튼
    let floatingButton = UIButton().then {
        $0.setImage(UIImage(named: "exchangeFloating"), for: .normal)
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 0.3
        $0.layer.shadowRadius = 4
    }
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [
            myExchageLabel,
            myExchangeCollectionView,
            dividedLine,
            closeExchageLabel,
            shareButton,
            exchangeButton,
            exchangeTableView
        ].forEach {
            contentView.addSubview($0)
        }
        addSubview(floatingButton)
    }
    
    /// 오토레이아웃 설정
    private func constraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
            $0.bottom.equalTo(exchangeTableView.snp.bottom).offset(20)
        }
        
        myExchageLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.equalToSuperview().offset(16)
        }
        
        myExchangeCollectionView.snp.makeConstraints {
            $0.top.equalTo(myExchageLabel.snp.bottom).offset(12)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(170)
        }
        
        dividedLine.snp.makeConstraints {
            $0.top.equalTo(myExchangeCollectionView.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        
        closeExchageLabel.snp.makeConstraints {
            $0.top.equalTo(dividedLine.snp.bottom).offset(48)
            $0.left.equalToSuperview().offset(16)
        }
        
        shareButton.snp.makeConstraints {
            $0.top.equalTo(closeExchageLabel.snp.bottom).offset(10)
            $0.height.equalTo(32)
            $0.width.equalTo(60)
            $0.left.equalToSuperview().offset(16)
        }
        
        exchangeButton.snp.makeConstraints {
            $0.top.equalTo(closeExchageLabel.snp.bottom).offset(10)
            $0.height.equalTo(32)
            $0.width.equalTo(60)
            $0.left.equalTo(shareButton.snp.right).offset(13)
        }
        
        exchangeTableView.snp.makeConstraints {
            $0.top.equalTo(exchangeButton.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(600)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        floatingButton.snp.makeConstraints {
            $0.width.height.equalTo(68)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-5)
        }
    }
    
    func updateTableViewHeight(dataCnt: Int) {
        exchangeTableView.layoutIfNeeded()
        exchangeTableView.snp.updateConstraints {
            $0.height.equalTo(160 * dataCnt)
        }
    }
}
