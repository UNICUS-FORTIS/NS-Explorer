//
//  UINavigation+Extension.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/10.
//

import UIKit

extension UINavigationController {
    
    func setupNaviAppearance() {
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .regular)
        if #available(iOS 15.0, *) {
            appearance.shadowColor = .clear
        } else {
            navigationBar.shadowImage = UIImage()
        }
        navigationBar.tintColor = .darkGray // ok
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.isTranslucent = true
        navigationBar.topItem?.backButtonTitle = "" // ok
    }
}

