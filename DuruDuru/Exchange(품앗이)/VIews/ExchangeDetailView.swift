import UIKit

class ExchangeDetailView: UIView {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addComponents()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components
    
    /// 스크롤뷰
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
        $0.showsHorizontalScrollIndicator = false
    }
    
    let contentView = UIView()
    
    /// 이미지
    let imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 0
    }).then {
        $0.isPagingEnabled = true
        $0.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        $0.showsHorizontalScrollIndicator = false
    }
    
    /// 페이지
    let pageControl = UIPageControl().then {
        $0.currentPage = 0
        $0.pageIndicatorTintColor = .lightGray
        $0.currentPageIndicatorTintColor = .black
    }
    
    /// 프로필 정보
    let profileContainer = UIView()
    
    /// 프로필 이미지
    let profileImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 18
        $0.image = .thum
    }
    
    /// 프로필 이름
    let profileName = UILabel().then {
        $0.text = "공릉동 심청이"
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
        $0.font = .systemFont(ofSize: 14)
    }
    
    /// 프로필 지역
    let profileLocation = UILabel().then {
        $0.text = "공릉동"
        $0.textColor = UIColor(hex: 0x37383C, alpha: 0.61)
        $0.font = .systemFont(ofSize: 12)
    }
    
    /// 시간
    let time = UILabel().then {
        $0.text = "31초 전"
        $0.textColor = UIColor(hex: 0x37383C, alpha: 0.61)
        $0.font = .systemFont(ofSize: 12)
    }
    
    /// 제목
    let title = UILabel().then {
        $0.text = "마른 미역"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 22)
    }
    
    /// 내용
    let content = UILabel().then {
        let text = "미역 가져가세요!\n우리 아버지 구하러 갔다가 오는 길에 주웠어요ㅎ\n생일날 혼.미(혼자만의 미역국) 하기 좋아요"
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5 /// 줄 간격 설정
        
        let attributedString = NSAttributedString(string: text, attributes: [
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 14)
        ])
        
        $0.attributedText = attributedString
        $0.numberOfLines = 0 /// 여러 줄 표시 가능
    }
    
    /// '수량'
    let quantity = UILabel().then {
        $0.textColor = UIColor(hex: 0x37383C, alpha: 0.61)
        $0.font = .systemFont(ofSize: 14)
        $0.text = "수량"
    }
    
    /// 수량
    let count = UILabel().then {
        $0.textColor = UIColor(hex: 0x37383C, alpha: 0.61)
        $0.font = .systemFont(ofSize: 14)
        $0.text = "1팩"
    }
    
    /// '남은 소비기한'
    let remain = UILabel().then {
        $0.text = "남은 소비기한"
        $0.textColor = UIColor(hex: 0x37383C, alpha: 0.61)
        $0.font = .systemFont(ofSize: 14)
    }
    
    /// 남은 소비기한
    let remainDate = UILabel().then {
        $0.text = "10일"
        $0.textColor = UIColor(hex: 0x37383C, alpha: 0.61)
        $0.font = .systemFont(ofSize: 14)
    }
    
    /// 구분선
    let dividedLine = UIView().then {
        $0.backgroundColor = UIColor(hex: 0xDCDCDC, alpha: 1.0)
    }
    
    /// 하단바
    let bottomBar = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor(hex: 0xDCDCDC, alpha: 1.0)?.cgColor
        $0.layer.borderWidth = 1
    }
    
    /// 품앗이 요청 버튼
    let actionButton = UIButton().then {
        $0.setTitle("품앗이 요청", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(hex: 0x00C269, alpha: 1.0)
        $0.layer.cornerRadius = 8
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    /// 좋아요 버튼
    let likeButton = UIButton().then {
        $0.setImage(UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = UIColor(hex: 0x00C269, alpha: 1.0)
    }
    
    /// 좋아요 수
    let likeCount = UILabel().then {
        $0.text = "0"
        $0.textColor = UIColor(hex: 0x37383C, alpha: 0.61)
        $0.font = .systemFont(ofSize: 10)
    }
    
    /// '나눔'
    let share = UILabel().then {
        $0.text = "나눔"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 18)
    }
    
    /// 다른 품앗이 둘러보기
    let otherExchange = UILabel().then {
        $0.text = "다른 품앗이 둘러보기"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 18)
    }
    
    /// 다른 품앗이 collectionView
    let otherExchangeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.minimumInteritemSpacing = 12
        $0.minimumLineSpacing = 14
        $0.estimatedItemSize = .init(width: (UIScreen.main.bounds.width - 56) / 2, height: 130)
    }).then {
        $0.register(OtherExchangeCollectionViewCell.self, forCellWithReuseIdentifier: OtherExchangeCollectionViewCell.identifier)
        $0.showsHorizontalScrollIndicator = false
        $0.isScrollEnabled = false
    }
    
    // MARK: - Function
    
    func addComponents() {
        addSubview(scrollView)
        addSubview(bottomBar)
        scrollView.addSubview(contentView)
        
        [
            imageCollectionView,
            pageControl,
            profileContainer,
            title,
            content,
            quantity,
            count,
            remain,
            remainDate,
            dividedLine,
            otherExchange,
            otherExchangeCollectionView
        ].forEach {
            contentView.addSubview($0)
        }
        
        [
            profileImage,
            profileName,
            profileLocation,
            time
        ].forEach {
            profileContainer.addSubview($0)
        }
        
        [
            actionButton,
            likeButton,
            likeCount,
            share
        ].forEach {
            bottomBar.addSubview($0)
        }
    }
    
    func constraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
            $0.bottom.equalTo(otherExchangeCollectionView.snp.bottom).offset(20)
        }
        
        imageCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(403)
        }
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(24)
            $0.bottom.equalTo(imageCollectionView.snp.bottom).offset(-10)
        }
        
        profileContainer.snp.makeConstraints {
            $0.top.equalTo(imageCollectionView.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(16.5)
            $0.right.equalToSuperview().offset(-16.5)
            $0.height.equalTo(44)
        }
        
        profileImage.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(4)
            $0.height.width.equalTo(36)
        }
        
        profileName.snp.makeConstraints {
            $0.left.equalTo(profileImage.snp.right).offset(5)
            $0.top.equalToSuperview().offset(4)
        }
        
        profileLocation.snp.makeConstraints {
            $0.left.equalTo(profileImage.snp.right).offset(5)
            $0.bottom.equalToSuperview().offset(-4)
        }
        
        time.snp.makeConstraints {
            $0.right.top.equalToSuperview()
        }
        
        title.snp.makeConstraints {
            $0.top.equalTo(profileContainer.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(26.5)
        }
        
        content.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(26.5)
            $0.right.equalToSuperview().offset(-26.5)
        }
        
        quantity.snp.makeConstraints {
            $0.top.equalTo(content.snp.bottom).offset(26)
            $0.left.equalToSuperview().offset(26.5)
        }
        
        count.snp.makeConstraints {
            $0.top.equalTo(content.snp.bottom).offset(26)
            $0.left.equalTo(quantity.snp.right).offset(3)
        }
        
        remain.snp.makeConstraints {
            $0.top.equalTo(quantity.snp.bottom).offset(5)
            $0.left.equalToSuperview().offset(26.5)
        }
        
        remainDate.snp.makeConstraints {
            $0.top.equalTo(quantity.snp.bottom).offset(5)
            $0.left.equalTo(remain.snp.right).offset(3)
        }
        
        dividedLine.snp.makeConstraints {
            $0.top.equalTo(remain.snp.bottom).offset(20)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        bottomBar.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        actionButton.snp.makeConstraints {
            $0.trailing.equalTo(bottomBar).offset(-16)
            $0.top.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-40)
            $0.height.equalTo(40)
            $0.width.equalTo(150)
        }
     
        likeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22.5)
            $0.left.equalToSuperview().offset(24.87)
        }
        
        likeCount.snp.makeConstraints {
            $0.top.equalTo(likeButton.snp.bottom).offset(3)
            $0.bottom.equalToSuperview().offset(-40)
            $0.centerX.equalTo(likeButton)
        }
        
        share.snp.makeConstraints {
            $0.top.equalToSuperview().offset(29)
            $0.left.equalTo(likeButton.snp.right).offset(12.87)
        }
        
        otherExchange.snp.makeConstraints {
            $0.top.equalTo(dividedLine.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(26.5)
        }
        
        otherExchangeCollectionView.snp.makeConstraints {
            $0.top.equalTo(otherExchange.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(600)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    func updateOtherExchangeViewHeight(dataCnt: Int) {
        otherExchangeCollectionView.layoutIfNeeded()
        otherExchangeCollectionView.snp.updateConstraints {
            $0.height.equalTo(144 * round(Double(dataCnt) / 2) + 45)
        }
    }
    
    public func configure(trade: TradeResult) {
        count.text = String(trade.ingredientCount) + "개"
        remainDate.text = trade.expiryDate ?? "10일"
        title.text = trade.title
        content.text = trade.body
        if trade.tradeType == "SHARE"{
            share.text = "나눔"
        } else {
            share.text = "교환"
        }
    }
}
