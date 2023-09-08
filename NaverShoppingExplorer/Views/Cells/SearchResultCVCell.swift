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
    
    var data: ShoppingResult? {
        didSet {
            guard let imgData = data?.image else { return }
            let url = URL(string: imgData)
            productImage.kf.setImage(with: url)
            guard let mallname = data?.mallName else { return }
            mallLabel.text = "[\(mallname)]"
            productNameLabel.text = data?.title.cleanString()
            guard let price = data?.lprice else { return }
            priceLabel.text = priceLabel.makingCurrency(price: price)
            guard let productId = data?.productID else { return }
            likeButton.tag = Int(productId) ?? 0
            isLiked = false
        }
    }
    
    private var isLiked: Bool = false {
        didSet {
            if isLiked {
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
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private var productNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
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
            self.isLiked.toggle()
        }
    }
    
    
    private func configure() {
        lazy var componentsArray:[UIView] = [productImage, likeButton, labelStackView]
        componentsArray.forEach { contentView.addSubview($0) }
    }
    
    private func setConstraints() {
        productImage.snp.makeConstraints { make in
            make.top.equalTo(contentView)
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