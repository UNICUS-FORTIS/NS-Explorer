//
//  URL+Extension.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/07.
//

import Foundation

extension URL {
    
    static func naverURL(query:String, sort: Parameter.Sort ) -> URL? {
        let url = EndPoint.basURL+"query=\(query)&display=30&start=1&sort=\(sort)"
        return URL(string: url)
    }
}
