//
//  Service.swift
//  BraintriTask
//
//  Created by Filip on 05/05/2019.
//  Copyright © 2019 Filip. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

protocol UserExist {
    func userRepo(data: [UserRepos])
}

class Service: UIViewController {
    var delegate: UserExist?
    
    func loadRepos(_ url: URL) {
        SVProgressHUD.show(withStatus: "In Progress")
        Alamofire.request(url, method: .get).validate(statusCode: 200..<300).responseJSON { response in
            if let json = response.result.value {
                let responseJSON: JSON = JSON(json)
                self.savingJson(responseJSON)
                SVProgressHUD.dismiss()
            } else {
                self.successPopUp("No user repo found")
                SVProgressHUD.dismiss()
            }
        }
    }
    
    private func savingJson(_ json: JSON) {
        var userRepoArrayForDelegation = [UserRepos]()
        json.array?.forEach({ (json) in
            let repo = UserRepos(userName: json["owner"]["login"].stringValue, repoName: json["name"].stringValue, language: json["language"].stringValue, avatarUrl: json["owner"]["avatar_url"].stringValue)
            userRepoArrayForDelegation.append(repo)
        })
        delegate?.userRepo(data: userRepoArrayForDelegation)
    }
    
    func successPopUp(_ message: String) {
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel) {(UIAlertAction) in self.dismissPopUp()}
        
        alert.addAction(okAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    private func dismissPopUp() {
        dismiss(animated: true, completion: nil)
    }
}
