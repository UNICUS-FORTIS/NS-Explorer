//
//  WebGateView.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/09.
//

import UIKit
import SnapKit


final class WebGateView:UIVisualEffectView {
    
    private let repository = ProductTableRepository.shared
    var dismissTrigger: (() -> Void)?
    var pushTrigger:(() -> Void)?
    
    var data: ShoppingResult? {
        didSet {
            guard let data = data else { return }
            let url = URL(string: data.image)
            productImage.kf.setImage(with: url)
            mallLabel.text = "[\(data.mallName)]"
            productNameLabel.text = data.title.cleanString()
            priceLabel.text = priceLabel.makingCurrency(price: data.lprice)
        }
    }
    
    var storedData: Product? {
        didSet {
            guard let storedData = storedData else { return }
            let loadedImg = repository.loadImageFromDocument(filename: "stored\(storedData._id).jpg")
            productImage.image = loadedImg
            mallLabel.text = "[\(storedData.mallName)]"
            productNameLabel.text = storedData.productName
            priceLabel.text = priceLabel.makingCurrency(price: storedData.productPrice)
        }
    }
    
    
    private let barItemView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        view.backgroundColor = .darkGray
        return view
    }()
    
    private let productImage:UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        view.backgroundColor = Constant.Color.naverGreen()
        return view
    }()
    
    private var mallLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    private var productNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .red
        label.numberOfLines = 0
        return label
    }()
    
    lazy var labelStackView:UIStackView = {
        let sv = UIStackView(arrangedSubviews: [mallLabel, productNameLabel, priceLabel])
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .leading
        sv.spacing = 2
        return sv
        
    }()
    
    private let toWebButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("웹에서 보기", for: .normal)
        btn.backgroundColor = Constant.Color.naverGreen()
        btn.layer.cornerRadius = 6
        btn.clipsToBounds = true
        return btn
    }()

    override init(effect: UIVisualEffect?) {
        let blurEffect = UIBlurEffect(style: .regular)
        super.init(effect: blurEffect)
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        contentView.addSubview(barItemView)
        contentView.addSubview(productImage)
        contentView.addSubview(labelStackView)
        contentView.addSubview(toWebButton)
        toWebButton.addTarget(self, action: #selector(transferToWeb), for: .touchUpInside)
    }
    
    @objc func transferToWeb() {
        if let data = self.data {
        }
        if let storedData = self.storedData {
        }
        dismissTrigger?()
        pushTrigger?()
    }
    
    private func setConstraints() {
        
        barItemView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(8)
            make.height.equalTo(5)
            make.width.equalTo(contentView).multipliedBy(0.4)
            make.centerX.equalTo(contentView)
        }
        
        productImage.snp.makeConstraints { make in
            make.top.equalTo(barItemView).offset(60)
            make.height.equalTo(contentView).multipliedBy(0.4)
            make.width.equalTo(contentView).multipliedBy(0.6)
            make.centerX.equalTo(contentView)
        }
        
        mallLabel.snp.makeConstraints { make in
            make.height.equalTo(mallLabel.font.lineHeight)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.height.equalTo(priceLabel.font.lineHeight)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(4)
            make.centerX.equalTo(contentView)
            make.width.equalTo(productImage)
        }
        
        toWebButton.snp.makeConstraints { make in
            make.top.equalTo(labelStackView.snp.bottom).offset(60)
            make.width.equalTo(contentView).multipliedBy(0.5)
            make.bottom.equalTo(contentView).offset(-90)
            make.centerX.equalTo(contentView)
        }
    }
}
