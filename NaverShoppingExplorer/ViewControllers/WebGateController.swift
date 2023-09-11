//
//  WebGateController.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/09.
//

import UIKit


final class WebGateController: UIViewController {
    
    let mainView = WebGateView()
    private var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    private var modalStartPosition: CGFloat = 0
    
    override func loadView() {
        self.view = mainView
        
        let height = UIScreen.main.bounds.height * 0.7
        preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: height)
        
        self.view.layer.cornerRadius = 10
        self.view.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        modalStartPosition = view.frame.origin.y
    }
    
    @objc func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        let touchPoint = gestureRecognizer.location(in: self.view.window)
        
        switch gestureRecognizer.state {
        case .began:
            initialTouchPoint = touchPoint
            
        case .changed:
            let yOffset = touchPoint.y - initialTouchPoint.y
            view.frame.origin.y = max(modalStartPosition + yOffset, modalStartPosition)
            
        case .ended, .cancelled:
            let velocity = gestureRecognizer.velocity(in: view)
            
            if velocity.y >= 150 {

                UIView.animate(withDuration: 0.1) {
                    self.view.frame.origin.y = self.view.frame.size.height
                } completion: { _ in
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                UIView.animate(withDuration: 0.1) {
                    self.view.frame.origin.y = self.modalStartPosition
                }
            }
        default:
            break
        }
    }
    
}



