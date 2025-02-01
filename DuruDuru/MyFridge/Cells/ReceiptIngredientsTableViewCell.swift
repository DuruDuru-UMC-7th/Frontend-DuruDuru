//
//  ReceiptIngredientsTableView.swift
//  DuruDuru
//
//  Created by 임효진 on 2/1/25.
//

import UIKit

class ReceiptIngredientsTableViewCell: UITableViewCell {
    
    // MARK: - Init
    
    static let identifier: String = "ReceiptIngredientsTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        addComponents()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.ingredientName.text = nil
    }
    
    // MARK: - Components
    
    let containView = UIView().then {
        $0.backgroundColor = UIColor(hex: 0xF4F4F5)
        $0.layer.cornerRadius = 10
    }

    let ingredientName = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 13)
        $0.textColor = UIColor(hex: 0x2E2F33, alpha: 0.88)
    }
    
    let count = UILabel().then {
        $0.text = "X1"
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true 
        $0.backgroundColor = .white
        $0.font = .boldSystemFont(ofSize: 14)
        $0.textColor = UIColor(hex: 0x171719)
        $0.textAlignment = .center
    }
    
    let marginView = UIView().then {
        $0.backgroundColor = .white
    }
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        addSubview(containView)
        addSubview(marginView)
        containView.addSubview(ingredientName)
        containView.addSubview(count)
    }
    
    /// 오토레이아웃 설정
    private func constraints() {
        containView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        ingredientName.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(10)
            $0.right.equalTo(count.snp.left).offset(-100)
        }
        
        count.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-11)
            $0.width.height.equalTo(28)
        }
        
        marginView.snp.makeConstraints {
            $0.top.equalTo(containView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(10)
        }
    }
    
    public func configure(ingredient: ReceiptIngredients) {
        ingredientName.text = ingredient.ingredientName
        count.text = "x" + String(ingredient.count)
        
    }
}
