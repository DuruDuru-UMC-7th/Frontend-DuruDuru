//
//  LeftAlignedCollectionViewFlowLayout.swift
//  DuruDuru
//
//  Created by 임효진 on 1/21/25.
//

import Foundation
import UIKit
// from : https://stackoverflow.com/questions/22539979/left-align-cells-in-uicollectionview
class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            layoutAttribute.frame.origin.x = leftMargin

            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }
        // 아래 줄을 추가안하시면 네모네모(?)하고 이상한 Cell을 목격할수있습니다.
        self.estimatedItemSize = UICollectionViewFlowLayout.automaticSize // 해당 줄만 추가했습니다.
        return attributes
    }
}
