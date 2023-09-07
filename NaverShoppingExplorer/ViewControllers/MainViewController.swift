//
//  ViewController.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/07.
//

import UIKit

class MainViewController: BaseViewController {

    let mainView = MainView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.searchField.delegate = self
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        mainView.searchField.resignFirstResponder()
    }
    


}

extension MainViewController:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = mainView.searchField.text else { return false }
        
        print(text)
        
        return true
    }
    
    
}

