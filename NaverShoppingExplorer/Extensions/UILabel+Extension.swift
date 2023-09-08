//
//  UIView+Extension.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/08.
//

import UIKit

extension UILabel {
    
    func makingCurrency(price: String) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "ko_KR")
        numberFormatter.currencySymbol = ""
        if let price = Int(price), let formattedPrice = numberFormatter.string(from: NSNumber(value: price)) {
            return formattedPrice + "원"
        }
        return ""
    }
}
