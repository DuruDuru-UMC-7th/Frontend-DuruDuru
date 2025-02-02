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
    weak var delegate: DeleteButtonDelegate?
    
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
        
        selectionStyle = .none
        self.clipsToBounds = false
        self.contentView.clipsToBounds = false
        
        addComponents()
        constraints()
        
        self.decrementButton.addTarget(self, action: #selector(decrementButtonClicked), for: .touchUpInside)
        self.incrementButton.addTarget(self, action: #selector(incrementButtonClicked), for: .touchUpInside)
        self.deleteButton.addTarget(self, action: #selector(deleteButtonClicked), for: .touchUpInside)
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
    
    let decrementButton = UIButton().then {
        $0.setImage(.decrementButton, for: .normal)
        $0.layer.cornerRadius = 8.91
        $0.backgroundColor = .white
        $0.isHidden = true
    }
    
    let countLabel = UILabel().then {
        $0.text = "1"
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 14)
        $0.isHidden = true
    }
    
    let incrementButton = UIButton().then {
        $0.setImage(.incrementButton, for: .normal)
        $0.layer.cornerRadius = 8.91
        $0.backgroundColor = .white
        $0.isHidden = true
    }
    
    let deleteButton = UIButton().then {
        $0.setImage(.trash, for: .normal)
        $0.layer.cornerRadius = 4
        $0.backgroundColor = UIColor(hex: 0xD9D9D9)
        $0.tintColor = .white
        $0.isHidden = true
    }
    
    // MARK: - Constaints & Add Function
    
    /// 컴포넌트 생성
    private func addComponents() {
        addSubview(containView)
        addSubview(marginView)
        containView.addSubview(ingredientName)
        containView.addSubview(count)
        
        containView.addSubview(decrementButton)
        containView.addSubview(countLabel)
        containView.addSubview(incrementButton)
        containView.addSubview(deleteButton)
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
        
        deleteButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-11)
            $0.width.height.equalTo(28)
        }
        
        incrementButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalTo(deleteButton.snp.left).offset(-11)
            $0.width.height.equalTo(26)
        }
        
        countLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.equalTo(14)
            $0.right.equalTo(incrementButton.snp.left).offset(-7)
        }
        
        decrementButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalTo(countLabel.snp.left).offset(-7)
            $0.width.height.equalTo(26)
        }
    }
    
    public func configure(ingredient: ResponseIngredientModel, isEditing: Bool) {
        ingredientName.text = ingredient.ingredientName
        count.text = "x" + String(ingredient.count)
        countLabel.text = String(ingredient.count)
        
        decrementButton.isHidden = !isEditing
        countLabel.isHidden = !isEditing
        incrementButton.isHidden = !isEditing
        deleteButton.isHidden = !isEditing
        count.isHidden = isEditing
    }
    
    @objc func decrementButtonClicked() {
        guard let currentCount = Int(countLabel.text ?? "0"), currentCount > 1 else { return }
        
        let newCount = currentCount - 1
        countLabel.text = "\(newCount)"
        
        delegate?.didUpdateCount(in: self, newCount: newCount)
    }

    @objc func incrementButtonClicked() {
        guard let currentCount = Int(countLabel.text ?? "0") else { return }
        
        let newCount = currentCount + 1
        countLabel.text = "\(newCount)"
        
        delegate?.didUpdateCount(in: self, newCount: newCount)
    }
    
    @objc func deleteButtonClicked() {
        delegate?.didTapDeleteButton(in: self)
    }
}

protocol DeleteButtonDelegate: AnyObject {
    func didTapDeleteButton(in cell: ReceiptIngredientsTableViewCell)
    func didUpdateCount(in cell: ReceiptIngredientsTableViewCell, newCount: Int)
}
