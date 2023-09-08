//
//  UserDataTableRepository.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/09.
//

import Foundation
import RealmSwift

class UserDataTableRepository {
    
    let realm = try! Realm()
    
    func fetch() -> Results<UserData> {
        let data = realm.objects(UserData.self).sorted(byKeyPath: "regDate", ascending: false)
        return data
    }
    
    func fetchFilter() -> Results<UserData> {
        let result = realm.objects(UserData.self).where {
            $0.isLiked == true
        }
        return result
    }
    
    func createItem(_ item: UserData) {
        
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
    func updateItem(id: ObjectId, title:String, contents: String) {
        
        do {
            try realm.write {
                realm.create(UserData.self,
                             value: ["_id": id,
                                     "title": title,
                                     "contents": contents],
                             update: .modified)
            }
        } catch {
            print("")
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
    
}
