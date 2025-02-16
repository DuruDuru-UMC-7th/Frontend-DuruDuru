//
//  ExchangeTableViewCell.swift
//  DuruDuru
//
//  Created by 임효진 on 1/23/25.
//

import UIKit

class ExchangeTableViewCell: UITableViewCell {
    
    // MARK: - Init
    
    static let identifier: String = "recipeTableViewCell"
    var tags = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        selectionStyle = .none
        self.clipsToBounds = false
        self.contentView.clipsToBounds = false
        addComponents()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Components
    
    let container = UIView().then {
        $0.layer.cornerRadius = 10
    }
    
    let statusLabel = UILabel().then {
        $0.text = "품앗이중"
        $0.font = .systemFont(ofSize: 8)
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
        $0.backgroundColor = .white
        $0.textAlignment = .center
    }
    
    /// 대표 이미지
    let titleImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.image = .duruDuruLogo
    }
    
    /// 이름
    let name = UILabel().then {
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 14)
        $0.text = "깐마늘"
    }
    
    /// 위치
    let location = UILabel().then {
        $0.textColor = UIColor(hex: 0x7E7E7E, alpha: 1.0)
        $0.font = .systemFont(ofSize: 10)
        $0.text = "공릉동"
    }
    
    /// 날짜
    let date = UILabel().then {
        $0.textColor = UIColor(hex: 0x7E7E7E, alpha: 1.0)
        $0.font = .systemFont(ofSize: 10)
        $0.text = "1일 전"
    }
    
    /// 나눔인지 교환인지
    let isChange = UILabel().then {
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 12)
        $0.text = "나눔"
    }
    
    /// '수량'
    let quantity = UILabel().then {
        $0.textColor = UIColor(hex: 0x7E7E7E, alpha: 1.0)
        $0.font = .systemFont(ofSize: 10)
        $0.text = "수량"
    }
    
    /// 수량
    let count = UILabel().then {
        $0.textColor = UIColor(hex: 0x7E7E7E, alpha: 1.0)
        $0.font = .systemFont(ofSize: 10)
        $0.text = "10개"
    }
    
    /// '남은 소비기한'
    let remain = UILabel().then {
        $0.text = "남은 소비기한"
        $0.font = .systemFont(ofSize: 10)
        $0.textColor = UIColor(hex: 0x37383C, alpha: 0.61)
    }
    
    /// 남은 소비기한
    let remainDate = UILabel().then {
        $0.text = "10일"
        $0.font = .systemFont(ofSize: 10)
        $0.textColor = UIColor(hex: 0x37383C, alpha: 0.61)
    }
    
    /// 구분선
    let dividedLine = UIView().then {
        $0.backgroundColor = UIColor(hex: 0xDCDCDC, alpha: 1.0)
    }
    
    let moreButton = UIButton().then {
        $0.setImage(UIImage(named: "moreButton")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = UIColor(hex: 0x37383C, alpha: 0.28)
    }
    
    // MARK: - Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        addSubview(container)
        container.addSubview(titleImage)
        container.addSubview(statusLabel)
        
        [
            container,
            name,
            location,
            date,
            isChange,
            quantity,
            count,
            remain,
            remainDate,
            dividedLine,
            moreButton
        ].forEach {
            addSubview($0)
        }
    }
    
    private func constraints() {
        
        titleImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        statusLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.left.equalToSuperview().offset(4)
            $0.width.equalTo(40)
            $0.height.equalTo(16)
        }
        
        container.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-30)
            $0.height.width.equalTo(100)
        }
        
        name.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.left.equalTo(titleImage.snp.right).offset(15)
        }
        
        location.snp.makeConstraints {
            $0.top.equalTo(name.snp.bottom).offset(6)
            $0.left.equalTo(titleImage.snp.right).offset(15)
        }
        
        date.snp.makeConstraints {
            $0.top.equalTo(name.snp.bottom).offset(6)
            $0.left.equalTo(location.snp.right).offset(8)
        }
        
        isChange.snp.makeConstraints {
            $0.top.equalTo(date.snp.bottom).offset(10)
            $0.left.equalTo(titleImage.snp.right).offset(15)
        }
        
        quantity.snp.makeConstraints {
            $0.top.equalTo(isChange.snp.bottom).offset(10)
            $0.left.equalTo(titleImage.snp.right).offset(15)
        }
        
        count.snp.makeConstraints {
            $0.top.equalTo(isChange.snp.bottom).offset(10)
            $0.left.equalTo(quantity.snp.right).offset(10)
        }
        
        remain.snp.makeConstraints {
            $0.top.equalTo(count.snp.bottom).offset(5)
            $0.left.equalTo(titleImage.snp.right).offset(15)
        }
        
        remainDate.snp.makeConstraints {
            $0.top.equalTo(count.snp.bottom).offset(5)
            $0.left.equalTo(remain.snp.right).offset(10)
        }
        
        moreButton.snp.makeConstraints {
            $0.top.equalTo(container.snp.top).offset(4)
            $0.right.equalToSuperview().offset(-8)
        }
        
        dividedLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.right.left.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Configure Cell
    
    func configure(nearbyTradeItem: NearbyTradeItem) {
//        if let imageURL = URL(string: nearbyTradeItem.thumbnailImgURl!) {
//            titleImage.kf.setImage(with: imageURL, placeholder: UIImage(named: "imageNotFound"))
//        } else {
//            titleImage.image = UIImage(named: "imageNotFound")
//        }
        
        name.text = "이름"
        location.text = nearbyTradeItem.eupmyeondong
        
        // createdAt을 Date로 변환
        if let createdDate = createdAtDateFormatter.date(from: nearbyTradeItem.createdAt) {
            date.text = timeAgoSinceDate(createdDate)
        } else {
            date.text = "날짜 형식 오류"
        }
        
        if nearbyTradeItem.tradeType == "SHARE" {
            isChange.text = "나눔"
        } else {
            isChange.text = "교환"
        }
        
        count.text = "\(nearbyTradeItem.ingredientCount)개"
        
        // expiryDate 처리
        if let expiryDate = expiryDateFormatter.date(from: nearbyTradeItem.expiryDate) {
            remainDate.text = dDay(from: expiryDate)
        } else {
            remainDate.text = "만료일 형식 오류"
        }
    }
    
    func timeAgoSinceDate(_ date: Date) -> String {
        let calendar = Calendar.current
        let now = Date()
        
        if calendar.isDateInToday(date) {
            return "오늘"
        } else if let daysAgo = calendar.dateComponents([.day], from: date, to: now).day {
            return "\(daysAgo)일 전"
        } else {
            return "오래 전"
        }
    }
    
    func dDay(from date: Date) -> String {
        let calendar = Calendar.current
        let now = Date()

        if let daysUntilExpiry = calendar.dateComponents([.day], from: now, to: date).day {
            if daysUntilExpiry > 0 {
                return "D-\(daysUntilExpiry)"
            } else if daysUntilExpiry == 0 {
                return "D-Day"
            } else {
                return "지났습니다"
            }
        }
        return "계산 오류"
    }
    
    // DateFormatter 설정
    let createdAtDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // createdAt의 날짜 형식에 맞게 설정
        return formatter
    }()
    
    let expiryDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // expiryDate의 날짜 형식에 맞게 설정
        return formatter
    }()
}
