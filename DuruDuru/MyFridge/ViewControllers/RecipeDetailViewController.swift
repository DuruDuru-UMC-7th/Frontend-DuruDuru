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
    let mainIngredients = ["계란 2알", "양파 2알", "대파 1/2단", "밥 1공기", "당근 1/2개", "김치 1/2단", "계란 2알", "대파 1/2단"]
    
    let subIngredients = ["참기름", "깨", "간장", "소금", "식초", "물 1L", "백종원", "소고기 180g"]

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
        recipeDetailView.subIngredientCollectionView.delegate = self
        recipeDetailView.subIngredientCollectionView.dataSource = self
    }
}

extension RecipeDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == recipeDetailView.mainIngredientCollectionView {
            return mainIngredients.count
        }else if collectionView == recipeDetailView.subIngredientCollectionView {
            return subIngredients.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == recipeDetailView.mainIngredientCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeDetailIngredientsCollectionViewCell.identifier, for: indexPath) as! RecipeDetailIngredientsCollectionViewCell
            cell.tagLabel.text = mainIngredients[indexPath.item]
            return cell
        } else if collectionView == recipeDetailView.subIngredientCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeDetailIngredientsCollectionViewCell.identifier, for: indexPath) as! RecipeDetailIngredientsCollectionViewCell
            cell.tagLabel.text = subIngredients[indexPath.item]
            return cell
        }
        return UICollectionViewCell()
    }

    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == recipeDetailView.mainIngredientCollectionView {
            let text = mainIngredients[indexPath.item]
            let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 11)]).width
            return CGSize(width: width, height: 26) // 높이는 고정
        } else if collectionView == recipeDetailView.subIngredientCollectionView {
            let text = subIngredients[indexPath.item]
            let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 11)]).width
            return CGSize(width: width, height: 26)
        }
        return CGSize(width: 45, height: 26)
    }
}
