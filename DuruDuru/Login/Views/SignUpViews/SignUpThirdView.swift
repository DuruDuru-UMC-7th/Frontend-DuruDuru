//
//  SingUpThirdView.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/11/25.
//

import UIKit

class SignUpThirdView: UIView {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addComponents()
        constraints()
        
        // 이벤트 리스너 추가
        allCheckButton.addTarget(self, action: #selector(handleAllCheckButtonTapped), for: .touchUpInside)
        addButtonListeners()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -Property
    
    /// 뒤로가기
    public lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Left"), for: .normal) // 버튼 이미지 설정
        button.contentMode = .scaleAspectFit // 이미지 비율 유지
        button.translatesAutoresizingMaskIntoConstraints = false // Auto Layout 사용 시 필수
        return button
    }()
    
    /// "회원가입" 라벨
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.text = "회원가입"
        return label
    }()
    
    /// 경계선
    private lazy var borderLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0x00C269)
        return view
    }()
    
    /// 환영합니다 라벨 이미지
    private lazy var welcomeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "WelcomeLabel")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    /// 첫번째 동의
    lazy var firstCheckButton: CheckButton = {
        let button = CheckButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var firstAgree: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "FirstAgree")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public lazy var firstNext: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "BlackNext"), for: .normal) // 버튼 이미지 설정
        button.contentMode = .scaleAspectFit // 이미지 비율 유지
        button.translatesAutoresizingMaskIntoConstraints = false // Auto Layout 사용 시 필수
        return button
    }()
    
    /// 두번째 동의
    lazy var secondCheckButton: CheckButton = {
        let button = CheckButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var secondAgree: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SecondAgree")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public lazy var secondNext: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "BlackNext"), for: .normal) // 버튼 이미지 설정
        button.contentMode = .scaleAspectFit // 이미지 비율 유지
        button.translatesAutoresizingMaskIntoConstraints = false // Auto Layout 사용 시 필수
        return button
    }()
    
    /// 세번째 동의
    lazy var thirdCheckButton: CheckButton = {
        let button = CheckButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var thirdAgree: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ThirdAgree")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public lazy var thirdNext: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "BlackNext"), for: .normal) // 버튼 이미지 설정
        button.contentMode = .scaleAspectFit // 이미지 비율 유지
        button.translatesAutoresizingMaskIntoConstraints = false // Auto Layout 사용 시 필수
        return button
    }()
    
    /// 네번째 동의
    lazy var fourthCheckButton: CheckButton = {
        let button = CheckButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var fourthAgree: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "FourthAgree")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public lazy var fourthNext: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "GrayNext"), for: .normal) // 버튼 이미지 설정
        button.contentMode = .scaleAspectFit // 이미지 비율 유지
        button.translatesAutoresizingMaskIntoConstraints = false // Auto Layout 사용 시 필수
        return button
    }()
    
    /// 전체 동의
    lazy var allCheckButton: CheckButton = {
        let button = CheckButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var allAgree: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "AllAgree")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    /// 약관동의 경계선
    private lazy var bottomBorderLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray/*.withAlphaComponent(0.5)*/
        return view
    }()
    
    
    
    
    
    
    /// 두루두루 시작하기 버튼
    public lazy var startBtn: UIButton = {
        let btn = UIButton()
        
        // 버튼 제목
        btn.setTitle("두루두루 시작하기", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        btn.setTitleColor(.white, for: .normal)
        
        // 배경 색깔 (Hex값)
        btn.backgroundColor = UIColor(hex: 0x00C269)
        
        // 테두리 색깔
        btn.layer.borderColor = UIColor(hex: 0x00C269)?.cgColor
        btn.layer.borderWidth = 1.0
        
        // 모서리 둥글둥글
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 8
        
        return btn
    }()
    
    
    // MARK: - Functions
    
    // 모든 체크 버튼의 상태를 allCheckButton 상태에 맞게 변경
    @objc private func handleAllCheckButtonTapped() {
        let allChecked = allCheckButton.isChecked
        firstCheckButton.setCheckState(to: allChecked)
        secondCheckButton.setCheckState(to: allChecked)
        thirdCheckButton.setCheckState(to: allChecked)
        fourthCheckButton.setCheckState(to: allChecked)
    }

    // 개별 버튼 이벤트 리스너 추가
    private func addButtonListeners() {
        firstCheckButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        secondCheckButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        thirdCheckButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        fourthCheckButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }

    // 개별 버튼 눌렸을 때 allCheckButton 상태 업데이트
    @objc private func checkButtonTapped() {
        updateAllCheckButtonState()
    }

    // 모든 개별 버튼의 상태에 따라 allCheckButton 상태 업데이트
    private func updateAllCheckButtonState() {
        let isAllChecked = firstCheckButton.isChecked &&
                           secondCheckButton.isChecked &&
                           thirdCheckButton.isChecked &&
                           fourthCheckButton.isChecked
        
        allCheckButton.setCheckState(to: isAllChecked)
    }
    
    
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        self.addSubview(backButton)
        self.addSubview(titleLabel)
        self.addSubview(borderLine)
        self.addSubview(welcomeImage)
        
        self.addSubview(firstCheckButton)
        self.addSubview(firstAgree)
        self.addSubview(firstNext)
        
        self.addSubview(secondCheckButton)
        self.addSubview(secondAgree)
        self.addSubview(secondNext)
        
        self.addSubview(thirdCheckButton)
        self.addSubview(thirdAgree)
        self.addSubview(thirdNext)
        
        self.addSubview(fourthCheckButton)
        self.addSubview(fourthAgree)
        self.addSubview(fourthNext)
        
        self.addSubview(bottomBorderLine)
        
        self.addSubview(allCheckButton)
        self.addSubview(allAgree)
        
        self.addSubview(startBtn)
    }
    
    /// 오토레이아웃 설정
    private func constraints(){
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(65)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(65)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(115)
            $0.height.equalTo(22)
        }
        
        borderLine.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(9)
            $0.left.equalToSuperview()
            $0.width.equalTo(402)
            $0.height.equalTo(2)
        }
        
        welcomeImage.snp.makeConstraints {
            $0.top.equalTo(borderLine.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(371)
            $0.height.equalTo(182)
        }
        
        firstCheckButton.snp.makeConstraints {
            $0.top.equalTo(welcomeImage.snp.bottom).offset(200)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        firstAgree.snp.makeConstraints {
            $0.top.equalTo(welcomeImage.snp.bottom).offset(200)
            $0.left.equalTo(firstCheckButton.snp.right).offset(2)
            $0.height.equalTo(24)
        }
        
        firstNext.snp.makeConstraints {
            $0.top.equalTo(welcomeImage.snp.bottom).offset(200)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(24)
            $0.width.equalTo(24)
        }
        
        secondCheckButton.snp.makeConstraints {
            $0.top.equalTo(firstCheckButton.snp.bottom).offset(15)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        secondAgree.snp.makeConstraints {
            $0.top.equalTo(firstCheckButton.snp.bottom).offset(15)
            $0.left.equalTo(secondCheckButton.snp.right).offset(2)
            $0.height.equalTo(24)
        }
        
        secondNext.snp.makeConstraints {
            $0.top.equalTo(firstNext.snp.bottom).offset(15)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(24)
            $0.width.equalTo(24)
        }
        
        thirdCheckButton.snp.makeConstraints {
            $0.top.equalTo(secondCheckButton.snp.bottom).offset(15)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        thirdAgree.snp.makeConstraints {
            $0.top.equalTo(secondCheckButton.snp.bottom).offset(15)
            $0.left.equalTo(thirdCheckButton.snp.right).offset(2)
            $0.height.equalTo(24)
        }
        
        thirdNext.snp.makeConstraints {
            $0.top.equalTo(secondNext.snp.bottom).offset(15)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(24)
            $0.width.equalTo(24)
        }
        
        fourthCheckButton.snp.makeConstraints {
            $0.top.equalTo(thirdCheckButton.snp.bottom).offset(15)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        fourthAgree.snp.makeConstraints {
            $0.top.equalTo(thirdCheckButton.snp.bottom).offset(15)
            $0.left.equalTo(fourthCheckButton.snp.right).offset(2)
            $0.height.equalTo(24)
        }
        
        fourthNext.snp.makeConstraints {
            $0.top.equalTo(thirdNext.snp.bottom).offset(15)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(24)
            $0.width.equalTo(24)
        }
        
        bottomBorderLine.snp.makeConstraints {
            $0.top.equalTo(fourthAgree.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(370)
            $0.height.equalTo(1)
        }
        
        allCheckButton.snp.makeConstraints {
            $0.top.equalTo(bottomBorderLine.snp.bottom).offset(26)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        allAgree.snp.makeConstraints {
            $0.top.equalTo(bottomBorderLine.snp.bottom).offset(26)
            $0.left.equalTo(fourthCheckButton.snp.right).offset(2)
            $0.height.equalTo(24)
        }
        
        
        startBtn.snp.makeConstraints {
            $0.top.equalTo(allAgree.snp.bottom).offset(75)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(370)
            $0.height.equalTo(47)
        }
    }
}

#Preview{
    SignUpThirdView()
}
