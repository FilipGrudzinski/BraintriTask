//
//  ResultsVC.swift
//  BraintriTask
//
//  Created by Filip on 05/05/2019.
//  Copyright © 2019 Filip. All rights reserved.
//

import UIKit

class ResultsVC: UITableViewController {
    let cellId = "Cell"
    var dataForCell = [UserRepos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        title = dataForCell[0].userName.capitalized
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RepoResultsVCCell
        cell.reposViewModel = dataForCell[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataForCell.count
    }
    
    private func setupTableView() {
        tableView.register(RepoResultsVCCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.tableFooterView = UIView()
    }
}
