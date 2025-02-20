//
//  SettingView.swift
//  DuruDuru
//
//  Created by 임효진 on 1/28/25.
//

import UIKit

class SettingView: UIView {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addComponents()
        constrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components
    
    private let accountTitleLabel = UILabel().then {
        $0.text = "계정"
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = .black
    }
    
    private let padding1 = UIView()
    
    private let emailLabel = UILabel().then {
        $0.text = "이메일"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
    }
    
    private let emailValueLabel = UILabel().then {
        $0.text = "gildong@gmail.com"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
    }
    
    private let emailContentView = UIView()
    
    private let passwordChangeLabel = UILabel().then {
        $0.text = "비밀번호 변경"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
    }
    
    private let phoneChangeLabel = UILabel().then {
        $0.text = "전화번호 변경"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
    }
    
    private let phoneValueLabel = UILabel().then {
        $0.text = "010-1234-5678"
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.textColor = UIColor(hex: 0x37383C, alpha: 0.61)
    }
    
    private let changeButton = UIButton().then {
        $0.setTitle("변경", for: .normal)
        $0.setTitleColor(UIColor(hex: 0x00C269, alpha: 1.0), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    private let phoneContentView = UIView()
    
    private let uniqueIdLabel = UILabel().then {
        $0.text = "두루두루 본인인증"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
    }
    
    private let uniqueIdButton = UIButton().then {
        $0.setTitle("등록", for: .normal)
        $0.setTitleColor(UIColor(hex: 0x00C269, alpha: 1.0), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    private let uniqueIdContentView = UIView()
    
    private let divideLine1 = UIView().then {
        $0.backgroundColor = UIColor(hex: 0x70737C, alpha: 0.08)
    }
    
    private let settingsTitleLabel = UILabel().then {
        $0.text = "설정"
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = .black
    }
    
    private let padding2 = UIView()
    
    private let notificationSettingsLabel = UILabel().then {
        $0.text = "알림 수신 설정"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
    }
    
    private let userManagementLabel = UILabel().then {
        $0.text = "차단 사용자 관리"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
    }
    
    private let videoSettingsLabel = UILabel().then {
        $0.text = "동영상 자동 재생 설정"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
    }
    
    private let videoSettingsButton = UIButton().then {
        $0.setTitle("항상 사용", for: .normal)
        $0.setTitleColor(UIColor(hex: 0x00C269, alpha: 1.0), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    private let videoSettingContentView = UIView()
    
    private let searchPermissionLabel = UILabel().then {
        $0.text = "검색 엔진 허용하기"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
    }
    
    private let searchPermissionDisLabel = UILabel().then {
        $0.text = "나의 관심사와 관련성이 높은 광고들을 우선적으로 제공받을 수 있어요."
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.textColor = UIColor(hex: 0x37383C, alpha: 0.61)
    }
    
    private let searchPermissionButton = UIButton().then {
        $0.setTitle("허용", for: .normal)
        $0.setTitleColor(UIColor(hex: 0x00C269, alpha: 1.0), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    private let searchPermissionContentView = UIView()
    
    private let divideLine2 = UIView().then {
        $0.backgroundColor = UIColor(hex: 0x70737C, alpha: 0.08)
    }
    
    private let otherSettingsTitleLabel = UILabel().then {
        $0.text = "기타"
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = .black
    }
    
    private let padding3 = UIView()
    
    private let privacyPolicyLabel = UILabel().then {
        $0.text = "공지사항"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
    }
    
    private let cacheDataLabel = UILabel().then {
        $0.text = "캐시 데이터 삭제"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
    }
    
    private let updateLabel = UILabel().then {
        $0.text = "최신버전 업데이트"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
    }
    
    private let lastVersion = UILabel().then {
        $0.text = "최신버전:1.0.0"
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.textColor = UIColor(hex: 0x37383C, alpha: 0.61)
    }
    
    private let versionValue = UILabel().then {
        $0.text = "1.0.0"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = UIColor(hex: 0x00C269, alpha: 1.0)
    }
    
    private let versionContentView = UIView()
    
    public let logOutLabel = UILabel().then {
        $0.text = "로그아웃"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
    }
    
    private let withdrawLabel = UILabel().then {
        $0.text = "탈퇴하기"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
    }
    
    private let accountStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    private let settingStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    private let otherSettingsStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    // MARK: - Add Components
    
    private func addComponents() {
        /// accountStackView
        addSubview(accountStackView)
        [
            accountTitleLabel,
            padding1,
            emailContentView,
            passwordChangeLabel,
            phoneContentView,
            uniqueIdContentView
        ].forEach {
            accountStackView.addArrangedSubview($0)
        }
        
        /// eamilContentView
        [
            emailLabel,
            emailValueLabel
        ].forEach {
            emailContentView.addSubview($0)
        }
        
        /// phoneContentView
        [
            phoneChangeLabel,
            phoneValueLabel,
            changeButton
        ].forEach {
            phoneContentView.addSubview($0)
        }
        
        /// uniqueIdContentView
        [
            uniqueIdLabel,
            uniqueIdButton
        ].forEach {
            uniqueIdContentView.addSubview($0)
        }
    
        addSubview(divideLine1)
        
        /// settingStackView
        addSubview(settingStackView)
        [
            settingsTitleLabel,
            padding2,
            notificationSettingsLabel,
            userManagementLabel,
            videoSettingContentView,
            searchPermissionContentView
        ].forEach {
            settingStackView.addArrangedSubview($0)
        }
        
        /// videoSettingContentView
        [
            videoSettingsLabel,
            videoSettingsButton
        ].forEach {
            videoSettingContentView.addSubview($0)
        }
        
        /// searchPermissionContentView
        [
            searchPermissionLabel,
            searchPermissionDisLabel,
            searchPermissionButton
        ].forEach {
            searchPermissionContentView.addSubview($0)
        }
        
        addSubview(divideLine2)
        
        /// otherSettingsStackView
        addSubview(otherSettingsStackView)
        [
            otherSettingsTitleLabel,
            padding3,
            privacyPolicyLabel,
            cacheDataLabel,
            versionContentView,
            logOutLabel,
            withdrawLabel
        ].forEach {
            otherSettingsStackView.addArrangedSubview($0)
        }
        
        /// versionContentView
        [
            updateLabel,
            lastVersion,
            versionValue
        ].forEach {
            versionContentView.addSubview($0)
        }
    }
    
    private func constrains() {
        /// account
        accountTitleLabel.snp.makeConstraints {
            $0.height.equalTo(22)
        }
        
        padding1.snp.makeConstraints {
            $0.height.equalTo(10)
        }
        
        emailContentView.snp.makeConstraints {
            $0.height.equalTo(42)
        }
        
        emailLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        emailValueLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        passwordChangeLabel.snp.makeConstraints {
            $0.height.equalTo(42)
        }
        
        phoneContentView.snp.makeConstraints {
            $0.height.equalTo(54)
        }
        
        phoneChangeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.left.equalToSuperview()
        }
        
        phoneValueLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-10)
            $0.left.equalToSuperview()
        }
        
        changeButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        uniqueIdContentView.snp.makeConstraints {
            $0.height.equalTo(42)
        }
        
        uniqueIdLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        uniqueIdButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        accountStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.right.left.equalToSuperview().inset(16)
        }
        
        divideLine1.snp.makeConstraints {
            $0.top.equalTo(accountStackView.snp.bottom)
            $0.height.equalTo(1)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        /// settings
        settingsTitleLabel.snp.makeConstraints {
            $0.height.equalTo(22)
        }
        
        padding2.snp.makeConstraints {
            $0.height.equalTo(10)
        }
        
        notificationSettingsLabel.snp.makeConstraints {
            $0.height.equalTo(42)
        }
        
        userManagementLabel.snp.makeConstraints {
            $0.height.equalTo(42)
        }
        
        videoSettingContentView.snp.makeConstraints {
            $0.height.equalTo(42)
        }
        
        videoSettingsLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        videoSettingsButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        searchPermissionContentView.snp.makeConstraints {
            $0.height.equalTo(54)
        }
        
        searchPermissionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.left.equalToSuperview()
        }
        
        searchPermissionDisLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-10)
            $0.left.equalToSuperview()
        }
        
        searchPermissionButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        settingStackView.snp.makeConstraints {
            $0.top.equalTo(divideLine1.snp.bottom).offset(10)
            $0.right.left.equalToSuperview().inset(16)
        }
        
        divideLine2.snp.makeConstraints {
            $0.top.equalTo(settingStackView.snp.bottom)
            $0.height.equalTo(1)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        /// otherSettings
        otherSettingsTitleLabel.snp.makeConstraints {
            $0.height.equalTo(22)
        }
        
        padding3.snp.makeConstraints {
            $0.height.equalTo(10)
        }
        
        privacyPolicyLabel.snp.makeConstraints {
            $0.height.equalTo(42)
        }
        
        cacheDataLabel.snp.makeConstraints {
            $0.height.equalTo(42)
        }
        
        versionContentView.snp.makeConstraints {
            $0.height.equalTo(54)
        }
        
        updateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.left.equalToSuperview()
        }
        
        lastVersion.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-10)
            $0.left.equalToSuperview()
        }
        
        versionValue.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        logOutLabel.snp.makeConstraints {
            $0.height.equalTo(42)
        }
        
        withdrawLabel.snp.makeConstraints {
            $0.height.equalTo(42)
        }
        
        otherSettingsStackView.snp.makeConstraints {
            $0.top.equalTo(divideLine2.snp.bottom).offset(10)
            $0.right.left.equalToSuperview().inset(16)
        }
    }
}
