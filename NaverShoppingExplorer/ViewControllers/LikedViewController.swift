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
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        mainView.searchController.hidesNavigationBarDuringPresentation = false
        mainView.searchController.searchResultsUpdater = self
        self.definesPresentationContext = true
        self.navigationItem.searchController = mainView.searchController
        connectRealm()
    }
    
    private func connectRealm() {
        tasks = repository.fetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        
    }
    
}
