//
//  PresentationController.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/09.
//

import UIKit

class CustomPresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        
        let yOffset = containerView.bounds.height * 0.3
        let height = containerView.bounds.height * 0.7
        
        return CGRect(x: 0, y: yOffset, width: containerView.bounds.width, height: height)
    }
}
