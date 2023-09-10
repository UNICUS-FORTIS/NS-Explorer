//
//  UITextField+Extension.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/11.
//

import UIKit

extension UITextField {
    
    func defineSeacrhField() {
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: frame.height))
        self.leftView = padding
        self.leftViewMode = .always
        self.placeholder = "검색어를 입력해주세요."
        self.tintColor = Constant.Color.naverGreen()
        self.layer.cornerRadius = 8
        self.layer.borderColor = Constant.Color.naverGreen().cgColor
        self.layer.borderWidth = 1
        self.textColor = .darkGray
        self.clearButtonMode = .whileEditing
        self.autocapitalizationType = .none
        self.keyboardType = .asciiCapable
    }
}
