//
//  SearchFilterButton.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/08.
//

import UIKit
import SnapKit

class SearchResultReusableView: UICollectionReusableView {
    
    private let filterTitle:[String] = ["정확도순", "등록일자순", "가격높은순", "가격낮은순" ]
    lazy var buttonArray:[UIButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
        setupButtonLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtons() {
        for (idx, title) in filterTitle.enumerated() {
            let btn = UIButton(type: .system)
            btn.tag = idx
            btn.setTitle(title, for: .normal)
            btn.titleLabel?.font = .systemFont(ofSize: 13)
            btn.tintColor = Constant.Color.naverGreen()
            btn.layer.borderColor = Constant.Color.naverGreen().cgColor
            btn.layer.borderWidth = 1
            btn.layer.cornerRadius = 8
            btn.clipsToBounds = true
            btn.titleLabel?.textAlignment = .center
            btn.backgroundColor = .clear
            self.addSubview(btn)
            buttonArray.append(btn)
        }
    }
    
    private func setupButtonLayout() {
        for (idx, btn) in buttonArray.enumerated() {
            btn.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.leading.equalTo(idx == 0 ? self.snp.leading : buttonArray[idx-1].snp.trailing).offset(idx == 0 ? 8 : 8)
                make.width.equalTo(btn.titleLabel!.snp.width).offset(16)
            }
        }
    }
}
