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
    private var resultArray:Shopping?
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.hidesBarsOnSwipe = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        mainView.searchField.resignFirstResponder()
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

