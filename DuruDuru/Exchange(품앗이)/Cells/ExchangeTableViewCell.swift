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
        selectionStyle = .default
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
    
    /// 대표 이미지
    let titleImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 12
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
        $0.text = "10"
    }
    
    /// '개'
    let countUnitLabel = UILabel().then {
        $0.text = "개"
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = UIColor(hex: 0x37383C, alpha: 0.61)
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
    
    // MARK: - Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        [
            titleImage,
            name,
            location,
            date,
            isChange,
            quantity,
            count,
            countUnitLabel,
            remain,
            remainDate,
            dividedLine
        ].forEach {
            addSubview($0)
        }
    }
    
    private func constraints() {
        
        titleImage.snp.makeConstraints {
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
        
        countUnitLabel.snp.makeConstraints {
            $0.top.equalTo(isChange.snp.bottom).offset(10)
            $0.left.equalTo(count.snp.right)
        }
        
        remain.snp.makeConstraints {
            $0.top.equalTo(countUnitLabel.snp.bottom).offset(5)
            $0.left.equalTo(titleImage.snp.right).offset(15)
        }
        
        remainDate.snp.makeConstraints {
            $0.top.equalTo(countUnitLabel.snp.bottom).offset(5)
            $0.left.equalTo(remain.snp.right).offset(10)
        }
        
        dividedLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.right.left.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
            
}
