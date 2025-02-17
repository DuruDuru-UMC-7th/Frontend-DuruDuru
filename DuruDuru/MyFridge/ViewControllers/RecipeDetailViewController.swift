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
    var recipeDetail: RecipeDetail?
    
    var mainIngredients = [String]()
    var subIngredients = [String]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeDetailView = RecipeDetailView(frame: self.view.bounds)
        self.view = recipeDetailView
        self.title = "레시피 상세"

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
        
        setupDelegate()
        fetchRecipeDetail()
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
                
                DispatchQueue.main.async {
                    self.updateUI()
                }
                
            case .failure(let error):
                print("레시피 상세 조회 실패: \(error)")
            }
        }
    }

    private func updateUI() {
        guard let detail = recipeDetail else { return }
        
        if let imageURL = URL(string: detail.imageUrl) {
            recipeDetailView.titleImageView.kf.setImage(with: imageURL)
        } else {
            recipeDetailView.titleImageView.image = UIImage(named: "placeholder")
        }
        
        recipeDetailView.recipeName.text = detail.recipeName
        recipeDetailView.likeCountLabel.text = "\(detail.favoriteCount)"
        
        recipeDetailView.instructionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for (index, step) in detail.manualSteps.enumerated() {
            let stepLabel = createInstructionLabel(text: step, index: index + 1)
            recipeDetailView.instructionsStackView.addArrangedSubview(stepLabel)
        }
        
        recipeDetailView.mainIngredientCollectionView.reloadData()
        recipeDetailView.subIngredientCollectionView.reloadData()
    }
    
    // 조리법 라벨 생성
    private func createInstructionLabel(text: String, index: Int) -> UIView {
        let containerView = UIView()
        let indexLabel = UILabel()
        let contentLabel = UILabel()

        indexLabel.text = "\(index)."
        indexLabel.font = .boldSystemFont(ofSize: 16)
        indexLabel.textColor = .black

        contentLabel.text = text
        contentLabel.font = .systemFont(ofSize: 14)
        contentLabel.numberOfLines = 0

        containerView.addSubview(indexLabel)
        containerView.addSubview(contentLabel)

        indexLabel.snp.makeConstraints { $0.leading.top.equalToSuperview().offset(10) }
        contentLabel.snp.makeConstraints {
            $0.leading.equalTo(indexLabel.snp.trailing).offset(8)
            $0.trailing.top.bottom.equalToSuperview().inset(10)
        }

        return containerView
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
            cell.tagLabel.text = mainIngredients[indexPath.item]
            return cell
        } else if collectionView == recipeDetailView.subIngredientCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeDetailIngredientsCollectionViewCell.identifier, for: indexPath) as! RecipeDetailIngredientsCollectionViewCell
            cell.tagLabel.text = subIngredients[indexPath.item]
            return cell
        }
        return UICollectionViewCell()
    }
}

