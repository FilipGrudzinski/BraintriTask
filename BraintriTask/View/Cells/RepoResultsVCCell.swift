//
//  RepoResultsVCCell.swift
//  BraintriTask
//
//  Created by Filip on 06/05/2019.
//  Copyright © 2019 Filip. All rights reserved.
//

import UIKit

class RepoResultsVCCell: UITableViewCell {
    
    var reposViewModel: UserRepos! {
        didSet {
            textLabel?.text = reposViewModel.repoName
            detailTextLabel?.text = reposViewModel.language
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        detailTextLabel?.textColor = .black
        detailTextLabel?.font = UIFont.systemFont(ofSize: 20, weight: .light)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
