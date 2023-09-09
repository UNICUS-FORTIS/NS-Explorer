//
//  SearchResultCVCell.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/08.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchResultCVCell: UICollectionViewCell {
    
    private let repository = ProductTableRepository.shared
    var reloadTrigger: (() -> Void)?
    
    
    var data: ShoppingResult? {
        didSet {
            guard let data = data else { return }
            let url = URL(string: data.image)
            productImage.kf.setImage(with: url)
            mallLabel.text = "[\(data.mallName)]"
            productNameLabel.text = data.title.cleanString()
            priceLabel.text = priceLabel.makingCurrency(price: data.lprice)
            likeButton.tag = Int(data.productID) ?? 0
        }
    }
    
    var storedData: Product? {
        didSet {
            guard let storedData = storedData else { return }
            let loadedImg = repository.loadImageFromDocument(filename: "stored\(storedData._id).jpg")
            productImage.image = loadedImg
            mallLabel.text = storedData.mallName
            productNameLabel.text = storedData.productName
            priceLabel.text = priceLabel.makingCurrency(price: storedData.productPrice)
            likeButton.tag = Int(storedData.productId) ?? 0
        }
    }
    
    var isLiked: Bool? {
        didSet {
            if isLiked ?? false {
                likeButton.setImage(Constant.Image.likedIcon, for: .normal)
            } else {
                likeButton.setImage(Constant.Image.noneLikedIcon, for: .normal)
            }
        }
    }
    
    private let productImage:UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    let likeButton: UIButton = {
        let btn = UIButton()
        let btnImage = UIImage(named: "gray.heart.circle.fill")
        btn.contentMode = .scaleAspectFit
        btn.setImage(btnImage, for: .normal)
        return btn
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
        sv.alignment = .top
        sv.spacing = 2
        return sv
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImage.image = nil
        likeButton.tag = 0
    }
    
    @objc func likeButtonTapped(sender: UIButton)  {
        let convertedProductId = Int(data?.productID ?? "")
        if convertedProductId == sender.tag {
            self.isLiked?.toggle()
        }
        
        let convertedLikedProductId = Int(storedData?.productId ?? "")
        if convertedLikedProductId == sender.tag {
            self.isLiked?.toggle()
        }
        
        if let data = self.data {
            let creatTarget = Product(isLiked: self.isLiked ?? false,
                                      productId: data.productID,
                                      mallName: data.mallName,
                                      productPrice: data.lprice,
                                      productName: data.title.cleanString(),
                                      productLink: data.link,
                                      productImage: data.image,
                                      createDate: Date())
            
            let removeTarget = repository.fetchFilter(self.data!)
            
            if self.isLiked == false {
                repository.removeImageFromDocument(filename: "stored\(removeTarget[0]._id).jpg")
                repository.removeItem(item: removeTarget)
            } else if self.isLiked == true {
                if productImage.image != nil {
                    repository.saveImageToDocument(filename: "stored\(creatTarget._id).jpg",
                                                   image: productImage.image!)
                }
                repository.createItem(creatTarget)
            }
        }
        
        if let stored = storedData {
            let removeTarget = repository.fetchLikedFilter(stored)
            
            if self.isLiked == false {
                repository.removeImageFromDocument(filename: "stored\(removeTarget[0]._id).jpg")
                repository.removeItem(item: removeTarget)
                reloadTrigger?()
            }
        }
    }
    
    
    private func configure() {
        lazy var componentsArray:[UIView] = [productImage, likeButton, labelStackView]
        componentsArray.forEach { contentView.addSubview($0) }
    }
    
    private func setConstraints() {
        productImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(4)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(contentView).multipliedBy(0.7)
        }
        
        mallLabel.snp.makeConstraints { make in
            make.height.equalTo(mallLabel.font.lineHeight)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.height.equalTo(priceLabel.font.lineHeight)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom)
            make.horizontalEdges.equalTo(contentView)
        }
        
        likeButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(productImage).offset(-6)
            make.size.equalTo(productImage).multipliedBy(0.2)
        }
    }
    
    
}
