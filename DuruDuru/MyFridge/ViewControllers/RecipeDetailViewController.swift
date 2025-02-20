//
//  RecipeDetailViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 1/17/25.
//

import UIKit
import Kingfisher

class RecipeDetailViewController: UIViewController {
    
    private var recipeDetailView: RecipeDetailView!
    var recipeName: String!
    var recipeDetail: RecipeDetail!
    
    var mainIngredients: [String] = []
    var subIngredients: [String] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeDetailView = RecipeDetailView(frame: self.view.bounds)
        self.view = recipeDetailView
        setupDelegate()
        fetchRecipeDetail()
//        self.title = "레시피 상세"
        
        /// 뒤로 가기 버튼
        let backImage = UIImage(systemName: "chevron.left")
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
        backButton.tintColor = .black
        
        /// 내보내기 버튼
        let image = UIImage(named: "push")
        let imageButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(imageButtonTapped))
        imageButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = imageButton
    }
    
    // MARK: - Function
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func imageButtonTapped() {
        print("내보내기 버튼 눌림")
    }
    
    private func setupDelegate(){
        recipeDetailView.mainIngredientCollectionView.delegate = self
        recipeDetailView.mainIngredientCollectionView.dataSource = self
        recipeDetailView.subIngredientCollectionView.delegate = self
        recipeDetailView.subIngredientCollectionView.dataSource = self
    }
    
    // MARK: -- API
    
    private func fetchRecipeDetail() {
        guard let recipeName = recipeName else {
            print("레시피 이름이 없음")
            return
        }
        
        let baseUrl = "http://3.35.252.162:8080/recipes/\(recipeName)"
        
        APIClient.shared.request(baseUrl, method: .get) { (result: Result<RecipeDetailResponse, Error>) in
            switch result {
            case .success(let response):
                print("레시피 상세 조회 성공: \(response)")
                self.recipeDetail = response.result
                
                self.recipeDetailView.configure(recipe: self.recipeDetail)
                self.mainIngredients = response.result.ingredientList
                self.subIngredients = response.result.ingredientList
                print(self.mainIngredients)
                self.recipeDetailView.mainIngredientCollectionView.reloadData()
                self.recipeDetailView.subIngredientCollectionView.reloadData()
                self.title = response.result.recipeType
                
            case .failure(let error):
                print("레시피 상세 조회 실패: \(error)")
            }
        }
    }
}

// MARK: - UICollectionView

extension RecipeDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == recipeDetailView.mainIngredientCollectionView {
            print(mainIngredients.count)
            return mainIngredients.count
        } else if collectionView == recipeDetailView.subIngredientCollectionView {
            return subIngredients.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == recipeDetailView.mainIngredientCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeDetailIngredientsCollectionViewCell.identifier, for: indexPath) as! RecipeDetailIngredientsCollectionViewCell
            cell.configure(tag: mainIngredients[indexPath.item])
            return cell
        } else if collectionView == recipeDetailView.subIngredientCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeDetailIngredientsCollectionViewCell.identifier, for: indexPath) as! RecipeDetailIngredientsCollectionViewCell
            cell.configure(tag: subIngredients[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
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






