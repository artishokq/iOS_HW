//
//  TableView.swift
//  astkachuk_2PW2
//
//  Created by Artem Tkachuk on 04.11.2024.
//

import UIKit

final class TableView: UITableView {
    // MARK: - Constants
    enum Constants {
        static let tableCornerRadius: CGFloat = 20.0
        static let tableOffset: Double = 20.0
        static let tableBackgroundColor: UIColor = UIColor(hexString: "#65281d") ?? .red
    }
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero, style: .plain)
        configureTable()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Configuration
    private func configureTable() {
        backgroundColor = Constants.tableBackgroundColor
        separatorStyle = .none
        layer.cornerRadius = Constants.tableCornerRadius
    }
}
