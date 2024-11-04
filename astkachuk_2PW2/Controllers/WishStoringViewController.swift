//
//  WishStoringViewController.swift
//  astkachuk_2PW2
//
//  Created by Artem Tkachuk on 04.11.2024.
//

import UIKit

final class WishStoringViewController: UIViewController {
    // MARK: - Fields
    private let backgroundColor: UIColor = UIColor(hexString: "#caced8") ?? .white
    
    private var wishArray: [String] = ["I wish to add cells to the table", "LOL"]
    
    // MARK: - Properties
    private let tableView = TableView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    // MARK: - Configure TableView
    private func configureTableView() {
        view.backgroundColor = backgroundColor
        view.addSubview(tableView)
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.pin(to: view, TableView.Constants.tableOffset)
        
        tableView.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return wishArray.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: WrittenWishCell.reuseId,
            for: indexPath
        )
        
        guard let wishCell = cell as? WrittenWishCell else { return cell }
        
        wishCell.configure(with: wishArray[indexPath.row])
        
        return wishCell
    }
}
