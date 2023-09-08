//
//  SearchResultView.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/08.
//

import UIKit
import SnapKit

final class SearchResultView: UIView {
    
    lazy var collectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        cv.register(SearchResultCVCell.self,
                    forCellWithReuseIdentifier: SearchResultCVCell.identifier)
        cv.register(SearchResultReusableView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: SearchResultReusableView.identifier)
        return cv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.addSubview(collectionView)
        
    }
    
    private func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        lazy var layout = UICollectionView.setCollectionCustomLayout(numberOfAxis: 2,
                                                                     numberOfcrossAxis: 3,
                                                                     spacing: 10,
                                                                     scrollDirection: .vertical)
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        layout.headerReferenceSize = CGSize(width: width, height: height * 0.03 )
        return layout
    }
    
    

    
    
    
}
