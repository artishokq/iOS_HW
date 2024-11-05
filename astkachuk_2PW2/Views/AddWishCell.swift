//
//  AddWishCell.swift
//  astkachuk_2PW2
//
//  Created by Artem Tkachuk on 05.11.2024.
//

import UIKit

final class AddWishCell: UITableViewCell {
    static let reuseId: String = "AddWishCell"
    
    var addWish: ((String) -> ())?
    
    // MARK: - Constants
    private enum Constants{
        static let wishTextBackgroundColor: UIColor = .white
        static let wishTextBorderColor: CGColor = UIColor.gray.cgColor
        static let wishTextBorderWidth: CGFloat = 2.0
        static let wishTextCornerRadius: CGFloat = 16.0
        static let wishTextFontSize: UIFont = .systemFont(ofSize: 16.0)
        static let wishTextColor: UIColor = .black
        
        static let wishTextVerticalPadding: CGFloat = 10.0
        static let wishTextHorizontalPadding: CGFloat = 10.0
        static let wishTextHeight: CGFloat = 100.0
        
        static let addButtonText: String = "Добавить желание"
        static let addButtonFontSize: UIFont = .systemFont(ofSize: 16.0)
        static let addButtonBackgroundColor: UIColor = UIColor(hexString: "#ffdd3c") ?? .yellow
        static let addButtonTitleColor: UIColor = .white
        static let addButtonCornerRadius: CGFloat = 8.0
        
        static let addButtonVerticalPadding: CGFloat = 10.0
        static let addButtonHeight: CGFloat = 40.0
        static let addButtonWidht: CGFloat = 200.0
    }
    
    // MARK: - Properties
    private let wishTextView: UITextView = UITextView()
    private let addButton: UIButton = UIButton()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        configureWishText()
        configureAddButton()
    }
    
    private func configureWishText() {
        wishTextView.translatesAutoresizingMaskIntoConstraints = false
        
        wishTextView.backgroundColor = Constants.wishTextBackgroundColor
        wishTextView.layer.borderColor = Constants.wishTextBorderColor
        wishTextView.layer.borderWidth = Constants.wishTextBorderWidth
        wishTextView.layer.cornerRadius = Constants.wishTextCornerRadius
        wishTextView.font = Constants.wishTextFontSize
        wishTextView.textColor = Constants.wishTextColor
        
        contentView.addSubview(wishTextView)
        
        wishTextView.pinTop(to: contentView.topAnchor, Constants.wishTextVerticalPadding)
        wishTextView.pinLeft(to: contentView.leadingAnchor, Constants.wishTextHorizontalPadding)
        wishTextView.pinRight(to: contentView.trailingAnchor, Constants.wishTextHorizontalPadding)
        wishTextView.setHeight(Constants.wishTextHeight)
    }
    
    private func configureAddButton() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        addButton.setTitle(Constants.addButtonText, for: .normal)
        addButton.titleLabel?.font = Constants.addButtonFontSize
        addButton.backgroundColor = Constants.addButtonBackgroundColor
        addButton.setTitleColor(Constants.addButtonTitleColor, for: .normal)
        addButton.layer.cornerRadius = Constants.addButtonCornerRadius
        
        contentView.addSubview(addButton)
        
        addButton.pinTop(to: wishTextView.bottomAnchor, Constants.addButtonVerticalPadding)
        addButton.pinCenterX(to: contentView.centerXAnchor)
        addButton.setWidth(Constants.addButtonWidht)
        addButton.setHeight(Constants.addButtonHeight)
        addButton.pinBottom(to: contentView.bottomAnchor, Constants.addButtonVerticalPadding)
    }
    
    // MARK: - Public Methods for Access
    func getAddButton() -> UIButton {
        return addButton
    }
    
    func getWishTextView() -> UITextView {
        return wishTextView
    }
}
