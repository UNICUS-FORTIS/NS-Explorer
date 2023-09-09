//
//  UserData.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/09.
//

import UIKit
import RealmSwift


class Product: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId

    @Persisted var isLiked: Bool?
    @Persisted var productId: String
    @Persisted var mallName: String
    @Persisted var productPrice: String
    @Persisted var productName: String
    @Persisted var productLink: String
    @Persisted var productImage: String
    @Persisted var createDate: Date
    
    convenience init(isLiked: Bool,
                     productId: String,
                     mallName: String,
                     productPrice: String,
                     productName: String,
                     productLink: String,
                     productImage: String,
                     createDate: Date) {
        self.init()

        self.isLiked = isLiked
        self.productId = productId
        self.mallName = mallName
        self.productPrice = productPrice
        self.productName = productName
        self.productLink = productLink
        self.productImage = productImage
        self.createDate = createDate
    }
    
    
}
