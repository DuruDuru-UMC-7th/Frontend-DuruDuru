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
    public lazy var duruDuruImage: UIImageView = imageView(name: "두루두루그림")
    
    /// 두루두루 글자
    public lazy var titleImage: UIImageView = imageView(name: "Title")
    
    /// 아래 글자
    public lazy var subTitleImage: UIImageView = imageView(name: "SubTitle")
    
    
    
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
        self.addSubview(duruDuruImage)
        self.addSubview(titleImage)
        self.addSubview(subTitleImage)
    }
    
    /// 오토레이아웃 설정
    private func constraints(){
        duruDuruImage.snp.makeConstraints {
            $0.left.equalToSuperview().offset(138)
            $0.width.equalTo(116.84)
            $0.height.equalTo(116.79)
            $0.top.equalToSuperview().offset(292)
        }
        
        titleImage.snp.makeConstraints {
            $0.left.equalToSuperview().offset(127.5)
            $0.width.equalTo(138.5)
            $0.height.equalTo(56.49)
            $0.top.equalTo(duruDuruImage.snp.bottom).offset(17.21)
        }
        
        subTitleImage.snp.makeConstraints {
            $0.left.equalToSuperview().offset(143)
            $0.width.equalTo(108)
            $0.height.equalTo(22)
            $0.top.equalTo(titleImage.snp.bottom)
        }
    }
}
