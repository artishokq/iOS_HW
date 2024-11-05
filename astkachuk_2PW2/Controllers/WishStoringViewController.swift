//
//  WishStoringViewController.swift
//  astkachuk_2PW2
//
//  Created by Artem Tkachuk on 04.11.2024.
//

import UIKit

final class WishStoringViewController: UIViewController {
    private var wishArray: [String] = ["I wish to add cells to the table"]
    
    // MARK: - Constants
    private enum Constants {
        static let numberOfSections = 2
        static let backgroundColor: UIColor = UIColor(hexString: "#caced8") ?? .white
    }
    
    // MARK: - Properties
    private let tableView = TableView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    // MARK: - Configure TableView
    private func configureTableView() {
        view.backgroundColor = Constants.backgroundColor
        view.addSubview(tableView)
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.pin(to: view, TableView.Constants.tableOffset)
        
        tableView.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        tableView.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numberOfSections
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return wishArray.count
        default:
            return 0
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseId, for: indexPath)
            guard let addCell = cell as? AddWishCell else { return cell }
            
            let addButton = addCell.getAddButton()
            addButton.removeTarget(nil, action: nil, for: .allEvents)
            addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
            return addCell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath)
            guard let wishCell = cell as? WrittenWishCell else { return cell }
            wishCell.configure(with: wishArray[indexPath.row])
            return wishCell
        default:
            return UITableViewCell()
        }
    }
    
    @objc private func didTapAddButton() {
        guard let addCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AddWishCell else { return }
        guard let wishText = addCell.getWishTextView().text, !wishText.isEmpty else { return }
        
        wishArray.append(wishText)
        addCell.getWishTextView().text = ""
        tableView.reloadData()
    }
}
