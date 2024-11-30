//
//  WishCalendarViewController.swift
//  astkachuk_2PW2
//
//  Created by Artem Tkachuk on 30.11.2024.
//

import UIKit

final class WishCalendarViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        static let contentInset: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        static let blackColor: UIColor = UIColor(hexString: "000000") ?? .black
        static let minimumInteritemSpacing: CGFloat = 0
        static let minimumLineSpacing: CGFloat = 0
        static let cellHeight: CGFloat = 100
        static let bottomOffset: CGFloat = 25
    }
    
    // MARK: - Properties
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.blackColor
        configureCollection()
    }
    
    // MARK: - Configure Collection
    private func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Constants.blackColor
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = Constants.contentInset
        
        if let layout = collectionView.collectionViewLayout as?
            UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = Constants.minimumInteritemSpacing
            layout.minimumLineSpacing = Constants.minimumLineSpacing
            layout.invalidateLayout()
        }
        
        /* Temporary line */
        collectionView.register(
            WishEventCell.self,
            forCellWithReuseIdentifier: WishEventCell.reuseIdentifier
        )
        
        view.addSubview(collectionView)
        collectionView.pinHorizontal(to: view)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, Constants.bottomOffset)
        collectionView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
    }
}

// MARK: - UICollectionViewDataSource
extension WishCalendarViewController: UICollectionViewDataSource {
    func collectionView(
        _
        collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 8 //Изменить на количество сохранненых в кор дате
    }
    func collectionView(
        _
        collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                        WishEventCell.reuseIdentifier, for: indexPath)
        guard let wishEventCell = cell as? WishEventCell else {
            return cell
        }
        wishEventCell.configure(
            with: WishEventModel(
                title: "Test",
                description: "Test description",
                startDate: "Start date",
                endDate: "End date"
            )
        )
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WishCalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _
        collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        // Adjust cell size as needed
        return CGSize(width: collectionView.bounds.width - 10, height: Constants.cellHeight)
    }
    func collectionView(
        _
        collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print("Cell tapped at index \(indexPath.item)")
    }
}
