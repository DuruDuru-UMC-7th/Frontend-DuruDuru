//
//  MyFridgeViewController.swift
//  DuruDuru
//
//  Created by 이은찬 on 1/8/25.
//

import UIKit

class MyFridgeViewController: UIViewController {
    
    private var myFridgeView: MyFridgeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /// MyFridgeView 초기화 및 추가
        myFridgeView = MyFridgeView(frame: self.view.bounds)
        self.view.addSubview(myFridgeView)
        setupAction()
    }
    
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
            myFridgeView.ingredientsView.isHidden = false /// 식재료 목록 뷰 보이기
            myFridgeView.myCookingView.isHidden = true /// 나만의 요리 뷰 숨기기
        } else {
            myFridgeView.ingredientsView.isHidden = true  /// 식재료 목록 뷰 숨기기
            myFridgeView.myCookingView.isHidden = false  /// 나만의 요리 뷰 보이기
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
}
