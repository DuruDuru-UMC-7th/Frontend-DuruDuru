//
//  EditReceiptIngredientsView.swift
//  DuruDuru
//
//  Created by 임효진 on 2/1/25.
//

import UIKit

class EditReceiptIngredientsView: UIView {

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addComponents()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components
    
    let backButton = UIButton().then {
        let blackImage = UIImage(named: "whiteXButton")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        $0.setImage(blackImage, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }
    
    let titleView = UIView()
    
    let dateTitleLabel = UILabel().then {
        $0.text = "2025년 1월 21일 금요일"
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = UIColor(hex: 0x00C269)
    }
    
    let onLabel = UILabel().then {
        $0.text = "에"
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .black
    }
    
    let subTitleView = UIView()
    
    let totalTitleLabel = UILabel().then {
        $0.text = "총 "
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .black
    }
    
    let countTitleLabel = UILabel().then {
        $0.text = "6개"
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = UIColor(hex: 0x00C269)
    }
    
    let subTitleLabel = UILabel().then {
        $0.text = "의 식재료를 구메하셨네요!"
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .black
    }
    
    let purchaseDateLabel = UILabel().then {
        $0.text = "구매 날짜"
        $0.font = .boldSystemFont(ofSize: 14)
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
    }
    
    let dateView = UIView().then {
        $0.backgroundColor = UIColor(hex: 0xF4F4F5)
        $0.layer.cornerRadius = 10
    }
    
    let buyDateValue = UILabel().then {
        $0.text = "2024년 2월 21일 금요일"
        $0.font = .boldSystemFont(ofSize: 13)
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
    }
    
    let editDateButton = UIButton().then {
        $0.setTitle("수정", for: .normal)
        $0.setTitleColor(UIColor(hex: 0x00C269), for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    let ListOfIngredients = UILabel().then {
        $0.text = "구매한 식재료 목록"
        $0.font = .boldSystemFont(ofSize: 14)
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
    }
    
    let editIngredientsButton = UIButton().then {
        $0.setTitle("식재료 편집", for: .normal)
        $0.setTitleColor(UIColor(hex: 0x00C269), for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    let saveButton = UIButton().then {
        $0.setTitle("저장", for: .normal)
        $0.setTitleColor(UIColor(hex: 0x00C269), for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        $0.isHidden = true
    }
    
    /// 식재료 테이블 뷰
    public let ingredientsTableView = UITableView().then {
        $0.register(ReceiptIngredientsTableViewCell.self, forCellReuseIdentifier: ReceiptIngredientsTableViewCell.identifier)
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
    }
    
    let buttonView = UIView()
    
    let missingButton = UIButton().then {
        $0.setTitle("누락된 식재료가 있어요", for: .normal)
        $0.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        $0.layer.cornerRadius = 8
        $0.backgroundColor = UIColor(hex: 0xEFEFEF, alpha: 1.0)
    }
    
    let addButton = UIButton().then {
        $0.setTitle("이대로 추가할게요", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        $0.layer.cornerRadius = 8
        $0.backgroundColor = UIColor(hex: 0x00C269, alpha: 1.0)
    }
    
    // MARK: - Constaints & Add Function
    
    func addComponents() {
        [
            backButton,
            titleView,
            subTitleView,
            purchaseDateLabel,
            dateView,
            ListOfIngredients,
            editIngredientsButton,
            saveButton,
            ingredientsTableView,
            buttonView
        ].forEach {
            addSubview($0)
        }
        
        [
            dateTitleLabel,
            onLabel,
        ].forEach {
            titleView.addSubview($0)
        }
        
        [
            totalTitleLabel,
            countTitleLabel,
            subTitleLabel
        ].forEach {
            subTitleView.addSubview($0)
        }
        
        [
            buyDateValue,
            editDateButton
        ].forEach {
            dateView.addSubview($0)
        }
        
        [
            missingButton,
            addButton
        ].forEach {
            buttonView.addSubview($0)
        }
    }
    
    func setupConstraints() {
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(67)
            $0.right.equalToSuperview().offset(-40)
            $0.width.height.equalTo(24)
        }
        
        titleView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(130)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(24)
            $0.width.equalTo(258)
        }
        
        dateTitleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(24)
            $0.centerY.equalToSuperview()
        }
        
        onLabel.snp.makeConstraints {
            $0.left.equalTo(dateTitleLabel.snp.right)
            $0.centerY.equalToSuperview()
        }
        
        subTitleView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(24)
            $0.width.equalTo(258)
        }
        
        totalTitleLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        countTitleLabel.snp.makeConstraints {
            $0.left.equalTo(totalTitleLabel.snp.right)
            $0.centerY.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.left.equalTo(countTitleLabel.snp.right)
            $0.centerY.equalToSuperview()
        }
        
        purchaseDateLabel.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(50)
            $0.left.equalToSuperview().offset(16)
        }
        
        dateView.snp.makeConstraints {
            $0.top.equalTo(purchaseDateLabel.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(45)
        }
        
        buyDateValue.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(10)
        }
        
        editDateButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(buyDateValue.snp.right).offset(7)
        }
        
        ListOfIngredients.snp.makeConstraints {
            $0.top.equalTo(dateView.snp.bottom).offset(22)
            $0.left.equalToSuperview().offset(16)
        }
        
        editIngredientsButton.snp.makeConstraints {
            $0.centerY.equalTo(ListOfIngredients)
            $0.right.equalToSuperview().offset(-16)
        }
        
        saveButton.snp.makeConstraints {
            $0.centerY.equalTo(ListOfIngredients)
            $0.right.equalToSuperview().offset(-16)
        }
        
        ingredientsTableView.snp.makeConstraints {
            $0.top.equalTo(editIngredientsButton.snp.bottom).offset(10)
            $0.right.left.equalToSuperview().inset(16)
            $0.bottom.equalTo(buttonView.snp.top).offset(-32)
        }
        
        buttonView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(42)
            $0.width.equalTo(328)
            $0.bottom.equalToSuperview().offset(-55)
        }
        
        missingButton.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
            $0.width.equalTo(159)
        }
        
        addButton.snp.makeConstraints {
            $0.left.equalTo(missingButton.snp.right).offset(10)
            $0.width.equalTo(159)
            $0.top.bottom.equalToSuperview()
        }
    }
    
    func configure(receipt: ReceiptModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: receipt.purchaseDate) {
            dateFormatter.dateFormat = "yyyy년 M월 d일"
            let formattedDate = dateFormatter.string(from: date)
            
            dateTitleLabel.text = "\(formattedDate) \(receipt.week)"
            buyDateValue.text = "\(formattedDate) \(receipt.week)"
        } else {
            dateTitleLabel.text = "날짜 형식 오류"
            buyDateValue.text = "날짜 형식 오류"
        }
        
        countTitleLabel.text = "\(receipt.ingredients.count)개"
        
    }
}
