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

// MARK: - Item
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
//
//enum Brand: String, Codable {
//    case brandCATCH = "CATCH"
//    case empty = ""
//    case 유유 = "유유"
//    case 캐치티니핑 = "캐치티니핑"
//}
//
//enum Category1: String, Codable {
//    case 생활건강 = "생활/건강"
//    case 식품 = "식품"
//    case 출산육아 = "출산/육아"
//}
//
//enum Maker: String, Codable {
//    case empty = ""
//    case 모나리자 = "모나리자"
//    case 유유 = "유유"
//}
