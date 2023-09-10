//
//  ColorPreset.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/07.
//

import UIKit

enum Constant {
    
    enum Image {
        static let likedIcon = UIImage(named: "red.heart.circle.fill")
        static let noneLikedIcon = UIImage(named: "gray.heart.circle.fill")
        static let likeNaviIcon = UIImage(systemName: "heart.fill")
        static let searchIcon = UIImage(systemName: "magnifyingglass")
    }
    
    enum Color {
        static func naverGreen() -> UIColor {
            let naverGreen = UIColor(red: 0.01, green: 0.81, blue: 0.36, alpha: 1.00)
            return naverGreen
        }
        
    }
    
}
