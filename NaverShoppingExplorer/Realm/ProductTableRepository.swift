//
//  ProductTableRepository.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/09.
//

import UIKit
import RealmSwift

final class ProductTableRepository {
    
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
    
    func fetchLikedFilter(_ data: Product) -> Results<Product> {
        let result = realm.objects(Product.self).where {
            $0.productId == data.productId
        }
        return result
    }
    
    func storedFilter(_ data: String) -> Results<Product> {
        let result = realm.objects(Product.self).where( {
            $0.productName.contains(data)
        })
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
                    productLink: String,
                    productImage: String,
                    createDate: Date) {
        do {
            try realm.write {
                realm.create(Product.self,
                             value: ["_id": id,
                                     "isLiked": isLiked,
                                     "productId": productId,
                                     "productName": productName,
                                     "productLink": productLink,
                                     "productImage": productImage,
                                     "createDate": createDate
                                    ] as [String : Any],
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
    
    // MARK: - 도큐먼트 폴더에 이미지를 저장하는 메서드 생성
    func saveImageToDocument(filename: String, image: UIImage) {
        guard let documentDirectory =
                FileManager.default.urls(for: .documentDirectory,
                                         in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent(filename)
        
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        do {
            
            try data.write(to: fileURL)
            
        } catch let error {
            
            print("file save error", error)
            
        }
    }
    
    // MARK: - 존재하는 파일 도큐먼트에서 로드
    func loadImageFromDocument(filename:String) -> UIImage {
        guard let documentDirectory =
                FileManager.default.urls(for: .documentDirectory,
                                         in: .userDomainMask).first else { return UIImage() }
        // 경로 명세
        let fileURL = documentDirectory.appendingPathComponent(filename)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)!
        } else {
            return UIImage()
        }
    }
    
    // MARK: - 파일 제거
    func removeImageFromDocument(filename: String) {
        
        guard let documentDirectory =
                FileManager.default.urls(for: .documentDirectory,
                                         in: .userDomainMask).first else { return }
        // 경로 명세
        let fileURL = documentDirectory.appendingPathComponent(filename)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        }
        catch {
            print(error)
        }
    }
    
    // MARK: - Returns Directory Path.
    func documentDirectoryPath() -> URL? {
        guard let documentDirectory =
                FileManager.default.urls(for: .documentDirectory,
                                         in: .userDomainMask).first else { return nil }
        return documentDirectory
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
