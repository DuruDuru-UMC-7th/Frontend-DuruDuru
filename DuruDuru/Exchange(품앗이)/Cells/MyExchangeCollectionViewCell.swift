//
//  MyExchangeCollectionViewCell.swift
//  DuruDuru
//
//  Created by 임효진 on 1/23/25.
//

import UIKit

class MyExchangeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Init
    
    static let identifier = "MyExchangeCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
        constraints()
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor(hex: 0x70737C14, alpha: 0.08)?.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components
    
    /// 대표 이미지
    let titleImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.image = .duruDuruLogo
    }
    
    let name = UILabel().then {
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 14)
        $0.text = "깐마늘"
    }
    
    let date = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 9)
        $0.text = "1일 전"
    }
    
    let isChange = UILabel().then {
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 12)
        $0.text = "나눔"
    }
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        addSubview(titleImage)
        addSubview(name)
        addSubview(date)
        addSubview(isChange)
    }
    
    /// 오토레이아웃 설정
    private func constraints() {
        titleImage.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.width.equalTo(80)
        }
        
        name.snp.makeConstraints {
            $0.left.equalTo(titleImage.snp.right).offset(15)
            $0.top.equalToSuperview().offset(6)
        }
        
        date.snp.makeConstraints {
            $0.left.equalTo(titleImage.snp.right).offset(15)
            $0.top.equalTo(name.snp.bottom).offset(6)
        }
        
        isChange.snp.makeConstraints {
            $0.left.equalTo(titleImage.snp.right).offset(15)
            $0.top.equalTo(date.snp.bottom).offset(10)
        }
    }
}
