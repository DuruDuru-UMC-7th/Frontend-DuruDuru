//
//  Nearby.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/26/25.
//


import UIKit
import SnapKit

class NearbyView: UIView {
    
    // MARK: - Components
    
    /// 제목 레이블
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "나와 가까운 품앗이"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    let searchBarContainer = UIView().then {
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.backgroundColor = UIColor(red: 118/255, green: 118/255, blue: 128/255, alpha: 0.12)
    }
    
    /// 검색 바
    let searchBar = UISearchBar().then {
        $0.placeholder = "필요한 식재료를 검색하세요"
        $0.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        $0.backgroundColor = .clear
        // 텍스트 필드 접근
        if let textField = $0.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.systemFont(ofSize: 14)
            textField.textColor = UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.6)
            textField.backgroundColor = .clear
        }
    }
    
    /// "최신순" 버튼
    let recentButton = UIButton().then {
        let configuration = UIButton.Configuration.plain()
        $0.configuration = configuration
        $0.configuration?.image = UIImage(named: "Arrow")
        $0.configuration?.imagePlacement = .trailing // 화살표를 텍스트 오른쪽에 배치
        $0.configuration?.imagePadding = 8 // 텍스트와 이미지 간격
        $0.configuration?.baseForegroundColor = .gray
        $0.configuration?.attributedTitle = AttributedString("최신순", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 12)]))
    }
    
    /// 리스트를 감싸는 StackView
    private let listStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    /// "품앗이 더 보기" 버튼
    private let moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("품앗이 더 보기 ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        addDummyData() // 더미 데이터 추가
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(searchBarContainer)
        searchBarContainer.addSubview(searchBar)
        addSubview(recentButton)
        addSubview(listStackView)
        addSubview(moreButton)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(16.5)
            $0.width.equalTo(148)
            $0.height.equalTo(22)
        }
        
        searchBarContainer.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.left.right.equalToSuperview().inset(16)
            $0.width.equalTo(370)
            $0.height.equalTo(36)
        }
        
        searchBar.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        recentButton.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(19)
            $0.right.equalToSuperview().offset(-16.5)
        }
        
        listStackView.snp.makeConstraints {
            $0.top.equalTo(recentButton.snp.bottom).offset(15)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        moreButton.snp.makeConstraints {
            $0.top.equalTo(listStackView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: - Add Dummy Data
    
    private func addDummyData() {
        let dummyItems = [
            PoomasiItem(imageName: "Kevin", title: "마른 미역", location: "공릉동 · 31초 전", type: "교환", quantity: "수량 1팩", expiration: "남은 소비기한 14일"),
            PoomasiItem(imageName: "Kevin", title: "계란", location: "공릉동 · 24분 전", type: "교환", quantity: "수량 2알", expiration: "남은 소비기한 14일"),
            PoomasiItem(imageName: "Kevin", title: "멸치 다시다", location: "공릉동 · 50분 전", type: "나눔", quantity: "수량 2팩", expiration: "남은 소비기한 1년")
        ]
        
        for item in dummyItems {
            let itemView = createPoomasiItemView(item: item)
            listStackView.addArrangedSubview(itemView)
        }
    }
    
    // MARK: - Create Item View
    
    private func createPoomasiItemView(item: PoomasiItem) -> UIView {
        let containerView = UIView()
        
        // 이미지
        let imageView = UIImageView()
        imageView.image = UIImage(named: item.imageName) // 이미지 설정
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.lightGray // 기본 배경색
        
        // 제목과 위치
        let titleLabel = UILabel()
        titleLabel.text = item.title
        titleLabel.font = .boldSystemFont(ofSize: 14)
        titleLabel.textColor = .black
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = item.location
        subtitleLabel.font = .systemFont(ofSize: 10)
        subtitleLabel.textColor = .gray
        
        // 타입, 수량, 소비기한
        let typeLabel = UILabel()
        typeLabel.text = item.type
        typeLabel.font = .boldSystemFont(ofSize: 14)
        typeLabel.textColor = .black
        
        let quantityLabel = UILabel()
        quantityLabel.text = item.quantity
        quantityLabel.font = .systemFont(ofSize: 11)
        quantityLabel.textColor = .black
        
        let expirationLabel = UILabel()
        expirationLabel.text = item.expiration
        expirationLabel.font = .systemFont(ofSize: 11)
        expirationLabel.textColor = .black
        
        // 제목/위치 수직 스택
        let titleStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        titleStack.axis = .vertical
        titleStack.spacing = 3
        
        // 타입/수량/소비기한 수직 스택
        let infoStack = UIStackView(arrangedSubviews: [typeLabel, quantityLabel, expirationLabel])
        infoStack.axis = .vertical
        infoStack.spacing = 5
        
        // 텍스트 수직 스택 (왼쪽: 제목/위치, 오른쪽: 타입/수량/소비기한)
        let textStack = UIStackView(arrangedSubviews: [titleStack, infoStack])
        textStack.axis = .vertical
        textStack.spacing = 8
        
        // 메인 수평 스택 (왼쪽: 이미지, 오른쪽: 텍스트)
        let mainStack = UIStackView(arrangedSubviews: [imageView, textStack])
        mainStack.axis = .horizontal
        mainStack.spacing = 18
        mainStack.alignment = .top
        
        containerView.addSubview(mainStack)
        mainStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(100) // 이미지 크기 100x100
        }
        
        return containerView
    }
}

// MARK: - PoomasiItem Model

struct PoomasiItem {
    let imageName: String
    let title: String
    let location: String
    let type: String
    let quantity: String
    let expiration: String
}
