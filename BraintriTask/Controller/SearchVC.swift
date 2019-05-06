//
//  ViewController.swift
//  BraintriTask
//
//  Created by Filip on 05/05/2019.
//  Copyright © 2019 Filip. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, UITextFieldDelegate {
    private let baseUrl = "https://api.github.com/users/(user)/repos"
    private let request = Service()
    private var searchTextField: UITextField!
    private var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        request.delegate = self
    }
    
    private func setupView() {
        navigationItem.title = "Braintri Task"
        view.backgroundColor = .white
        
        searchTextField = UITextField(frame: CGRect(x: 10, y: 80, width: UIScreen.main.bounds.width - 20, height: 30))
        searchTextField.placeholder = "Enter user name for search"
        searchTextField.font = UIFont.systemFont(ofSize: 15)
        searchTextField.clearButtonMode = .always
        searchTextField.borderStyle = UITextField.BorderStyle.roundedRect
        searchTextField.autocorrectionType = UITextAutocorrectionType.no
        searchTextField.keyboardType = UIKeyboardType.default
        searchTextField.returnKeyType = UIReturnKeyType.done
        searchTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        searchTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        searchTextField.delegate = self
        
        searchButton = UIButton(type: .system)
        searchButton.frame.size = CGSize(width: 100, height: 50)
        searchButton.center.x = self.view.center.x
        searchButton.center.y = 130
        searchButton.setTitle("Search", for: UIControl.State.normal)
        searchButton.addTarget(self, action: #selector(searchButtonAction), for: .touchUpInside)
        
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
    }
    
    @objc func searchButtonAction(_ sender: Any) {
        if let text = searchTextField.text, !text.isEmpty {
            if let url = URL(string: baseUrl.replacingOccurrences(of: "(user)", with: text)) {
                request.loadRepos(url)
            }
        } else {
            request.successPopUp("Enter user name for search!")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

//MARK: - Extension for Delegate Functions
extension SearchVC: UserExist {
    func userRepo(data: [UserRepos]) {
        let newViewController = ResultsVC()
        newViewController.dataForCell = data
        navigationController?.pushViewController(newViewController, animated: true)
    }
}
