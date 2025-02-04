//
//  SettingTownView.swift
//  DuruDuru
//
//  Created by 임효진 on 2/4/25.
//

import MapKit
import UIKit

class SettingTownView: UIView {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
        constraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components
    
    let map = MKMapView()
    
    let bottomBarView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.masksToBounds = true
    }
    
    let locationValue1 = UILabel().then {
        $0.text = "서울특별시 노원구 공릉동"
        $0.font = .boldSystemFont(ofSize: 22)
        $0.textColor = .black
    }
    
    let locationValue2 = UILabel().then {
        $0.text = "서울특별시 성북구 보문로34다길 2"
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    /// '동네 설정 완료' 버튼
    let completeSettingTownButton = UIButton().then {
        $0.setTitle("동네 설정 완료", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(hex: 0x00C269, alpha: 1.0)
        $0.layer.cornerRadius = 10
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        addSubview(map)
        addSubview(bottomBarView)
        bottomBarView.addSubview(locationValue1)
        bottomBarView.addSubview(locationValue2)
        bottomBarView.addSubview(completeSettingTownButton)
    }
    
    /// 오토레이아웃 설정
    private func constraints() {
        map.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.bottom.right.left.equalToSuperview()
        }
        
        bottomBarView.snp.makeConstraints {
            $0.bottom.right.left.equalToSuperview()
            $0.height.equalTo(180)
        }
        
        locationValue1.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.left.equalToSuperview().offset(16)
        }
        
        locationValue2.snp.makeConstraints {
            $0.top.equalTo(locationValue1.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(16)
            $0.height.equalTo(22)
        }
        
        completeSettingTownButton.snp.makeConstraints {
            $0.right.left.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-30)
            $0.height.equalTo(47)
        }
    }
}
