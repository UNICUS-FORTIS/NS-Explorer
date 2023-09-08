//
//  URL+Extension.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/07.
//

import Foundation

extension URL {
    
    static func naverURL(query: String, start: Int, sort: String ) -> URL? {
        let url = EndPoint.basURL + "query=\(query)&display=30&start=\(start)&sort=\(sort)"
        print(url)
        return URL(string: url)
    }
}
