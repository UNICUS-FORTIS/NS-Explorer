//
//  UITabbarController+Extension.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/10.
//

import UIKit

extension UITabBarController {
    
    func setupTabbarController() {
        if #available(iOS 15.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundEffect = UIBlurEffect(style: .regular)
            
            tabBar.standardAppearance = tabBarAppearance
            tabBar.scrollEdgeAppearance = tabBarAppearance
        } else {
            tabBar.isTranslucent = true
            tabBar.barTintColor = .white
        }
    }
    
    func setupWebViewTabbarController() {
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
    }

}
