//
//  LikedView.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/09.
//

import UIKit

final class LikedView: UIView {
    
    let searchController = UISearchController()
    
    lazy var collectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        cv.register(SearchResultCVCell.self,
                    forCellWithReuseIdentifier: SearchResultCVCell.identifier)
        return cv
    }()
    
    private let toTopOfViewButton:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "arrow.up.circle.fill"), for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSearchController()
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.addSubview(collectionView)
        self.addSubview(toTopOfViewButton)
        toTopOfViewButton.addTarget(self,
                                    action: #selector(toTopOfViewButtonTapped),
                                    for: .touchUpInside)
    }
    
    @objc func toTopOfViewButtonTapped() {
        let indexPath = IndexPath(item: 0, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
    }
    
    private func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        toTopOfViewButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.size.equalTo(40)
        }
    }
    
    private func setupSearchController() {
        searchController.searchBar.autocapitalizationType = .none
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        lazy var layout = UICollectionView.setCollectionCustomLayout(numberOfAxis: 2,
                                                                     numberOfcrossAxis: 3,
                                                                     spacing: 10,
                                                                     scrollDirection: .vertical)
        return layout
    }
    
}
