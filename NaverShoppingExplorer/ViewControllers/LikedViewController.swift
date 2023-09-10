//
//  LikedViewController.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/09.
//

import UIKit
import RealmSwift

final class LikedViewController: UIViewController {
    
    
    private let mainView = LikedView()
    private let repository = ProductTableRepository.shared
    private var tasks: Results<Product>! {
        didSet {
            mainView.collectionView.reloadData()
        }
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
        connectRealm()
        navigationController?.setupNaviAppearance()
        tabBarController?.setupTabbarController()
    }
    
    private func configure() {
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        mainView.searchController.hidesNavigationBarDuringPresentation = false
        mainView.searchController.searchResultsUpdater = self
        mainView.searchController.searchBar.placeholder = "검색어를 입력하세요"
        definesPresentationContext = true
        navigationItem.searchController = mainView.searchController
    }
    
    private func connectRealm() {
        tasks = repository.fetch()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.collectionView.reloadData()
    }
    
}

extension LikedViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        let target = repository.storedFilter(text)
        tasks = target
        if searchController.searchBar.text == "" {
            connectRealm()
        }
    }
}

extension LikedViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count == 0 ? 0 : tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCVCell.identifier, for: indexPath) as? SearchResultCVCell else { return UICollectionViewCell() }
        
        cell.storedData = tasks[indexPath.item]
        cell.isLiked = tasks[indexPath.item].isLiked
        cell.reloadTrigger = { [weak self] in
            self?.mainView.collectionView.reloadData()
        }
        
        return cell
    }
}

extension LikedViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let path = tasks[indexPath.item]
        let vc = WebGateController()
        
        vc.mainView.storedData = path
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        vc.mainView.dismissTrigger = { [weak self] in
            self?.dismiss(animated: true)
        }
        let pushTargetVC = WebViewController()
        pushTargetVC.productLink = "https://msearch.shopping.naver.com/product/\(path.productId)"
        pushTargetVC.isLiked = path.isLiked
        vc.mainView.pushTrigger = { [weak self] in
            self?.navigationController?.pushViewController(pushTargetVC, animated: true)
        }
        present(vc, animated: true)
    }
}

extension LikedViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = CustomPresentationController(presentedViewController: presented, presenting: presenting)
        return presentationController
    }
}
