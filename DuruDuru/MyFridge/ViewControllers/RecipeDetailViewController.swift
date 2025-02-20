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
    var isLiked: Bool = false
    
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
        
        recipeDetailView.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Function
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func imageButtonTapped() {
        print("내보내기 버튼 눌림")
    }
    
    @objc func likeButtonTapped() {
        if isLiked {
            recipeDetailView.likeButton.tintColor = .lightGray
            isLiked = false
            likeRecipe(recipeName: self.recipeName)
            recipeDetailView.updateLikeCount(data: -1)
        } else {
            recipeDetailView.likeButton.tintColor = UIColor(hex: 0x00C269, alpha: 1.0)
            isLiked = true
            likeRecipe(recipeName: self.recipeName)
            recipeDetailView.updateLikeCount(data: 1)
        }
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
                
                // 레시피 정보를 UI에 적용
                self.recipeDetailView.configure(recipe: self.recipeDetail)
                
                // ingredientList를 절반으로 나누기
                let ingredients = self.recipeDetail.ingredientList
                let midIndex = ingredients.count / 2
                
                self.mainIngredients = Array(ingredients.prefix(midIndex)) // 첫 절반
                self.subIngredients = Array(ingredients.suffix(from: midIndex)) // 나머지 절반
                
                // UICollectionView 업데이트
                self.recipeDetailView.mainIngredientCollectionView.reloadData()
                self.recipeDetailView.subIngredientCollectionView.reloadData()
                self.recipeDetailView.updateCollectionViewHeight()
                self.title = self.recipeDetail.recipeType
                
                // 즐겨찾기 상태 설정
                self.isLiked = self.recipeDetail.favorite
                self.recipeDetailView.likeButton.tintColor = self.isLiked ? UIColor(hex: 0x00C269, alpha: 1.0) : .lightGray
                
            case .failure(let error):
                print("레시피 상세 조회 실패: \(error)")
            }
        }
    }
    
    // 레시피 찜하기
    private func likeRecipe(recipeName: String) {
        let url = "http://3.35.252.162:8080/recipes/{recipeName}/favorite"
        
        // 쿼리 파라미터
        let queryParameters: [String: Any] = [
            "recipeName": recipeName
        ]
        let queryString = APIClient.shared.createQueryString(from: queryParameters)
        let urlWithQuery = "\(url)?\(queryString)"
        
        APIClient.shared.request(urlWithQuery, method: .post) { (result: Result<LikeRecipeResponse, Error>) in
            switch result {
            case .success(let response):
                print("레시피 좋아요 성공")
            case .failure(let error):
                print("네트워킹 오류: \(error)")
            }
        }
    }
}

// MARK: - UICollectionView

extension RecipeDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == recipeDetailView.mainIngredientCollectionView {
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






