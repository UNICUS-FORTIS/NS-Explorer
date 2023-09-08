//
//  UserData.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/09.
//

import Foundation
import RealmSwift


class Product: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId

    @Persisted var isLiked: Bool?
    @Persisted var productId: String
    @Persisted var productName: String
    @Persisted var createDate: Date
    
    convenience init(isLiked: Bool, productId: String, productName: String, createDate: Date) {
        self.init()

        self.isLiked = isLiked
        self.productId = productId
        self.productName = productName
        self.createDate = createDate
    }
    
    
}
