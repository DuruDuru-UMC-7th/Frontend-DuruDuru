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
    
    /// 왼쪽 그림(두)
    private lazy var duImage: UIImageView = imageView(name: "Du")
    
    /// 오른쪽 그림(루)
    private lazy var ruImage: UIImageView = imageView(name: "Ru")
    
    
    
    
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
        self.addSubview(duImage)
        self.addSubview(ruImage)
    }
    
    /// 오토레이아웃 설정
    private func constraints(){
        duImage.snp.makeConstraints {
            $0.left.equalToSuperview().offset(70)
            $0.width.equalTo(126)
            $0.height.equalTo(126)
            $0.top.equalToSuperview().offset(363)
        }
        
        ruImage.snp.makeConstraints {
            $0.left.equalTo(duImage.snp.right).offset(7)
            $0.width.equalTo(126)
            $0.height.equalTo(126)
            $0.top.equalToSuperview().offset(363)
        }
    }
}
