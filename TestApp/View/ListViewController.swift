//
//  ListTableViewController.swift
//  TestApp
//
//  Created by Veera Diande on 20/11/19.
//  Copyright © 2019 Brandenburg. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView?
    fileprivate let viewModel = ListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = viewModel
        tableView?.estimatedRowHeight = 100
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.register(ListTableViewCell.nib, forCellReuseIdentifier: ListTableViewCell.identifier)
    }
}
