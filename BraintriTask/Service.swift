//
//  Service.swift
//  BraintriTask
//
//  Created by Filip on 05/05/2019.
//  Copyright © 2019 Filip. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD
import SwiftyJSON

protocol UserExist {
    func exist(value: Bool)
    func userRepo(data: [UserRepos])
}

class Service {
    var delegate : UserExist?
    
    func loadRepos(_ url: URL) {
        SVProgressHUD.show(withStatus: "In Progress")
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            if response.result.value != nil {
                let responseJSON: JSON = JSON(response.result.value!)
                self.savingJson(responseJSON)
                SVProgressHUD.dismiss()
            } else {
                SVProgressHUD.dismiss()
            }
        }
    }
    
    private func savingJson(_ json: JSON) {
        var userRepoArrayForDelegation = [UserRepos]()
        json.array?.forEach({ (json) in
            let repo = UserRepos(userName: json["owner"]["login"].stringValue, repoName: json["name"].stringValue, language: json["language"].stringValue, avatarUrl: json["owner"]["avatar_url"].stringValue, createdDate: json["created_at"].stringValue)
            userRepoArrayForDelegation.append(repo)
        })
        delegate?.exist(value: true)
        delegate?.userRepo(data: userRepoArrayForDelegation)
    }
}
