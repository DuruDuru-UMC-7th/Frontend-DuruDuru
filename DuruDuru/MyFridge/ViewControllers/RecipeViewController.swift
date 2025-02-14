//
//  RecipeViewController.swift
//  DuruDuru
//
//  Created by 임효진 on 1/12/25.
//

import UIKit
import Kingfisher

class RecipeViewController: UIViewController {
    
    // MARK: - Properties
    private var recipeView: RecipeView!
    var ingredientName: String?  // 전달 받은 재료 이름
    var recipes = [RecipeModel]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeView = RecipeView(frame: self.view.bounds)
        self.view = recipeView
        
        // 뒤로 가기 버튼 설정
        let backImage = UIImage(systemName: "chevron.left")
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
        backButton.tintColor = .black
        
        self.title = (ingredientName ?? "없음") + "을 사용하는 레시피"
        setupDelegate()
        setupOptionViewActions()
        
        // 키보드 동작을 위한 제스처 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Functions
    private func setupDelegate(){
        recipeView.recipeTableView.dataSource = self
        recipeView.recipeTableView.delegate = self
        recipeView.searchBar.delegate = self
    }
    
    /// 옵션뷰 관련 액션 설정
    private func setupOptionViewActions() {
        // 옵션뷰를 표시하기 위해 orderFilterButton에 액션 추가
        recipeView.orderFilterButton.addTarget(self, action: #selector(showOptionsView), for: .touchUpInside)
        
        // 옵션뷰 내 닫기 버튼 액션 추가
        recipeView.menuCloseButton.addTarget(self, action: #selector(hideOptionsView), for: .touchUpInside)
        
        // 필터 버튼 액션 추가 ("찜 많은 순", "최신 등록순")
        recipeView.moreFilter.addTarget(self, action: #selector(didSelectMoreFilter), for: .touchUpInside)
        recipeView.recentFilter.addTarget(self, action: #selector(didSelectRecentFilter), for: .touchUpInside)
        
        // 어두운 배경을 탭하면 옵션뷰가 숨겨지도록 제스처 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideOptionsView))
        recipeView.darkBackgroundView.addGestureRecognizer(tapGesture)
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// 키보드 숨기기
    @objc private func dismissKeyboard() {
        if recipeView.searchBar.isFirstResponder {
            recipeView.searchBar.resignFirstResponder()
        }
    }
    
    // MARK: - 옵션뷰 표시/숨김 및 필터 업데이트
    
    /// 옵션뷰를 표시합니다.
    @objc private func showOptionsView() {
        recipeView.optionsView.isHidden = false
        recipeView.darkBackgroundView.isHidden = false
    }
    
    /// 옵션뷰를 숨깁니다.
    @objc private func hideOptionsView() {
        recipeView.optionsView.isHidden = true
        recipeView.darkBackgroundView.isHidden = true
    }
    
    /// 선택된 필터 버튼의 스타일을 업데이트하고, 드롭다운 버튼의 타이틀을 변경한 후 옵션뷰를 숨깁니다.
    private func updateSelectedOrder(_ selectedButton: UIButton) {
        // 모든 필터 버튼의 타이틀 색상을 기본값으로 설정 (여기서는 "찜 많은 순"과 "최신 등록순")
        recipeView.moreFilter.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
        recipeView.recentFilter.setTitleColor(UIColor(hex: 0x37383C, alpha: 0.61), for: .normal)
        
        // 선택된 버튼의 타이틀을 검정색, 볼드체로 설정
        selectedButton.setTitleColor(.black, for: .normal)
        selectedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        // 드롭다운 버튼(순서 필터 버튼)의 타이틀 업데이트
        recipeView.orderFilterButton.configuration?.attributedTitle = AttributedString(selectedButton.title(for: .normal) ?? "", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 12)]))
        
        // 옵션뷰 숨김 처리
        recipeView.optionsView.isHidden = true
        recipeView.darkBackgroundView.isHidden = true
    }
    
    /// "찜 많은 순" 필터 선택 시 호출
    @objc private func didSelectMoreFilter() {
        print("찜 많은 순 선택")
        updateSelectedOrder(recipeView.moreFilter)
        // 추가 작업이 필요하면 여기에 구현
    }
    
    /// "최신 등록순" 필터 선택 시 호출
    @objc private func didSelectRecentFilter() {
        print("최신 등록순 선택")
        updateSelectedOrder(recipeView.recentFilter)
        // 추가 작업이 필요하면 여기에 구현
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension RecipeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.identifier, for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(recipe: recipes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeDetailVC = RecipeDetailViewController()
        // recipeDetailVC.recipe = recipes[indexPath.row] // 필요한 경우 데이터 전달
        navigationController?.pushViewController(recipeDetailVC, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension RecipeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        recipeView.searchBar.resignFirstResponder()
        // 검색 동작 구현 (예: API 호출 등)
    }
}
