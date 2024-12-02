//
//  WishEventCell.swift
//  astkachuk_2PW2
//
//  Created by Artem Tkachuk on 30.11.2024.
//

import UIKit

final class WishEventCell: UICollectionViewCell {
    // MARK: - Constants
    enum Constants {
        static let offset: CGFloat = 2.5
        static let cornerRadius: CGFloat = 24
        
        static let backgroundColor: UIColor = UIColor(hexString: "1C1C1E") ?? .systemGray
        static let whiteColor: UIColor = .white
        static let blackColor: UIColor = .black
        
        static let titleTop: CGFloat = 12
        static let titleFont: UIFont = .systemFont(ofSize: 20.0)
        static let titleLeading: CGFloat = 12
        
        static let descriptionTop: CGFloat = 5
        static let descriptionFont: UIFont = .systemFont(ofSize: 15.0)
        static let descriptionLeading: CGFloat = 12
        static let descriptionRight: CGFloat = 12
        static let descriptionBottom: CGFloat = 12
        
        static let startDateFont: UIFont = .systemFont(ofSize: 12.0)
        static let startDateRight: CGFloat = 12
        static let startDateTop: CGFloat = 8
        
        static let endDateFont: UIFont = .systemFont(ofSize: 12.0)
        static let endDateRight: CGFloat = 12
        static let endDateTop: CGFloat = 4
    }
    
    // MARK: - Properties
    static let reuseIdentifier: String = "WishEventCell"
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureWrap()
        configureTitleLabel()
        configureDescriptionLabel()
        configureStartDateLabel()
        configureEndDateLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Configuration
    func configure(with event: WishEventModel) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        startDateLabel.text = "Начало: \(event.startDate)"
        endDateLabel.text = "Конец: \(event.endDate)"
    }
    
    // MARK: - UI Configuration
    private func configureWrap() {
        addSubview(wrapView)
        wrapView.pin(to: self, Constants.offset)
        wrapView.layer.cornerRadius = Constants.cornerRadius
        wrapView.backgroundColor = Constants.backgroundColor
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = Constants.whiteColor
        titleLabel.pinTop(to: wrapView, Constants.titleTop)
        titleLabel.font = Constants.titleFont
        titleLabel.pinLeft(to: wrapView, Constants.titleLeading)
    }
    
    private func configureDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = Constants.whiteColor
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        
        descriptionLabel.font = Constants.descriptionFont
        descriptionLabel.pinLeft(to: wrapView, Constants.descriptionLeading)
        descriptionLabel.pinRight(to: wrapView, Constants.descriptionRight)
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, Constants.descriptionTop)
        descriptionLabel.pinBottom(to: wrapView, Constants.descriptionBottom)
        descriptionLabel.preferredMaxLayoutWidth = frame.width - Constants.offset * 2 - Constants.descriptionLeading * 2
    }
    
    private func configureStartDateLabel() {
        addSubview(startDateLabel)
        startDateLabel.translatesAutoresizingMaskIntoConstraints = false
        startDateLabel.textColor = Constants.whiteColor
        startDateLabel.font = Constants.startDateFont
        startDateLabel.textAlignment = .center
        startDateLabel.pinTop(to: wrapView, Constants.startDateTop)
        startDateLabel.pinRight(to: wrapView, Constants.startDateRight)
    }
    
    private func configureEndDateLabel() {
        addSubview(endDateLabel)
        endDateLabel.translatesAutoresizingMaskIntoConstraints = false
        endDateLabel.textColor = Constants.whiteColor
        endDateLabel.font = Constants.endDateFont
        endDateLabel.textAlignment = .center
        endDateLabel.pinTop(to: startDateLabel.bottomAnchor, Constants.endDateTop)
        endDateLabel.pinRight(to: wrapView, Constants.endDateRight)
    }
}
