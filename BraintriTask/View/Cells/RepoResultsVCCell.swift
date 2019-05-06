//
//  RepoResultsVCCell.swift
//  BraintriTask
//
//  Created by Filip on 06/05/2019.
//  Copyright © 2019 Filip. All rights reserved.
//

import UIKit
import Kingfisher

class RepoResultsVCCell: UITableViewCell {
    
    let repoNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
    let languageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()
    
    let avatarUrlView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = ContentMode.scaleAspectFit
        return imageView
    }()
    
    var reposViewModel: UserRepos! {
        didSet {
            repoNameLabel.text = reposViewModel.repoName.capitalized
            languageLabel.text = "Language: " + reposViewModel.language
            avatarUrlView.kf.setImage(with: URL(string: reposViewModel.avatarUrl))
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        avatarUrlView.translatesAutoresizingMaskIntoConstraints = false
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        repoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(avatarUrlView)
        addSubview(languageLabel)
        addSubview(repoNameLabel)
        
        NSLayoutConstraint.activate([
            repoNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 60),
            repoNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 10),
            repoNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            
            languageLabel.topAnchor.constraint(equalTo: repoNameLabel.bottomAnchor, constant: 5),
            languageLabel.leftAnchor.constraint(equalTo: repoNameLabel.leftAnchor, constant: 0),
            
            avatarUrlView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            avatarUrlView.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -5),
            avatarUrlView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            avatarUrlView.widthAnchor.constraint(equalToConstant: 40),
            avatarUrlView.heightAnchor.constraint(equalToConstant: 40)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
