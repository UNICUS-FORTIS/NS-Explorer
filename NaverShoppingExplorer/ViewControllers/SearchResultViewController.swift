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
    private var page = 1
    private var sortParameter: Int?
    
    var keyword: String? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.title = "\(self?.keyword ?? "")"
            }
        }
    }
    
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
        mainView.collectionView.prefetchDataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
        repository.checkRealmDirectory()
        repository.checkSchemaVersion()
        mainView.collectionView.reloadData()
    }
    
    private func connectRealm() {
        tasks = repository.fetch()
    }
    
    private func getSortString(senderTag: Int) -> String {
        switch senderTag {
        case 0 : return Parameter.Sort.accuracy
        case 1 : return Parameter.Sort.date
        case 2 : return Parameter.Sort.descending
        case 3 : return Parameter.Sort.ascending
        default:
            return Parameter.Sort.date
        }
    }
}

extension SearchResultViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vcGate = WebGateController()
        let vcWeb = WebViewController()
        vcGate.mainView.dismissTrigger = { [weak self] in
            self?.dismiss(animated: true)
        }
        vcGate.mainView.pushTrigger = { [weak self] in
            self?.navigationController?.pushViewController(vcWeb, animated: true)
        }
        
        if let items = result?.items {
            let path = items[indexPath.item]
            vcGate.mainView.data = path
            vcGate.modalPresentationStyle = .custom
            vcGate.transitioningDelegate = self
            
            vcWeb.productLink = "https://msearch.shopping.naver.com/product/\(path.productID)"
            let matchedProduct = tasks.first(where: { $0.productId == path.productID })
            vcWeb.isLiked = matchedProduct != nil ? true : false
        }
        present(vcGate, animated: true)
    }
}


extension SearchResultViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCVCell.identifier, for: indexPath) as? SearchResultCVCell else  { return UICollectionViewCell() }
        
        if let items = self.result?.items {
            cell.data = items[indexPath.item]
            let productID = items[indexPath.item].productID
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
        sortParameter = sender.tag
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

extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let result = self.result else { return }
        for indexPath in indexPaths {
            if result.items.count-1 == indexPath.item && page < 10 {
                page += 1
                guard let keyword = keyword else { return }
                let sort = getSortString(senderTag: sortParameter ?? 1)
                
                networkmanager.requestData(query: keyword, start: page, sort: sort) { data in
                    switch data {
                    case .success(let result):
                        self.result?.items.append(contentsOf: result.items)
                        
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
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("===취소: \(indexPaths)")
    }
}

extension SearchResultViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = CustomPresentationController(presentedViewController: presented, presenting: presenting)
        return presentationController
    }
}
