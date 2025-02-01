//
//  EditReceiptIngredientsViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 2/1/25.
//

import UIKit

class EditReceiptIngredientsViewController: UIViewController {
    
    private var editReceiptIngredientsView: EditReceiptIngredientsView!
    var receipt = ReceiptModel.dummy()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editReceiptIngredientsView = EditReceiptIngredientsView(frame: view.bounds)
        self.view = editReceiptIngredientsView
        
        setupDelegate()
        editReceiptIngredientsView.configure(receipt: receipt)
        
        editReceiptIngredientsView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        editReceiptIngredientsView.addButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    private func setupDelegate(){
        editReceiptIngredientsView.ingredientsTableView.dataSource = self
        editReceiptIngredientsView.ingredientsTableView.delegate = self
    }
}

extension EditReceiptIngredientsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        receipt.ingredients.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReceiptIngredientsTableViewCell.identifier, for: indexPath) as? ReceiptIngredientsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(ingredient: receipt.ingredients[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
