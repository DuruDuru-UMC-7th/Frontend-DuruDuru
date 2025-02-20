//
//  SignUpThirdView.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/11/25.
//

import UIKit
import SnapKit

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
        startBtn.addTarget(self, action: #selector(handleStartBtnTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Property
    
    public lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Left"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.text = "회원가입"
        return label
    }()
    
    private lazy var borderLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0x00C269)
        return view
    }()
    
    private lazy var borderLine2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0x37383C
                                       , alpha: 0.16)
        return view
    }()
    
    private lazy var welcome1: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: 0x00C269)
        label.font = .boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.text = "두루두루"
        return label
    }()
    
    private lazy var welcome2: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.text = "의 새식구,"
        return label
    }()
    
    lazy var nickName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.text = "길동님을 환영해요!"
        return label
    }()
    
    private lazy var discription: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: 0x37383C, alpha: 0.61)
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.text = "약관에 동의하고 두루두루를 시작해보세요."
        return label
    }()
    
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
        button.setImage(UIImage(named: "BlackNext"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
        button.setImage(UIImage(named: "BlackNext"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
        button.setImage(UIImage(named: "BlackNext"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
        button.setImage(UIImage(named: "GrayNext"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
    
    private lazy var bottomBorderLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xCACACA)
        return view
    }()
    
    public lazy var startBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("두루두루 시작하기", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor(hex: 0x00C269)
        btn.layer.borderColor = UIColor(hex: 0x00C269)?.cgColor
        btn.layer.borderWidth = 1.0
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    // MARK: - Functions
    
    @objc private func handleAllCheckButtonTapped() {
        let allChecked = allCheckButton.isChecked
        firstCheckButton.setCheckState(to: allChecked)
        secondCheckButton.setCheckState(to: allChecked)
        thirdCheckButton.setCheckState(to: allChecked)
        fourthCheckButton.setCheckState(to: allChecked)
    }
    
    private func addButtonListeners() {
        firstCheckButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        secondCheckButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        thirdCheckButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        fourthCheckButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    @objc private func checkButtonTapped() {
        updateAllCheckButtonState()
    }
    
    private func updateAllCheckButtonState() {
        let isAllChecked = firstCheckButton.isChecked &&
                           secondCheckButton.isChecked &&
                           thirdCheckButton.isChecked &&
                           fourthCheckButton.isChecked
        allCheckButton.setCheckState(to: isAllChecked)
    }
    
    // MARK: - Start Button Action
    /// 두루두루 시작하기 버튼 눌림 시 조건 검사 후 EmailLoginViewController로 전환
    @objc private func handleStartBtnTapped() {
        // 조건 1: 모든 체크 버튼이 체크된 경우
        let allChecked = firstCheckButton.isChecked && secondCheckButton.isChecked && thirdCheckButton.isChecked && fourthCheckButton.isChecked && allCheckButton.isChecked
        // 조건 2: fourthCheckButton과 allCheckButton을 제외한 위의 세 개의 체크 버튼이 체크된 경우
        let topThreeChecked = firstCheckButton.isChecked && secondCheckButton.isChecked && thirdCheckButton.isChecked
        
        if allChecked || topThreeChecked {
            print("약관 동의 조건 충족")
            changeRootView()
        } else {
            print("필수 약관에 동의하지 않음")
            self.findViewController()?.showAlert(message: "필수 약관에 동의해주세요.")
        }
    }
    
    /// changeRootView: EmailLoginViewController를 루트 뷰컨트롤러로 전환
    private func changeRootView() {
        let rootVC = EmailLoginViewController()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = rootVC
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
    }
    
    // MARK: - Constraints & Add Function
    
    private func addComponents() {
        self.addSubview(backButton)
        self.addSubview(titleLabel)
        self.addSubview(borderLine)
        self.addSubview(borderLine2)
        self.addSubview(welcome1)
        self.addSubview(welcome2)
        self.addSubview(nickName)
        self.addSubview(discription)
        
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
    
    private func constraints() {
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
            $0.width.equalTo(UIScreen.main.bounds.width * (9 / 10))
            $0.height.equalTo(2)
        }
        
        borderLine2.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(9)
            $0.left.equalTo(borderLine.snp.right)
            $0.height.equalTo(2)
            $0.trailing.equalToSuperview()
        }
        
        welcome1.snp.makeConstraints {
            $0.top.equalTo(borderLine.snp.bottom).offset(40)
            $0.left.equalToSuperview().inset(16)
            $0.height.equalTo(35)
        }
        
        welcome2.snp.makeConstraints {
            $0.top.equalTo(borderLine.snp.bottom).offset(40)
            $0.left.equalTo(welcome1.snp.right)
            $0.height.equalTo(35)
        }
        
        nickName.snp.makeConstraints {
            $0.top.equalTo(welcome2.snp.bottom)
            $0.left.equalToSuperview().inset(16)
            $0.height.equalTo(35)
        }
        
        discription.snp.makeConstraints {
            $0.top.equalTo(nickName.snp.bottom).offset(9)
            $0.left.equalToSuperview().inset(16)
            $0.height.equalTo(22)
        }
        
        firstCheckButton.snp.makeConstraints {
            $0.bottom.equalTo(secondCheckButton.snp.top).offset(-11)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        firstAgree.snp.makeConstraints {
            $0.bottom.equalTo(secondCheckButton.snp.top).offset(-11)
            $0.left.equalTo(firstCheckButton.snp.right).offset(2)
            $0.height.equalTo(24)
        }
        
        firstNext.snp.makeConstraints {
            $0.bottom.equalTo(secondCheckButton.snp.top).offset(-11)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(24)
            $0.width.equalTo(24)
        }
        
        secondCheckButton.snp.makeConstraints {
            $0.bottom.equalTo(thirdCheckButton.snp.top).offset(-11)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        secondAgree.snp.makeConstraints {
            $0.bottom.equalTo(thirdCheckButton.snp.top).offset(-11)
            $0.left.equalTo(secondCheckButton.snp.right).offset(2)
            $0.height.equalTo(24)
        }
        
        secondNext.snp.makeConstraints {
            $0.bottom.equalTo(thirdCheckButton.snp.top).offset(-11)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(24)
            $0.width.equalTo(24)
        }
        
        thirdCheckButton.snp.makeConstraints {
            $0.bottom.equalTo(fourthCheckButton.snp.top).offset(-11)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        thirdAgree.snp.makeConstraints {
            $0.bottom.equalTo(fourthCheckButton.snp.top).offset(-11)
            $0.left.equalTo(thirdCheckButton.snp.right).offset(2)
            $0.height.equalTo(24)
        }
        
        thirdNext.snp.makeConstraints {
            $0.bottom.equalTo(fourthCheckButton.snp.top).offset(-11)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(24)
            $0.width.equalTo(24)
        }
        
        fourthCheckButton.snp.makeConstraints {
            $0.bottom.equalTo(bottomBorderLine.snp.top).offset(-40)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        fourthAgree.snp.makeConstraints {
            $0.bottom.equalTo(bottomBorderLine.snp.top).offset(-40)
            $0.left.equalTo(fourthCheckButton.snp.right).offset(2)
            $0.height.equalTo(24)
        }
        
        fourthNext.snp.makeConstraints {
            $0.bottom.equalTo(bottomBorderLine.snp.top).offset(-40)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(24)
            $0.width.equalTo(24)
        }
        
        bottomBorderLine.snp.makeConstraints {
            $0.bottom.equalTo(allCheckButton.snp.top).offset(-26)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        
        allCheckButton.snp.makeConstraints {
            $0.bottom.equalTo(startBtn.snp.top).offset(-74)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        allAgree.snp.makeConstraints {
            $0.centerY.equalTo(allCheckButton)
            $0.left.equalTo(fourthCheckButton.snp.right).offset(2)
            $0.height.equalTo(24)
        }
        
        startBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-40)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(47)
        }
    }
}

// MARK: - UIView Extension to Find Parent ViewController
extension UIView {
    func findViewController() -> UIViewController? {
        var nextResponder: UIResponder? = self
        while let responder = nextResponder {
            if let vc = responder as? UIViewController {
                return vc
            }
            nextResponder = responder.next
        }
        return nil
    }
}
