//
//  String+Extension.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/08.
//

import Foundation

extension String {
    
    func cleanString() -> String {
        var cleanedString = self

        cleanedString = cleanedString.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)

        let specialCharacters = [
            "&amp;": "&",
            "&lt;": "<",
            "&gt;": ">",
            "&quot;": "\"",
            "&apos;": "'",
            "&#39;": "'",
            "&#x2019;": "’"
        ]

        for (entity, character) in specialCharacters {
            cleanedString = cleanedString.replacingOccurrences(of: entity, with: character)
        }

        return cleanedString
    }
}
