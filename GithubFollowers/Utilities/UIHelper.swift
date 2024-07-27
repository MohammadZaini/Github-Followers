//
//  UIHelper.swift
//  GithubFollowers
//
//  Created by Moe on 28/07/2024.
//

import UIKit

class UIHelper {
    
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        
        let screenWidth = view.bounds.width
        let padding: CGFloat = 12
        let minimumLineSpacing: CGFloat = 10
        let availableWidth = screenWidth - (padding * 2) - (minimumLineSpacing * 2)
        let itemWidth = availableWidth / 3
        
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth , height: itemWidth + 40)
        
    
        return flowLayout
    }
}
