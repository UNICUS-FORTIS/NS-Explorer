//
//  SearchResultViewController.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/08.
//

import UIKit
import RealmSwift


final class SearchResultViewController: UIViewController {
    
    
    private let networkmanager = NetworkManager.shared
    private let mainView = SearchResultView()
    private let repository = ProductTableRepository.shared
    private var tasks: Results<Product>!
    
    var keyword: String?
    
    var result: Shopping? {
        didSet {
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectRealm()
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        repository.checkRealmDirectory()
        repository.checkSchemaVersion()
        mainView.collectionView.reloadData()
    }
    
    private func connectRealm() {
        tasks = repository.fetch()
    }
}


extension SearchResultViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


extension SearchResultViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCVCell.identifier, for: indexPath) as? SearchResultCVCell else  { return UICollectionViewCell() }
        
        cell.data = self.result?.items[indexPath.item]
        if let productID = result?.items[indexPath.item].productID {
            if let matchedProduct = tasks.first(where: { $0.productId == productID }) {
                cell.isLiked = matchedProduct.isLiked ?? false
            } else {
                cell.isLiked = false
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchResultReusableView.identifier, for: indexPath) as? SearchResultReusableView else { return UICollectionReusableView() }
            
            view.buttonArray.forEach{ $0.addTarget(self,
                                                   action: #selector(filterButtonActionInHeader),
                                                   for: .touchUpInside)}
            return view
            
        } else {
            return UICollectionReusableView()
        }
    }
    
    @objc func filterButtonActionInHeader(_ sender: UIButton) {
        switch sender.tag {
        case 0 : networkAction(sort: Parameter.Sort.accuracy)
        case 1 : networkAction(sort: Parameter.Sort.date)
        case 2 : networkAction(sort: Parameter.Sort.descending)
        case 3 : networkAction(sort: Parameter.Sort.ascending)
        default:
            networkAction(sort: Parameter.Sort.accuracy)
        }
    }
    
    private func networkAction(sort: String) {
        guard let word = self.keyword else { return }
        networkmanager.requestData(query: word, start: 1, sort: sort) { result in
            switch result {
            case .success(let result):
                self.result = nil
                self.result = result
            case .failure(let error):
                switch error {
                case .dataError:
                    print("데이터 에러")
                case .networkingError:
                    print("네트워킹 에러")
                case .parseError:
                    print("파싱에러")
                }
            }
        }
    }
    
}

