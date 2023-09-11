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
            tabBarAppearance.configureWithTransparentBackground()
            tabBarAppearance.backgroundEffect = UIBlurEffect(style: .regular)
            tabBar.standardAppearance = tabBarAppearance
            tabBar.scrollEdgeAppearance = tabBarAppearance
            tabBar.isTranslucent = true
            
        } else {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithTransparentBackground()
            tabBarAppearance.backgroundEffect = UIBlurEffect(style: .regular)
            tabBar.standardAppearance = tabBarAppearance
            tabBar.isTranslucent = true
        }
    }
}
