//
//  ViewController.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/07.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let mainView = MainView()
    private let networkManager = NetworkManager.shared
    private let networkMonitor = NetworkMonitor.shared
    private var resultArray:Shopping?
    private var isConnected = false {
        didSet {
            print(isConnected)
            checkNetworkStatus()
        }
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        mainView.searchField.delegate = self
        mainView.searchField.text = "티니핑"
        navigationController?.setupNaviAppearance()
        tabBarController?.setupTabbarController()
        networkMonitor.networkStatusUpdater = { [weak self] isConnected in
            self?.isConnected = isConnected
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.hidesBarsOnSwipe = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        mainView.searchField.resignFirstResponder()
    }
    
    private func checkNetworkStatus() {
        let target = mainView.networkStatusLabel
        var statusText = ""
        var statusColor = UIColor.clear
        var statusBackgroundColor = UIColor.clear

        if self.isConnected {
            statusText = "네트워크에 연결되었습니다."
            statusColor = .white
            statusBackgroundColor = Constant.Color.naverGreen()
            
        } else {
            statusText = "네트워크 연결을 확인해주세요."
            statusColor = .red
            statusBackgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
        }

        DispatchQueue.main.async {
            UIView.transition(with: target, duration: 0.5, options: .transitionCrossDissolve, animations: {
                target.text = statusText
                target.textColor = statusColor
                target.backgroundColor = statusBackgroundColor
                target.isHidden = self.isConnected
            })
        }
    }
    
    deinit {
        print(#function)
        networkMonitor.stopMonitoring()
    }
}

extension MainViewController:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mainView.searchField.resignFirstResponder()
        let vc = SearchResultViewController()


        guard let text = mainView.searchField.text, !text.isEmpty else { return false }

        networkManager.requestData(query: text,
                                   start: 1,
                                   sort: Parameter.Sort.date) { result in
            switch result {
            case .success(let result):
                vc.result = result
                vc.keyword = text
            case .failure(let error):
                switch error {
                case .dataError:
                    print("데이터 에러")
                case .networkingError:
                    print("네트워킹 에러")
                case .parseError:
                    print("파싱에러")
                }
            }
        }

        navigationController?.pushViewController(vc, animated: false)
        
        return true
    }
}

