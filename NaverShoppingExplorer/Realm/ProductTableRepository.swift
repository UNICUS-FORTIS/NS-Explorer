//
//  ProductTableRepository.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/09.
//

import Foundation
import RealmSwift

class ProductTableRepository {
    
    static let shared = ProductTableRepository()
    
    let realm = try! Realm()
    
    func fetch() -> Results<Product> {
        let data = realm.objects(Product.self).sorted(byKeyPath: "createDate", ascending: false)
        return data
    }
    
    func fetchFilter(_ data: ShoppingResult) -> Results<Product> {
        let result = realm.objects(Product.self).where {
            $0.productId == data.productID
        }
        return result
    }
    
    func createItem(_ item: Product) {
        
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
    func updateItem(id: ObjectId,
                    isLiked:String,
                    productId:String,
                    productName: String,
                    createDate: Date) {
        
        do {
            try realm.write {
                realm.create(Product.self,
                             value: ["_id": id,
                                     "isLiked": isLiked,
                                     "productId": productId,
                                     "productName": productName,
                                     "createDate": createDate
                                    ],
                             update: .modified)
            }
        } catch {
            print("")
        }
    }
    
    func removeItem(item: Results<Product>) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
    
    func checkSchemaVersion() {
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print(version)
        } catch {
            print(error)
        }
    }
    
    func checkRealmDirectory() {
        print(realm.configuration.fileURL!)
    }
}
