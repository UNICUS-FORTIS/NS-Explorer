//
//  WebViewController.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/10.
//
import UIKit
import WebKit


class WebViewController: UIViewController, WKUIDelegate {
    
    
    let webConfiguration = WKWebViewConfiguration()
    lazy var webView = WKWebView(frame: .zero, configuration: webConfiguration)
    var productLink: String?
    
    var isLiked: Bool? {
        didSet {
            if let isLiked = isLiked {
                let icon = Constant.Image.likeNaviIcon
                let rightBarbutton = UIBarButtonItem(image: icon,
                                                     style: .plain,
                                                     target: self,
                                                     action: nil)
                let iconColor = isLiked ? UIColor.red : UIColor.gray
                rightBarbutton.tintColor = iconColor
                navigationItem.rightBarButtonItem = rightBarbutton
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setConstraints()
        navigationController?.setupWebViewNaviAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        guard let productLink = productLink else { return }
        startWebView(link: productLink)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopLoading()
    }
    
    private func startWebView(link: String) {
        guard let myURL = URL(string: link) else { return }
        let myRequest = URLRequest(url: myURL)
        webView.load(myRequest)
        
    }
    
    private func configure() {
        navigationController?.hidesBarsOnSwipe = false
        
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
