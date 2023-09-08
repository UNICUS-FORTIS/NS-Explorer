//
//  UICollectionView+Extension.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/08.
//

import UIKit

extension UICollectionView {
    static func setCollectionCustomLayout(numberOfAxis: CGFloat,
                                          numberOfcrossAxis: CGFloat,
                                          spacing: CGFloat,
                                          scrollDirection: UICollectionView.ScrollDirection)
    -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        let itemWidth = (screenWidth - (spacing*(numberOfAxis+1))) / numberOfAxis
        let itemHeight = (screenHeight - (spacing*(numberOfAxis+1))) / numberOfcrossAxis
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        layout.sectionInset = UIEdgeInsets(top: spacing,
                                           left: spacing,
                                           bottom: spacing,
                                           right: spacing)
        
        if scrollDirection == .vertical {
            
            layout.minimumLineSpacing = spacing / 2
            layout.minimumInteritemSpacing = 0
            
        } else {
            
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = spacing / 2
        }
        
        layout.scrollDirection = scrollDirection
        
        return layout
    }
}
