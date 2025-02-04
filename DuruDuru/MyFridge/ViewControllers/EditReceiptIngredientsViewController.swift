//
//  EditReceiptIngredientsViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 2/1/25.
//

import UIKit

class EditReceiptIngredientsViewController: UIViewController{
    
    // MARK: - Properties
    
    private var editReceiptIngredientsView: EditReceiptIngredientsView!
    var receiptResult: ReceiptResult! /// 영수증 스캔 결과
    private var isEditingMode = false /// 식재료 편집 버튼 상태
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editReceiptIngredientsView = EditReceiptIngredientsView(frame: view.bounds)
        self.view = editReceiptIngredientsView
        
        setupDelegate()
        
        /// configure
        editReceiptIngredientsView.configure(receiptResult: receiptResult)
        
        /// 'X' 버튼
        editReceiptIngredientsView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        /// '이대로 추가할게요' 버튼
        editReceiptIngredientsView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        /// '식재료 편집' 버튼
        editReceiptIngredientsView.editIngredientsButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        /// '저장' 버튼
        editReceiptIngredientsView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Functions
    
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
        
        /// ingredient 수정 API 요청
        for ingredient in receiptResult.ingredients {
            print(ingredient.receiptId)
            print(ingredient.ingredientId)
            print(ingredient.ingredientName)
            print(ingredient.count)
            patchIngredient(ingredietResult: ingredient)
        }
    }
    
    private func setupDelegate(){
        editReceiptIngredientsView.ingredientsTableView.dataSource = self
        editReceiptIngredientsView.ingredientsTableView.delegate = self
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension EditReceiptIngredientsViewController: UITableViewDataSource, UITableViewDelegate, DeleteButtonDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        receiptResult.ingredients.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReceiptIngredientsTableViewCell.identifier, for: indexPath) as? ReceiptIngredientsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(ingredient: receiptResult.ingredients[indexPath.row], isEditing: isEditingMode)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func didTapDeleteButton(in cell: ReceiptIngredientsTableViewCell) {
        guard let indexPath = editReceiptIngredientsView.ingredientsTableView.indexPath(for: cell) else { return }
        
        /// 데이터 모델에서 해당 아이템 삭제
        receiptResult.ingredients.remove(at: indexPath.row)
        
        /// 셀 삭제
        editReceiptIngredientsView.ingredientsTableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func didUpdateCount(in cell: ReceiptIngredientsTableViewCell, newCount: Int) {
        guard let indexPath = editReceiptIngredientsView.ingredientsTableView.indexPath(for: cell) else { return }
        
        /// 데이터 모델에서 카운트 업데이트
        receiptResult.ingredients[indexPath.row].setCount(newCount: newCount)
        
        editReceiptIngredientsView.ingredientsTableView.reloadRows(at: [indexPath], with: .none)
    }
    
    // MARK: - API 관련
    
    func patchIngredient(ingredietResult: IngredientResult) {
        let url = "http://3.35.252.162:8080/OCR/ingredient/24"
        
        /// 쿼리 파라미터
        let queryParameters: [String: Any] = [
            "receiptId": ingredietResult.receiptId,
            "memberId": 2, /// 임시로 넣은 memberId
        ]
        
        let queryString = APIClient.shared.createQueryString(from: queryParameters)
        let urlWithQuery = "\(url)?\(queryString)"
        
        print(urlWithQuery)
        
        /// requestBody
        let requestBody = PatchIngredientRequest(ingredientName: ingredietResult.ingredientName, count: ingredietResult.count)
        
        /// API 요청
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(requestBody)
            let jsonParameters = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
            
            APIClient.shared.request(urlWithQuery, method: .patch, parameters: jsonParameters) { (result: Result<IngredientResponseModel, Error>) in
                switch result {
                case .success(let response):
                    print("!!성공!!")
                    print(response)
                case .failure(let error):
                    print("네트워킹 오류: \(error)")
                }
            }
        } catch {
            print("인코딩 오류: \(error)")
        }
    }
    
}
