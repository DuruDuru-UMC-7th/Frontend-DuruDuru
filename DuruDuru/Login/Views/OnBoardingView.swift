//
//  LoadingView.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/4/25.
//

import UIKit
import SnapKit

class OnBoardingView: UIView {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addComponents()
        constraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: -Property
    
    /// 두루두루 그림
    private lazy var duruduruImage: UIImageView = imageView(name: "DuruDuruImage")
    
    /// 두루두루 라벨
    private lazy var duruduruLabel: UIImageView = imageView(name: "DuruDuruLabel")
    
    
    
    // MARK: - MakeFunction
    
    /// 이미지뷰 함수
    private func imageView(name: String) -> UIImageView {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: name)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }
    
    
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        self.addSubview(duruduruImage)
        self.addSubview(duruduruLabel)
    }
    
    /// 오토레이아웃 설정
    private func constraints(){
        duruduruImage.snp.makeConstraints {
            $0.left.equalToSuperview().offset(73)
            $0.width.equalTo(256)
            $0.height.equalTo(126)
            $0.top.equalToSuperview().offset(387)
        }
        
        duruduruLabel.snp.makeConstraints {
            $0.top.equalTo(duruduruImage.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(109)
            $0.height.equalTo(46)
        }
    }
}
