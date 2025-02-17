//
//  MyFridgeViewController.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/8/25.
//

import UIKit
import SnapKit

// 외부에서 세그먼트 선택 시 사용할 열거형
enum FridgeSegment {
    case ingredients    // 식재료 목록 (IngredientsViewController)
    case cooking        // 나만의 요리 (MyCookingViewController)
}

class MyFridgeViewController: UIViewController {
    
    // MARK: - Properties
    
    private var myFridgeView: MyFridgeView!
    private var ingredientVC: IngredientsViewController!
    private var cookingVC: MyCookingViewController!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MyFridgeView 초기화 및 루트 뷰로 설정
        myFridgeView = MyFridgeView(frame: self.view.bounds)
        self.view = myFridgeView
        
        setupAction()
        
        ingredientVC = IngredientsViewController()
        cookingVC = MyCookingViewController()
        
        // 초기에는 "식재료 목록"을 자식으로 추가
        add(asChildViewController: ingredientVC)
    }
    
    // MARK: - Setup Action
    
    private func setupAction() {
        // segmentedControl의 valueChanged 이벤트에 대한 타겟 및 액션 설정
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
        
        // 세그먼트의 너비 계산
        let segmentWidth = myFridgeView.segmentedControl.frame.width / CGFloat(myFridgeView.segmentedControl.numberOfSegments)
        let selectedSegmentIndex = CGFloat(segment.selectedSegmentIndex)
        
        // 언더라인 애니메이션 처리
        UIView.animate(withDuration: 0.3) {
            self.myFridgeView.underline.snp.updateConstraints {
                $0.left.equalTo(self.myFridgeView.segmentedControl.snp.left).offset(segmentWidth * selectedSegmentIndex)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - 자식 뷰 컨트롤러 전환
    
    /// 현재 자식 뷰 컨트롤러를 제거하고 새 자식 뷰 컨트롤러를 추가하는 함수
    private func switchToChildViewController(_ child: UIViewController) {
        // 기존 자식 뷰 컨트롤러 제거
        for childVC in children {
            childVC.willMove(toParent: nil)
            childVC.view.removeFromSuperview()
            childVC.removeFromParent()
        }
        // 새 자식 뷰 컨트롤러 추가
        add(asChildViewController: child)
    }
    
    /// 자식 뷰 컨트롤러를 containerView에 추가하는 함수
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        myFridgeView.containerView.addSubview(viewController.view)
        
        // Auto Layout 제약 조건 설정
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: myFridgeView.containerView.topAnchor),
            viewController.view.leadingAnchor.constraint(equalTo: myFridgeView.containerView.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: myFridgeView.containerView.trailingAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: myFridgeView.containerView.bottomAnchor)
        ])
        
        viewController.didMove(toParent: self)
    }
    
    // MARK: - 외부 호출용 세그먼트 전환 메서드
    
    /// 외부에서 세그먼트를 전환할 수 있도록 하는 메서드
    /// 예: selectSegment(.ingredients) 또는 selectSegment(.cooking)
    func selectSegment(_ segment: FridgeSegment) {
        // 뷰가 아직 로드되지 않았다면 강제로 로드
        loadViewIfNeeded()
        
        switch segment {
        case .ingredients:
            myFridgeView.segmentedControl.selectedSegmentIndex = 0
        case .cooking:
            myFridgeView.segmentedControl.selectedSegmentIndex = 1
        }
        // 세그먼트 변경 이벤트를 직접 호출하여 화면 전환 실행
        segmentChanged(segment: myFridgeView.segmentedControl)
    }
}
