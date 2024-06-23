//
//  ListingView.swift
//  ViperListing
//
//  Created by TheJunirD3v on 10/06/24.
//

import Foundation
import UIKit

protocol ListingViewProtocol: AnyObject {
    func showItems(_ items: [Item])
    func showError(_ message: String)
}

class ListingViewController: UIViewController, ListingViewProtocol {
    var presenter: ListingPresenterProtocol!
    var tableView =  UITableView() {
        didSet {
            tableView.frame = self.view.bounds
            tableView.accessibilityValue = "ListingTableView"
        }
    }

    private var items: [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadItems()
        tableView.register(TitleTableViewCell.nib, forCellReuseIdentifier: TitleTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        self.tableView.frame = self.view.bounds
        self.tableView.reloadData()
    }

    func showItems(_ items: [Item]) {
        self.items = items
        // Update UI with the items
        tableView.reloadData()
    }

    func showError(_ message: String) {
        // Show error message to the user
    }
}

extension ListingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell {
            let item = items[indexPath.row]
            let titleVm = TitleTableViewCellVM(title: item.name, id: String(describing: item.id))
            cell.showData(viewModel: titleVm)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}
