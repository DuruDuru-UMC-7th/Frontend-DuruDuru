//
//  RecipeDetailView.swift
//  DuruDuru
//
//  Created by 임효진 on 1/17/25.
//

import UIKit

class RecipeDetailView: UIView {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addComponents()
        constraints()
        configureData()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components
    
    /// 스크롤 뷰
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
        $0.showsHorizontalScrollIndicator = false
    }
    
    let contentView = UIView()
    
    /// 레시피 대표 이미지
    let titleImageView = UIImageView().then {
        $0.image = .thumbnail
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    /// 레시피 이름
    let recipeName = UILabel().then {
        $0.font = .systemFont(ofSize: 24)
        $0.textColor = .black
    }
    
    /// 좋아요 버튼
    let likeButton = UIButton().then {
        $0.setImage(UIImage(named: "Heart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = UIColor(hex: 0x37383C, alpha: 0.61)
    }
    
    ///  조리시간 앞에 있는 아이콘
    let timeIcon = UIImageView().then {
        $0.image = .timeIcon
        $0.contentMode = .scaleAspectFill
    }
    
    /// 조리시간
    let time = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = UIColor(hex: 0x37383C, alpha: 0.61)
    }
    
    /// 레시피 대표 이미지
    let heartIcon = UIImageView().then {
        $0.image = UIImage(named: "Heart")?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = UIColor(hex: 0x37383C, alpha: 0.61)
        $0.contentMode = .scaleAspectFill
    }
    
    /// 찜
    let likeLabel = UILabel().then {
        $0.text = "찜"
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = UIColor(hex: 0x37383C, alpha: 0.61)
    }
    
    /// 찜 수
    let likeCountLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = UIColor(hex: 0x37383C, alpha: 0.61)
    }
    
    /// '개'
    let likeCountUnitLabel = UILabel().then {
        $0.text = "개"
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = UIColor(hex: 0x37383C, alpha: 0.61)
    }
    
    /// 태크 스택 뷰
    let tagsStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
    }
    
    /// 구분선
    let divideLine = UIView().then {
        $0.backgroundColor =  UIColor(hex: 0xDCDCDC)
    }
    
    ///  '1인분 기준'
    let singleServingLabel = UILabel().then {
        $0.text = "1인분 기준"
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .black
    }
    
    ///  '재료'
    let ingredientLabel = UILabel().then {
        $0.text = "재료"
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .black
    }
    
    ///  '주요 재료'
    let mainIngredientLabel = UILabel().then {
        $0.text = "주요 재료"
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .black
    }
    
    /// 주요 재료  스택 뷰
    let mainIngredientsStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
    }
    
    ///  '부가 재료'
    let subIngredientLabel = UILabel().then {
        $0.text = "부가 재료"
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .black
    }
    
    /// 부가 재료 스택 뷰
    let subIngredientStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
    }
    
    ///  '조리법'
    let recipeInstructionsLabel = UILabel().then {
        $0.text = "조리법"
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .black
    }
    
    /// 조리법 스택
    let instructionsStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.alignment = .fill
        $0.distribution = .fill
    }
    // MARK: - Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [
            titleImageView,
            recipeName,
            likeButton,
            timeIcon,
            time,
            heartIcon,
            likeLabel,
            likeCountLabel,
            likeCountUnitLabel,
            tagsStackView,
            divideLine,
            singleServingLabel,
            ingredientLabel,
            mainIngredientLabel,
            mainIngredientsStackView,
            subIngredientLabel,
            subIngredientStackView,
            recipeInstructionsLabel,
            instructionsStackView
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func constraints() {
        
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(9)
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        titleImageView.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(20)
            $0.left.right.equalToSuperview().inset(16)
            $0.width.height.equalTo(370)
        }
        
        recipeName.snp.makeConstraints {
            $0.top.equalTo(titleImageView.snp.bottom).offset(20)
            $0.left.equalToSuperview().inset(16)
        }
        
        likeButton.snp.makeConstraints {
            $0.top.equalTo(titleImageView.snp.bottom).offset(20)
            $0.right.equalToSuperview().inset(16)
        }
        
        timeIcon.snp.makeConstraints {
            $0.top.equalTo(recipeName.snp.bottom).offset(24)
            $0.left.equalToSuperview().inset(16)
        }
        
        time.snp.makeConstraints {
            $0.top.equalTo(recipeName.snp.bottom).offset(23)
            $0.left.equalTo(timeIcon.snp.right).offset(6.22)
        }
        
        heartIcon.snp.makeConstraints {
            $0.top.equalTo(recipeName.snp.bottom).offset(25)
            $0.left.equalTo(time.snp.right).offset(5)
            $0.width.equalTo(12.13)
            $0.height.equalTo(10.88)
        }
        
        likeLabel.snp.makeConstraints {
            $0.top.equalTo(recipeName.snp.bottom).offset(23)
            $0.left.equalTo(heartIcon.snp.right).offset(5.93)
        }
        
        likeCountLabel.snp.makeConstraints {
            $0.top.equalTo(recipeName.snp.bottom).offset(23)
            $0.left.equalTo(likeLabel.snp.right).offset(4)
        }
        
        likeCountUnitLabel.snp.makeConstraints {
            $0.top.equalTo(recipeName.snp.bottom).offset(23)
            $0.left.equalTo(likeCountLabel.snp.right)
        }
        
        tagsStackView.snp.makeConstraints {
            $0.top.equalTo(timeIcon.snp.bottom).offset(18.22)
            $0.left.equalToSuperview().offset(20)
        }
        
        divideLine.snp.makeConstraints {
            $0.top.equalTo(tagsStackView.snp.bottom).offset(13)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        
        singleServingLabel.snp.makeConstraints {
            $0.top.equalTo(divideLine.snp.bottom).offset(12)
            $0.left.equalToSuperview().inset(16)
        }
        
        ingredientLabel.snp.makeConstraints {
            $0.top.equalTo(singleServingLabel.snp.bottom).offset(2)
            $0.left.equalToSuperview().inset(16)
        }
        
        mainIngredientLabel.snp.makeConstraints {
            $0.top.equalTo(ingredientLabel.snp.bottom).offset(23)
            $0.left.equalToSuperview().inset(16)
        }
        
        mainIngredientsStackView.snp.makeConstraints {
            $0.top.equalTo(mainIngredientLabel.snp.bottom).offset(6)
            $0.left.equalToSuperview().inset(16)
        }
        
        subIngredientLabel.snp.makeConstraints {
            $0.top.equalTo(mainIngredientsStackView.snp.bottom).offset(26)
            $0.left.equalToSuperview().inset(16)
        }
        
        subIngredientStackView.snp.makeConstraints {
            $0.top.equalTo(subIngredientLabel.snp.bottom).offset(6)
            $0.left.equalToSuperview().inset(16)
        }
        
        recipeInstructionsLabel.snp.makeConstraints {
            $0.top.equalTo(subIngredientStackView.snp.bottom).offset(13)
            $0.left.equalToSuperview().inset(16)
        }
        
        instructionsStackView.snp.makeConstraints {
            $0.top.equalTo(recipeInstructionsLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(contentView).offset(-20)
        }
    }
    
    private func configureData() {
        recipeName.text = "황금계란볶음밥"
        time.text = "15분"
        likeCountLabel.text = "45"
        
        // 태그 설정
        let tags = ["#간편한", "#한식", "#초보용"]
        for tag in tags {
            let tagLabel = createTagLabel(text: tag)
            tagsStackView.addArrangedSubview(tagLabel)
        }
        
        // 주 재료 설정
        let mainIngredients = ["계란 2알", "양파 2알", "대파 1/2단", "밥 1공기", "당근 1/2개", "어너머냐ㅐ머", "ㅇ노ㅑㅗㅁ"]
        for ingredient in mainIngredients {
            let paddedLabel = createIngredientStackLabel(text: ingredient)
            mainIngredientsStackView.addArrangedSubview(paddedLabel)
        }
        
        // 부 재료 설정
        let subIngredients = ["참기름 1t", "깨 0.5t", "소금 1t", "간장 2t", "후추"]
        for ingredient in subIngredients {
            let paddedLabel = createIngredientStackLabel(text: ingredient)
            subIngredientStackView.addArrangedSubview(paddedLabel)
        }
        
        // 조리법 단계 설정
        let instructions = [
            """
            계란 2개를 풀어 소금 1T을 넣고 잘 섞습니다.
            양파 1/2개, 대파 1줄기, 당근 1/2개를 잘게 다집니다.
            밥 1공기를 준비합니다.
            """,
            """
            팬에 식용유를 두르고 중불로 달군 뒤, 풀어둔 계란을 넣습니다.
            계란이 반쯤 익었을 때 젓가락으로 저어 스크램블을 만듭니다.
            """,
            """
            식용유를 조금 더 두르고 다진 양파, 대파, 당근을 넣고 볶습니다.
            야채가 부드러워질 때까지 중불에서 약 2~3분간 볶습니다.
            """,
            """
            식용유를 조금 더 두르고 다진 양파, 대파, 당근을 넣고 볶습니다.
            야채가 부드러워질 때까지 중불에서 약 2~3분간 볶습니다.
            """,
            """
            식용유를 조금 더 두르고 다진 양파, 대파, 당근을 넣고 볶습니다.
            야채가 부드러워질 때까지 중불에서 약 2~3분간 볶습니다.
            """,
        ]
        
        for (index, instruction) in instructions.enumerated() {
            let instructionLabel = createInstructionLabel(text: instruction, index: index + 1)
            instructionsStackView.addArrangedSubview(instructionLabel)
        }
    }
    
    private func createTagLabel(text: String) -> UIView {
        let containerView = UIView().then {
            $0.backgroundColor = UIColor(hex: 0xEAEBEC)
            $0.layer.cornerRadius = 4
            $0.layer.masksToBounds = true
        }
        
        let label = UILabel().then {
            $0.text = text
            $0.font = .systemFont(ofSize: 12)
            $0.textAlignment = .center
        }
        
        containerView.addSubview(label)
        
        /// 레이블의 패딩 설정
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(6)
            $0.trailing.equalToSuperview().offset(-6)
            $0.top.equalToSuperview().offset(4)
            $0.bottom.equalToSuperview().offset(-4)
        }
        
        return containerView
    }
    
    private func createIngredientStackLabel(text: String) -> UIView {
        let containerView = UIView().then {
            $0.backgroundColor = UIColor(hex: 0xEAEBEC)
            $0.layer.cornerRadius = 4
            $0.layer.masksToBounds = true
        }
        
        let label = UILabel().then {
            $0.text = text
            $0.font = .systemFont(ofSize: 12)
            $0.textAlignment = .center
        }
        
        containerView.addSubview(label)
        
        /// 레이블의 패딩 설정
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.top.equalToSuperview().offset(4)
            $0.bottom.equalToSuperview().offset(-4)
        }
        
        return containerView
    }
    
    private func createInstructionLabel(text: String, index: Int) -> UIView {
        let containerView = UIView().then {
            $0.backgroundColor = UIColor(hex: 0xEAEBEC)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
        }
        
        let label = UILabel().then {
            $0.text = text
            $0.font = .systemFont(ofSize: 11)
            $0.numberOfLines = 0
            /// 줄 간격 설정
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: paragraphStyle
            ]
            
            /// Attributed String 생성
            let attributedString = NSAttributedString(string: text, attributes: attributes)
            $0.attributedText = attributedString
        }
        
        let indexLabel = UILabel().then {
            $0.text = String(index)
            $0.font = .systemFont(ofSize: 15)
        }
        
        containerView.addSubview(indexLabel)
        containerView.addSubview(label)
        
        indexLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(32.5)
            $0.left.equalToSuperview().offset(26)
        }
        
        /// 레이블의 패딩 설정
        label.snp.makeConstraints {
            $0.leading.equalTo(indexLabel.snp.trailing).offset(26)
            $0.trailing.equalToSuperview().offset(-32)
            $0.top.equalToSuperview().offset(25.5)
            $0.bottom.equalToSuperview().offset(-25.5)
        }
        
        return containerView
    }
}
