//
//  BaseView.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/07.
//

import UIKit
import SnapKit
import Kingfisher



class BaseView: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        self.backgroundColor = .white
    }
    
    
    func setConstraints() { }
    
}
