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
}


extension SearchResultViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vcGate = WebGateController() // 모달창
        let vcWeb = WebViewController() // 인터넷창
        //        let path = self.result?.items[indexPath.item]
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

extension SearchResultViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = CustomPresentationController(presentedViewController: presented, presenting: presenting)
        return presentationController
    }
}
