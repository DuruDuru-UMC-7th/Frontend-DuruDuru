//
//  MyFridgeViewController.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/8/25.
//

import UIKit

class MyFridgeViewController: UIViewController {
    
    // MARK: - Properties
    
    private var myFridgeView: MyFridgeView!
    private var ingredientVC: IngredientsViewController!
    private var cookingVC: MyCookingViewController!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// MyFridgeView 초기화 및 추가
        myFridgeView = MyFridgeView(frame: self.view.bounds)
        self.view.addSubview(myFridgeView)
        ingredientVC = IngredientsViewController()
        cookingVC = MyCookingViewController()
        cookingVC.delegate = self
        add(asChildViewController: ingredientVC)
        
        setupAction()
    }
    
    // MARK: - Function
    
    private func setupAction() {
        /// segmentedControl의 valueChanged 이벤트에 대한 타겟 및 액션 설정
        myFridgeView.segmentedControl.addTarget(
            self,
            action: #selector(segmentChanged(segment:)),
            for: .valueChanged
        )
    }
    
    @objc
    private func segmentChanged(segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            switchToChildViewController(ingredientVC)
        } else {
            switchToChildViewController(cookingVC)
        }
        
        /// 세그먼트의 너비 계산
        let segmentWidth = myFridgeView.segmentedControl.frame.width / CGFloat(myFridgeView.segmentedControl.numberOfSegments)
        let selectedSegmentIndex = CGFloat(segment.selectedSegmentIndex)
        
        /// 언더라인 애니메이션
        UIView.animate(withDuration: 0.3) {
            /// 언더라인의 제약 조건 업데이트
            self.myFridgeView.underline.snp.updateConstraints {
                $0.left.equalTo(self.myFridgeView.segmentedControl.snp.left).offset(segmentWidth * selectedSegmentIndex)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    /// 자식 뷰 컨트롤러 바꾸기
    private func switchToChildViewController(_ child: UIViewController) {
        /// 현재 자식 뷰 컨트롤러 제거
        for childVC in children {
                childVC.willMove(toParent: nil)
                childVC.view.removeFromSuperview()
                childVC.removeFromParent()
            }
        /// 새 자식 뷰 컨트롤러 추가
        add(asChildViewController: child)
    }
    
    /// 자식 뷰 컨트롤러 추가
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        viewController.view.frame = myFridgeView.containerView.bounds
        myFridgeView.containerView.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    
}

extension MyFridgeViewController: MyCookingViewControllerDelegate{
    func didTapRecipeViewButton() {
            let recipeViewController = RecipeViewController()
            navigationController?.pushViewController(recipeViewController, animated: true)
        }
}
