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
    private lazy var duruduruImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "OnLogo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        self.addSubview(duruduruImage)
    }
    
    /// 오토레이아웃 설정
    private func constraints(){
        duruduruImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(402)
            $0.height.equalTo(100)
            $0.top.equalToSuperview().offset(387)
        }
    }
}
