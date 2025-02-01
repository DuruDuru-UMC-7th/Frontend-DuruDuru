//
//  EditReceiptIngredientsViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 2/1/25.
//

import UIKit

class EditReceiptIngredientsViewController: UIViewController{
    
    private var editReceiptIngredientsView: EditReceiptIngredientsView!
    var receipt = ReceiptModel.dummy()
    private var isEditingMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editReceiptIngredientsView = EditReceiptIngredientsView(frame: view.bounds)
        self.view = editReceiptIngredientsView
        
        setupDelegate()
        editReceiptIngredientsView.configure(receipt: receipt)
        
        editReceiptIngredientsView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        editReceiptIngredientsView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        editReceiptIngredientsView.editIngredientsButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        editReceiptIngredientsView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @objc private func addButtonTapped() {
        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    @objc private func editButtonTapped() {
        isEditingMode.toggle()
        for cell in editReceiptIngredientsView.ingredientsTableView.visibleCells {
            if let ingredientCell = cell as? ReceiptIngredientsTableViewCell {
                ingredientCell.decrementButton.isHidden = !isEditingMode
                ingredientCell.countLabel.isHidden = !isEditingMode
                ingredientCell.incrementButton.isHidden = !isEditingMode
                ingredientCell.deleteButton.isHidden = !isEditingMode
                
                /// count 레이블 숨기기
                ingredientCell.count.isHidden = isEditingMode
            }
        }
        
        /// 모든 셀을 다시 로드
        editReceiptIngredientsView.ingredientsTableView.reloadData()
        
        /// 버튼 상태 조정
        editReceiptIngredientsView.editIngredientsButton.isHidden = true
        editReceiptIngredientsView.saveButton.isHidden = false
        
        /// addButton 비활성화
        editReceiptIngredientsView.addButton.isUserInteractionEnabled = false
        editReceiptIngredientsView.addButton.backgroundColor = UIColor(hex: 0xEFEFEF, alpha: 1.0)
        editReceiptIngredientsView.addButton.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
    }
    
    @objc private func saveButtonTapped() {
        isEditingMode.toggle()
        for cell in editReceiptIngredientsView.ingredientsTableView.visibleCells {
            if let ingredientCell = cell as? ReceiptIngredientsTableViewCell {
                ingredientCell.decrementButton.isHidden = !isEditingMode
                ingredientCell.countLabel.isHidden = !isEditingMode
                ingredientCell.incrementButton.isHidden = !isEditingMode
                ingredientCell.deleteButton.isHidden = !isEditingMode
                
                /// count 레이블 숨기기
                ingredientCell.count.isHidden = isEditingMode
            }
        }
        
        /// 모든 셀을 다시 로드
        editReceiptIngredientsView.ingredientsTableView.reloadData()
        
        /// 버튼 상태 조정
        editReceiptIngredientsView.editIngredientsButton.isHidden = false
        editReceiptIngredientsView.saveButton.isHidden = true
        
        /// addButton 활성화
        editReceiptIngredientsView.addButton.isUserInteractionEnabled = true
        editReceiptIngredientsView.addButton.backgroundColor = UIColor(hex: 0x00C269, alpha: 1.0)
        editReceiptIngredientsView.addButton.setTitleColor(.white, for: .normal)
    }
    
    private func setupDelegate(){
        editReceiptIngredientsView.ingredientsTableView.dataSource = self
        editReceiptIngredientsView.ingredientsTableView.delegate = self
    }
}

extension EditReceiptIngredientsViewController: UITableViewDataSource, UITableViewDelegate, DeleteButtonDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        receipt.ingredients.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReceiptIngredientsTableViewCell.identifier, for: indexPath) as? ReceiptIngredientsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(ingredient: receipt.ingredients[indexPath.row], isEditing: isEditingMode)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func didTapDeleteButton(in cell: ReceiptIngredientsTableViewCell) {
        guard let indexPath = editReceiptIngredientsView.ingredientsTableView.indexPath(for: cell) else { return }
        
        /// 데이터 모델에서 해당 아이템 삭제
        receipt.ingredients.remove(at: indexPath.row)
        
        /// 셀 삭제
        editReceiptIngredientsView.ingredientsTableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func didUpdateCount(in cell: ReceiptIngredientsTableViewCell, newCount: Int) {
        guard let indexPath = editReceiptIngredientsView.ingredientsTableView.indexPath(for: cell) else { return }
        
        /// 데이터 모델에서 카운트 업데이트
        receipt.ingredients[indexPath.row].setCount(newCount: newCount)
        
        editReceiptIngredientsView.ingredientsTableView.reloadRows(at: [indexPath], with: .none)
    }
}
