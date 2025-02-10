//
//  MyPageView.swift
//  DuruDuru
//
//  Created by 임효진 on 1/27/25.
//

import UIKit

class MyPageView: UIView {
    
    // MARK: - Properties
    
    private let activities = [
        ("찜한 레시피", "Left Icon1"),
        ("찜한 품앗이", "Left Icon2"),
        ("나의 품앗이 기록", "Left Icon3")
    ]
    
    private let settings = [
        ("앱 설정", "Left Icon4"),
        ("내 동네 설정", "Left Icon5"),
        ("키워드 알림 설정", "Left Icon6")
    ]
    
    private let supports = [
        ("앱 공유하기", "Left Icon7"),
        ("앱 스토어 리뷰 남기기", "Left Icon8"),
        ("약관 및 정책", "Left Icon9"),
        ("의견 남기기", "Left Icon10")
    ]
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addComponents()
        constraints()
        populateData()
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
    
    /// 프로필
    let profileContentView = UIView().then {
        $0.layer.cornerRadius = 20
        $0.backgroundColor = UIColor(hex: 0xF7F7F8)
    }
    
    let profileImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.image = .thumbnail
        $0.layer.cornerRadius = 28
    }
    
    let profileName = UILabel().then {
        $0.text = "공릉동 심청이"
        $0.font = .boldSystemFont(ofSize: 15)
        $0.textColor = .black
    }
    
    let profileGender = UILabel().then {
        $0.text = "여"
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = UIColor(hex: 0x37383C, alpha: 0.61)
    }
    
    let divide = UILabel().then {
        $0.text = "  ·  "
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = UIColor(hex: 0x37383C, alpha: 0.61)
    }
    
    let profilelocation = UILabel().then {
        $0.text = "공릉동"
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = UIColor(hex: 0x37383C, alpha: 0.61)
    }
    
    /// 프로필 편집 버튼
    let profileEditButton = UIButton().then {
        $0.setTitle("프로필 편집", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(hex: 0x00C269, alpha: 1.0)
        $0.layer.cornerRadius = 8
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    private let activityTitleLabel = UILabel().then {
        $0.text = "나의 두루 활동"
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = .black
    }
    
    private let activitySpace = UIView()
    
    private let activityStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
        $0.layer.cornerRadius = 20
        $0.backgroundColor = UIColor(hex: 0xF7F7F8)
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    private let settingTitleLabel = UILabel().then {
        $0.text = "설정"
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = .black
    }
    
    private let settingSpace = UIView()
    
    private let settingStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
        $0.layer.cornerRadius = 20
        $0.backgroundColor = UIColor(hex: 0xF7F7F8)
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    private let supportTitleLabel = UILabel().then {
        $0.text = "고객 지원"
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = .black
    }
    
    private let supportSpace = UIView()
    
    private let supportStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
        $0.layer.cornerRadius = 20
        $0.backgroundColor = UIColor(hex: 0xF7F7F8)
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [
            profileContentView,
            activityStackView,
            settingStackView,
            supportStackView
        ].forEach {
            contentView.addSubview($0)
        }
        
        activityStackView.addArrangedSubview(activityTitleLabel)
        activityStackView.addArrangedSubview(activitySpace)
        settingStackView.addArrangedSubview(settingTitleLabel)
        settingStackView.addArrangedSubview(settingSpace)
        supportStackView.addArrangedSubview(supportTitleLabel)
        supportStackView.addArrangedSubview(supportSpace)
        
        
        [
            profileImage,
            profileName,
            profileGender,
            divide,
            profilelocation,
            profileEditButton
        ].forEach {
            profileContentView.addSubview($0)
        }
    }
    
    /// 오토레이아웃 설정
    private func constraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
            $0.bottom.equalTo(supportStackView.snp.bottom).offset(20)
        }
        
        profileContentView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(96)
            $0.width.equalTo(370)
        }
        
        profileImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.equalToSuperview().offset(11)
            $0.height.width.equalTo(56)
        }
        
        profileName.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.top).offset(6)
            $0.left.equalTo(profileImage.snp.right).offset(6)
        }
        
        profileGender.snp.makeConstraints {
            $0.left.equalTo(profileImage.snp.right).offset(6)
            $0.bottom.equalTo(profileImage.snp.bottom).offset(-10)
        }
        
        divide.snp.makeConstraints {
            $0.left.equalTo(profileGender.snp.right)
            $0.bottom.equalTo(profileImage.snp.bottom).offset(-10)
        }
        
        profilelocation.snp.makeConstraints {
            $0.left.equalTo(divide.snp.right)
            $0.bottom.equalTo(profileImage.snp.bottom).offset(-10)
        }
        
        profileEditButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(28)
            $0.right.equalToSuperview().offset(-11)
            $0.height.equalTo(40)
            $0.width.equalTo(150)
        }
        
        activityStackView.snp.makeConstraints {
            $0.top.equalTo(profileContentView.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        activityTitleLabel.snp.makeConstraints {
            $0.height.equalTo(22)
        }
        
        activitySpace.snp.makeConstraints {
            $0.height.equalTo(10)
        }
        
        settingStackView.snp.makeConstraints {
            $0.top.equalTo(activityStackView.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        settingTitleLabel.snp.makeConstraints {
            $0.height.equalTo(21)
        }
        
        settingSpace.snp.makeConstraints {
            $0.height.equalTo(10)
        }
        
        supportStackView.snp.makeConstraints {
            $0.top.equalTo(settingStackView.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        supportTitleLabel.snp.makeConstraints {
            $0.height.equalTo(21)
        }
        
        supportSpace.snp.makeConstraints {
            $0.height.equalTo(10)
        }
    }
    
    // MARK: - Populate Data
    
    private func populateData() {
        for (title, icon) in activities {
            let rowView = createRowView(title: title, icon: icon)
            activityStackView.addArrangedSubview(rowView)
        }
        let space1 = UIView()
        activityStackView.addArrangedSubview(space1)
        
        for (title, icon) in settings {
            let rowView = createRowView(title: title, icon: icon)
            settingStackView.addArrangedSubview(rowView)
        }
        let space2 = UIView()
        settingStackView.addArrangedSubview(space2)
        
        for (title, icon) in supports {
            let rowView = createRowView(title: title, icon: icon)
            supportStackView.addArrangedSubview(rowView)
        }
        let space3 = UIView()
        supportStackView.addArrangedSubview(space3)
    }
    
    // MARK: - Create Row View
    
    private func createRowView(title: String, icon: String) -> UIView {
        let rowView = UIView()
        
        let titleLabel = UILabel().then {
            $0.text = title
            $0.font = UIFont.systemFont(ofSize: 12)
        }
        
        let iconImageView = UIImageView().then {
            $0.image = UIImage(named: icon)
            $0.tintColor = .green
        }
        
        let arrowButton = UIButton().then {
            let arrowImage = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
                $0.setImage(arrowImage, for: .normal)
                $0.tintColor = UIColor(hex: 0x37383C, alpha: 0.28)
        }
        
        rowView.addSubview(iconImageView)
        rowView.addSubview(titleLabel)
        rowView.addSubview(arrowButton)
        
        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(13)
            $0.width.height.equalTo(18)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        
        arrowButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-7.1)
            $0.centerY.equalToSuperview()
        }
        
        return rowView
    }
}
