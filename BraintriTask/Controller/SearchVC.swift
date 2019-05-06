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
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter user name for search"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.clearButtonMode = .always
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textField
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        button.addTarget(self, action: #selector(searchButtonAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        request.delegate = self
        searchTextField.delegate = self
        
    }
    
    private func setupView() {
        title = "Braintri Task"
        view.backgroundColor = .white
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            searchTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            searchTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            searchTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            
            searchButton.widthAnchor.constraint(equalToConstant: 100),
            searchButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10),
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
            ])
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
