//
//  IngredientDetailView.swift
//  DuruDuru
//
//  Created by 임효진 on 2/7/25.
//

import UIKit

class IngredientDetailView: UIView {

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
    
    // MARK: - Components
    
    let imageView = UIImageView().then {
        $0.image = UIImage(named: "삼겹살")
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 50
        $0.clipsToBounds = true
    }
    
    let containerView = UIView()
    
    let majorCategory = UILabel().then {
        $0.text = "육류 ·"
        $0.textColor = UIColor(hex: 0x7E7E7E, alpha: 1.0)
        $0.font = .systemFont(ofSize: 12)
        $0.textAlignment = .center
    }
    
    let minorCategory = UILabel().then {
        $0.text = "돼지고기"
        $0.textColor = UIColor(hex: 0x7E7E7E, alpha: 1.0)
        $0.font = .systemFont(ofSize: 12)
        $0.textAlignment = .center
    }
    
    let ingredientName = UILabel().then {
        $0.text = "삼겹살"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 18)
        $0.textAlignment = .center
    }
    
    let quantity = UILabel().then {
        $0.text = "수량"
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
        $0.font = .systemFont(ofSize: 10)
        $0.textAlignment = .center
    }
    
    let quantityValue = UILabel().then {
        $0.text = "1"
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
        $0.font = .systemFont(ofSize: 10)
        $0.textAlignment = .center
    }
    
    let storageType = UILabel().then {
        $0.text = "보관방법"
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
        $0.font = .systemFont(ofSize: 10)
        $0.textAlignment = .center
    }
    
    let storageTypeValue = UILabel().then {
        $0.text = "냉장"
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
        $0.font = .systemFont(ofSize: 10)
        $0.textAlignment = .center
    }
    
    let expireDate = UILabel().then {
        $0.text = "소비기한"
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
        $0.font = .systemFont(ofSize: 10)
        $0.textAlignment = .center
    }
    
    let expireDateValue = UILabel().then {
        $0.text = "2024. 02. 08. 까지"
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
        $0.font = .systemFont(ofSize: 10)
        $0.textAlignment = .center
    }
    
    let purchaseDate = UILabel().then {
        $0.text = "구매날짜"
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
        $0.font = .systemFont(ofSize: 10)
        $0.textAlignment = .center
    }
    
    let purchaseDateValue = UILabel().then {
        $0.text = "2024. 01. 25."
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
        $0.font = .systemFont(ofSize: 10)
        $0.textAlignment = .center
    }
    
    let diveideLine = UIView().then {
        $0.backgroundColor = UIColor(hex: 0xDCDCDC, alpha: 1.0)
    }
    
    // '이런 요리는 어떠세요?'
    let label = UILabel().then {
        $0.text = "이런 요리는 어떠세요?"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 13)
        $0.textAlignment = .center
    }
    
    let nextButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.tintColor = .black
    }

    // 레시피 테이블 뷰
    public let recipeTableView = UITableView().then {
        $0.register(RecipeTableViewCell.self, forCellReuseIdentifier: RecipeTableViewCell.identifier)
        $0.separatorStyle = .singleLine
        $0.allowsSelection = true
        $0.isUserInteractionEnabled = true
        $0.showsVerticalScrollIndicator = false
    }
    
    let bottomView = UIView().then {
        $0.backgroundColor = .white
    }
    
    let editIngredient = UIButton().then {
        $0.setTitle("식재료 정보 수정하기", for: .normal)
        $0.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        $0.backgroundColor = UIColor(hex: 0xEFEFEF, alpha: 1.0)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    let deleteIngredient = UIButton().then {
        $0.setTitle("식재료 삭제하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        $0.backgroundColor = UIColor(hex: 0x00C269, alpha: 1.0)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }

    // MARK: - Function
    
    // 컴포넌트 생성
    private func addComponents() {
        
        [
            containerView,
            diveideLine,
            label,
            recipeTableView,
            bottomView
        ].forEach {
            addSubview($0)
        }
        
        [
            imageView,
            majorCategory,
            minorCategory,
            ingredientName,
            quantity,
            quantityValue,
            storageType,
            storageTypeValue,
            expireDate,
            expireDateValue,
            purchaseDate,
            purchaseDateValue,
        ].forEach {
            containerView.addSubview($0)
        }
        
        [
            editIngredient,
            deleteIngredient,
        ].forEach {
            bottomView.addSubview($0)
        }
    }
    
    private func constraints() {
        containerView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(100)
        }
        
        imageView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.bottom.top.equalToSuperview().inset(20)
            $0.height.width.equalTo(100)
        }
        
        majorCategory.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(10)
            $0.top.equalTo(imageView.snp.top)
            $0.height.equalTo(15)
        }
        
        minorCategory.snp.makeConstraints {
            $0.left.equalTo(majorCategory.snp.right)
            $0.top.equalTo(imageView.snp.top)
            $0.height.equalTo(15)
        }
        
        ingredientName.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(10)
            $0.top.equalTo(majorCategory.snp.bottom)
            $0.height.equalTo(30)
        }
        
        quantity.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(10)
            $0.top.equalTo(ingredientName.snp.bottom)
            $0.height.equalTo(14)
        }
        
        quantityValue.snp.makeConstraints {
            $0.left.equalTo(quantity.snp.right).offset(37)
            $0.top.equalTo(ingredientName.snp.bottom)
            $0.height.equalTo(14)
        }
        
        storageType.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(10)
            $0.top.equalTo(quantity.snp.bottom)
            $0.height.equalTo(14)
        }
        
        storageTypeValue.snp.makeConstraints {
            $0.left.equalTo(storageType.snp.right).offset(20)
            $0.top.equalTo(quantity.snp.bottom)
            $0.height.equalTo(14)
        }
        
        expireDate.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(10)
            $0.top.equalTo(storageType.snp.bottom)
            $0.height.equalTo(14)
        }
        
        expireDateValue.snp.makeConstraints {
            $0.left.equalTo(storageType.snp.right).offset(20)
            $0.top.equalTo(storageType.snp.bottom)
            $0.height.equalTo(14)
        }
        
        purchaseDate.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(10)
            $0.top.equalTo(expireDate.snp.bottom)
            $0.height.equalTo(14)
        }
        
        purchaseDateValue.snp.makeConstraints {
            $0.left.equalTo(purchaseDate.snp.right).offset(20)
            $0.top.equalTo(expireDate.snp.bottom)
            $0.height.equalTo(14)
        }
        
        diveideLine.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.equalTo(containerView.snp.bottom).offset(10)
            $0.height.equalTo(1)
        }
        
        label.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.top.equalTo(diveideLine.snp.bottom).offset(10)
            $0.height.equalTo(26)
        }
        
        recipeTableView.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalTo(bottomView.snp.top)
        }
        
        bottomView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(107)
        }
        
        editIngredient.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(10)
            $0.height.equalTo(42)
            $0.width.equalTo((UIScreen.main.bounds.width - 42) / 2)
        }
        
        deleteIngredient.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-16)
            $0.left.equalTo(editIngredient.snp.right).offset(10)
            $0.top.equalToSuperview().offset(10)
            $0.height.equalTo(42)
            $0.width.equalTo((UIScreen.main.bounds.width - 42) / 2)
        }
    }
}
