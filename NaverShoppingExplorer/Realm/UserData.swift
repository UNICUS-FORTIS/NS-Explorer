//
//  UserData.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/09.
//

import Foundation
import RealmSwift


class UserData: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId

    @Persisted var isLiked: Bool
    @Persisted var productId: Int
    @Persisted var productLink: String
    @Persisted var productImage: String
    
    convenience init(isLiked: Bool, productId: Int) {
        self.init()

        self.isLiked = isLiked
        self.productId = productId
    }
    
    
}
