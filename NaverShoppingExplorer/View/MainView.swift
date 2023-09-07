//
//  MainView.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/07.
//

import UIKit
import TextFieldEffects


class MainView: BaseView {
    
    lazy var searchField: UITextField = {
        let tf = HoshiTextField(frame: .zero)
        tf.placeholder = "검색어를 입력해주세요."
        tf.placeholderColor = .darkGray
        tf.layer.cornerRadius = 8
        tf.layer.borderColor = Constant.naverGreen().cgColor
        tf.layer.borderWidth = 1
        tf.textColor = .black
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        self.addSubview(searchField)
    }
    
    override func setConstraints() {
        searchField.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(150)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(self).multipliedBy(0.07)
        }
    }
    
    
    
}
