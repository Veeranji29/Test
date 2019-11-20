//
//  ListViewModel.swift
//  TestApp
//
//  Created by Veera Diande on 20/11/19.
//  Copyright © 2019 Brandenburg. All rights reserved.
//

import UIKit
import Foundation
import UIKit
import SDWebImage
enum ListViewModelItemType {
    case names
}
protocol ListViewModelItem {
    var type: ListViewModelItemType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
}
class ListViewModel: NSObject {
    var items = [ListViewModelItem]()
    private let refreshControl = UIRefreshControl()

    override init() {
        super.init()
        self.fetchingData()
    }
    func fetchingData() {
        guard let data = dataFromFile("ServerData"), let list = Lists(data: data) else {
            return
        }
        let lists = list.list
        if !lists.isEmpty {
            let friendsItem = ListViewModeFriendsItem(lists: lists)
            items.append(friendsItem)
        }
    }
    @objc private func refreshData(_ sender: Any) {
        fetchData()
    }
    private func fetchData() {
        self.fetchingData()
        self.refreshControl.endRefreshing()
    }
}
extension ListViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Data ...")
        let item = items[indexPath.section]
        switch item.type {
        case .names:
            if let item = item as? ListViewModeFriendsItem, let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell {
                let list = item.lists[indexPath.row]
                cell.lblTitle?.text = list.title
                cell.lblDesc?.text = list.desc
                cell.pictureImageView?.sd_setImage(with: URL(string: list.url ?? ""), placeholderImage: UIImage(named: "avatar"))
                return cell
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].sectionTitle
    }
}
class ListViewModeFriendsItem: ListViewModelItem {
    var type: ListViewModelItemType {
        return .names
    }
    var sectionTitle: String {
        return "About Canada"
    }
    var rowCount: Int {
        return lists.count
    }
    var lists: [List]
    init(lists: [List]) {
        self.lists = lists
    }
}

