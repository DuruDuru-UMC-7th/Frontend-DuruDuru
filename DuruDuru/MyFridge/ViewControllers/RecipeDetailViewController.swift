//
//  RecipeDetailViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 1/17/25.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    
    private var recipeDetailView: RecipeDetailView!
//    var recipe = RecipeModel(titleImage: String, recipeName: String)
    let mainIngredients = ["계란 2알", "양파 2알", "대파 1/2단", "밥 1공기", "당근 1/2개와 스폰지밥", "계란 2알", "대파 1/2단"]

    override func viewDidLoad() {
        super.viewDidLoad()
        recipeDetailView = RecipeDetailView(frame: self.view.bounds)
        self.view = recipeDetailView
        self.title = "한식 식사"
        if let backImage = UIImage(named: "Arrow3")?.withRenderingMode(.alwaysOriginal) {
            let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
            self.navigationItem.leftBarButtonItem = backButton
        }
        setupDelegate()
        // Do any additional setup after loading the view.
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupDelegate(){
        recipeDetailView.mainIngredientCollectionView.delegate = self
        recipeDetailView.mainIngredientCollectionView.dataSource = self
    }
}

extension RecipeDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainIngredients.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeDetailIngredientsCollectionViewCell.identifier, for: indexPath) as! RecipeDetailIngredientsCollectionViewCell
        cell.tagLabel.text = mainIngredients[indexPath.item]
        return cell
    }

    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = mainIngredients[indexPath.item]
        let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 11)]).width 
        return CGSize(width: width, height: 26) // 높이는 고정
    }
}
