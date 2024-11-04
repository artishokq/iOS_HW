//
//  WishStoringViewController.swift
//  astkachuk_2PW2
//
//  Created by Artem Tkachuk on 04.11.2024.
//

import UIKit

final class WishStoringViewController: UIViewController {
    // MARK: - Properties
    private let tableView = TableView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        configureTableView()
    }
    
    // MARK: - Configure TableView
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.pin(to: view, TableView.Constants.tableOffset)
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
