//
//  ViewController.swift
//  BraintriTask
//
//  Created by Filip on 05/05/2019.
//  Copyright © 2019 Filip. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    private let baseUrl = "https://api.github.com/users/(user)/repos"
    private var userRepos = [UserRepos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func searchButton(_ sender: Any) {
        if let text = searchTextField.text, !text.isEmpty {
            if let url = URL(string: baseUrl.replacingOccurrences(of: "(user)", with: text)) {
                let request = Service()
                request.loadRepos(url)
                request.delegate = self
                print(url)
            }
        } else {
            print("pusto")
        }
    }
}

//MARK: - Extension for Delegate Functions
extension SearchVC: UserExist {
    func userRepo(data: [UserRepos]) {
        userReposArray = data
        print(userReposArray)
    }
    
    func exist(value: Bool) {
        if value == true {
            performSegue(withIdentifier: "goToResultsVC", sender: self)
        } else {
            print("No Data")
        }
    }
}
