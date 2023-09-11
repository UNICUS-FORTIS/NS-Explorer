//
//  WebViewController.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/10.
//
import UIKit
import WebKit
import RealmSwift
import Kingfisher


class WebViewController: UIViewController, WKUIDelegate {
    
    lazy var webView = WKWebView(frame: .zero, configuration: webConfiguration)
    private let webConfiguration = WKWebViewConfiguration()
    private var tasks: Results<Product>!
    private let repository = ProductTableRepository.shared
    
    
    var data: ShoppingResult? {
        didSet {
            guard let data = data else { return }
            DispatchQueue.global().async { [weak self] in
                let url = URL(string: data.image)
                DispatchQueue.main.async {
                    self?.productImage.kf.setImage(with: url)
                }
            }
            let link = "https://msearch.shopping.naver.com/product/\(data.productID)"
            startWebView(link: link)
        }
    }
    
    var storedData: Product? {
        didSet {
            connectRealm()
            guard let storedData = storedData else { return }
            let loadedImg = repository.loadImageFromDocument(filename: "stored\(storedData._id).jpg")
            productImage.image = loadedImg
            isLiked = storedData.isLiked
            let link = "https://msearch.shopping.naver.com/product/\(storedData.productId)"
            startWebView(link: link)
            makeBackup()
        }
    }
    
    var isLiked: Bool? {
        didSet {
            setupRightBarButton()
        }
    }
    
    var backupData: Product?
    
    private let productImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
        setConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        backupData = nil
    }
    
    private func makeBackup() {
        guard let storedData = storedData else { return }
        let backup = tasks.first(where: { $0._id == storedData._id })
        guard let backup = backup else { return }
        let newdata = Product(isLiked: backup.isLiked ?? false,
                              productId: backup.productId,
                              mallName: backup.mallName,
                              productPrice: backup.productPrice,
                              productName: backup.productName,
                              productLink: backup.productLink,
                              productImage: backup.productImage,
                              createDate: Date())
        self.backupData = newdata
    }
    
    private func setupRightBarButton() {
        guard let isLiked = self.isLiked else { return }
        let icon = Constant.Image.likeNaviIcon
        let rightBarbutton = UIBarButtonItem(image: icon,
                                             style: .plain,
                                             target: self ,
                                             action: #selector(rightBarButtonTapped))
        let iconColor = isLiked ? UIColor.red : UIColor.gray
        rightBarbutton.tintColor = iconColor
        navigationItem.rightBarButtonItem = rightBarbutton
    }
    
    private func connectRealm() {
        tasks = repository.fetch()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopLoading()
    }
    
    
    @objc func rightBarButtonTapped() {
        if let data = self.data {
            self.isLiked?.toggle()
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
            
            if self.isLiked == true {
                let removeTarget = repository.fetchLikedFilter(stored)
                repository.removeImageFromDocument(filename: "stored\(removeTarget[0]._id).jpg")
                repository.removeItem(item: removeTarget)
                
                self.storedData = backupData
                self.isLiked = false
                
            } else if self.isLiked == false {
                self.isLiked = true
                let creatTarget = Product(isLiked: self.isLiked ?? false,
                                          productId: stored.productId,
                                          mallName: stored.mallName,
                                          productPrice: stored.productPrice,
                                          productName: stored.productName,
                                          productLink: stored.productLink,
                                          productImage: stored.productImage,
                                          createDate: Date())
                
                DispatchQueue.global().async { [weak self] in
                    
                    guard let url = URL(string: stored.productImage) else { return }
                    if let data = try? Data(contentsOf: url) {
                        let productImage = UIImage(data: data)
                        
                        DispatchQueue.main.async {
                            self?.productImage.image = productImage
                            if let productImage = productImage {
                                self?.repository.saveImageToDocument(filename: "stored\(creatTarget._id).jpg", image: productImage)
                            }
                            self?.repository.createItem(creatTarget)
                        }
                    }
                }
            }
        }
    }
    
    private func startWebView(link: String) {
        guard let myURL = URL(string: link) else { return }
        let myRequest = URLRequest(url: myURL)
        webView.load(myRequest)
    }
    
    private func configure() {
        view.addSubview(webView)
    }
    
    private func setConstraints() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func stopLoading() {
        webView.stopLoading()
    }
    
    
    func reloadButtonClicked() {
        webView.reload()
    }
    
    func goBackButtonClicked() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    func goForwardButtonClicked() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
}
