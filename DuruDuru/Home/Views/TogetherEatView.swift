//
//  TogetherEatView.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/26/25.
//

import UIKit
import SnapKit

class TogetherEatView: UIView {
    
    // MARK: - Components
    
    /// 제목 레이블
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "두루 모여서 함께 먹자!"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    /// 설명 레이블
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "두루 식구들과 따스한 약속을 잡아보세요"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    /// 카드들을 감싸는 StackView
    private let cardStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    /// "함께먹자 둘러보기" 버튼
    private let exploreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("함께먹자 둘러보기", for: .normal)
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
        addDummyCards() // 더미 카드 추가
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(cardStackView)
        addSubview(exploreButton)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(16)
        }
        
        cardStackView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        exploreButton.snp.makeConstraints {
            $0.top.equalTo(cardStackView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: - Add Dummy Cards
    
    private func addDummyCards() {
        let dummyCards = [
            TogetherEatCardModel(imageName: "Kevin", date: "2월 24일 21:00", title: "스팸마요덮밥", location: "노원구 화랑로", gender: "모든 성별", host: "세치네치 · 여", profileImageName: "Kevin"),
            TogetherEatCardModel(imageName: "Kevin", date: "2월 24일 21:00", title: "스팸마요덮밥", location: "노원구 화랑로", gender: "모든 성별", host: "세치네치 · 여", profileImageName: "Kevin"),
            TogetherEatCardModel(imageName: "Kevin", date: "2월 24일 21:00", title: "스팸마요덮밥", location: "노원구 화랑로", gender: "모든 성별", host: "세치네치 · 여", profileImageName: "Kevin"),
            TogetherEatCardModel(imageName: "Kevin", date: "2월 24일 21:00", title: "스팸마요덮밥", location: "노원구 화랑로", gender: "모든 성별", host: "세치네치 · 여", profileImageName: "Kevin")
        ]
        
        let rows = dummyCards.chunked(into: 2) // 2개씩 묶기
        
        for row in rows {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 16
            rowStack.distribution = .fillEqually
            
            for card in row {
                let cardView = createCardView(card: card)
                rowStack.addArrangedSubview(cardView)
            }
            
            cardStackView.addArrangedSubview(rowStack)
        }
    }
    
    // MARK: - Create Card View
    
    private func createCardView(card: TogetherEatCardModel) -> UIView {
        let cardView = UIView()
        cardView.layer.cornerRadius = 8
        cardView.clipsToBounds = true
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor.lightGray.cgColor
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: card.imageName)
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        
        let dateLabel = UILabel()
        dateLabel.text = card.date
        dateLabel.font = .boldSystemFont(ofSize: 14)
        dateLabel.textColor = .white
        dateLabel.textAlignment = .center
        
        let titleLabel = UILabel()
        titleLabel.text = card.title
        titleLabel.font = .boldSystemFont(ofSize: 14)
        titleLabel.textColor = .black
        
        let genderLabel = UILabel()
        genderLabel.text = card.gender
        genderLabel.font = .systemFont(ofSize: 10)
        genderLabel.textColor = .gray
        
        let locationLabel = UILabel()
        locationLabel.text = card.location
        locationLabel.font = .systemFont(ofSize: 10)
        locationLabel.textColor = .gray
        
        let profileImageView = UIImageView()
        profileImageView.image = UIImage(named: card.profileImageName)
        profileImageView.layer.cornerRadius = 12.5
        profileImageView.clipsToBounds = true
        profileImageView.snp.makeConstraints { $0.size.equalTo(16) }
        
        let hostLabel = UILabel()
        hostLabel.text = card.host
        hostLabel.font = .systemFont(ofSize: 10)
        hostLabel.textColor = .gray
        
        // 제목과 성별을 가로로 배치
        let titleGenderStack = UIStackView(arrangedSubviews: [titleLabel, genderLabel])
        titleGenderStack.axis = .horizontal
        titleGenderStack.spacing = 40
        titleGenderStack.alignment = .center
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        // 제목/성별과 위치를 세로로 배치
        let infoStack = UIStackView(arrangedSubviews: [titleGenderStack, locationLabel])
        infoStack.axis = .vertical
        infoStack.spacing = 6
        
        // 프로필 이미지 + 호스트 정보
        let profileStack = UIStackView(arrangedSubviews: [profileImageView, hostLabel])
        profileStack.axis = .horizontal
        profileStack.spacing = 5
        
        let mainStack = UIStackView(arrangedSubviews: [infoStack, profileStack])
        mainStack.axis = .vertical
        mainStack.spacing = 10
        
        cardView.addSubview(imageView)
        cardView.addSubview(dateLabel)
        cardView.addSubview(mainStack)
        
        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(135)
            $0.width.equalTo(180)
        }
        
        dateLabel.snp.makeConstraints {
            $0.bottom.equalTo(imageView.snp.bottom).offset(-5)
            $0.left.right.equalTo(imageView).inset(12)
        }
        
        mainStack.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(7)
            $0.left.right.equalToSuperview().inset(13)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        return cardView
    }
}

// MARK: - TogetherEatCardModel

struct TogetherEatCardModel {
    let imageName: String
    let date: String
    let title: String
    let location: String
    let gender: String
    let host: String
    let profileImageName: String
}

// MARK: - Array Chunking Extension

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}
