//
//  Shopping.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/07.
//

import Foundation

struct Shopping: Codable {
    let lastBuildDate: String
    let total, start, display: Int
    var items: [ShoppingResult]
}

struct ShoppingResult: Codable {
    let title: String
    let link: String
    let image: String
    let lprice, hprice, mallName, productID: String
    let productType: String
    let brand: String?
    let maker: String?
    let category1, category2, category3, category4: String?

    enum CodingKeys: String, CodingKey {
        case title, link, image, lprice, hprice, mallName
        case productID = "productId"
        case productType, brand, maker, category1, category2, category3, category4
    }
}
