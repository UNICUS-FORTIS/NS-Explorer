//
//  MainView.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/07.
//

import UIKit
import SnapKit
import TextFieldEffects


final class MainView: UIView {
    
    lazy var searchField: UITextField = {
        let tf = UITextField()
        tf.defineSeacrhField()
        return tf
    }()
    
    let networkStatusLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.textAlignment = .center
        label.textColor = .red
        return label
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
        self.addSubview(searchField)
        self.addSubview(networkStatusLabel)
    }
    
    private func setConstraints() {
        searchField.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(150)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(self).multipliedBy(0.07)
        }
        
        networkStatusLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.width.equalTo(searchField).multipliedBy(0.8)
            make.height.equalTo(self).multipliedBy(0.04)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-30)
        }
    }
}
