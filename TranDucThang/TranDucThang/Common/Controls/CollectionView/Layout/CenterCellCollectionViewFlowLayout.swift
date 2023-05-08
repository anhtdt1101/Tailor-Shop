//
//  CenterCellCollectionViewFlowLayout.swift
//  F5SmartAccount
//
//  Created by Anh Nguyen on 12/5/19.
//  Copyright © 2019 Anh Nguyen. All rights reserved.
//

import UIKit

class CenterCellCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func targetContentOffset(forProposedContentOffset offset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let cvBounds = collectionView!.bounds
        let halfWidth = cvBounds.size.width * 0.5

        let attributesArray = layoutAttributesForElements(in: cvBounds)
        if velocity.x == 0 {
            let proposedContentOffsetCenterX = offset.x + halfWidth
            var candidateAttributes: UICollectionViewLayoutAttributes?
            for attributes in attributesArray ?? [] {
                if attributes.representedElementCategory != .cell {
                    continue
                }
                if candidateAttributes == nil {
                    candidateAttributes = attributes
                    continue
                }
                if abs(Float(attributes.center.x - proposedContentOffsetCenterX)) < abs(Float((candidateAttributes?.center.x ?? 0.0) - proposedContentOffsetCenterX)) {
                    candidateAttributes = attributes
                }
            }
            return CGPoint(x: (candidateAttributes?.center.x ?? 0.0) - halfWidth, y: offset.y)
        } else {
            var candidateAttributes: UICollectionViewLayoutAttributes?
            for attributes in attributesArray ?? [] {
                if attributes.representedElementCategory != .cell {
                    continue
                }
                if (attributes.center.x == 0) || (attributes.center.x > (collectionView!.contentOffset.x + halfWidth) && velocity.x < 0) {
                    continue
                }
                candidateAttributes = attributes
            }
            if candidateAttributes == nil {
                return super.targetContentOffset(forProposedContentOffset: offset)
            }
            return CGPoint(x: floor((candidateAttributes?.center.x ?? 0.0) - halfWidth), y: offset.y)
        }
    }
}
