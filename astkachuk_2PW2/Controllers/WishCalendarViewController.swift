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
        static let whiteColor: UIColor = .white
        static let minimumInteritemSpacing: CGFloat = 0
        static let minimumLineSpacing: CGFloat = 0
        static let cellHeight: CGFloat = 80
        static let bottomOffset: CGFloat = 70
        static let descriptionFontSize: CGFloat = 14
        
        static let addEventButtonBackColor: UIColor = .orange
        static let addEventButtonRadius: CGFloat = 10
        static let addEventButtonLeading: CGFloat = 40
        static let addEventButtonBottom: CGFloat = 15
        static let addEventButtonSize: Double = 40
        static let addEventButtonTitle: String = "+"
        static let addEventButtonTitleSize: CGFloat = 30
        
        static let deleteAllButtonBackColor: UIColor = .red
        static let deleteAllButtonRadius: CGFloat = 10
        static let deleteAllButtonRight: CGFloat = 40
        static let deleteAllButtonBottom: CGFloat = 15
        static let deleteAllButtonHeight: Double = 40
        static let deleteAllButtonWidth: Double = 100
        static let deleteAllButtonTitle: String = "Удалить всё"
        static let deleteAllButtonTitleSize: CGFloat = 14
        
        static let wishEventKey = "savedWisheEvents"
    }
    
    // MARK: - Properties
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    private let addEventButton: UIButton = UIButton(type: .system)
    private let deleteAllButton: UIButton = UIButton(type: .system)
    private var WishEventArray: [WishEventModel] = [] {
        didSet {
            saveEvents()
            collectionView.reloadData()
        }
    }
    private let defaults = UserDefaults.standard
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.blackColor
        loadEvents()
        configureCollection()
        configureAddEventButton()
        configureDeleteAllButton()
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
        collectionView.pinBottom(to: view.bottomAnchor, Constants.bottomOffset)
        collectionView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
    }
    
    // MARK: - Configure Buttons
    private func configureAddEventButton() {
        addEventButton.translatesAutoresizingMaskIntoConstraints = false
        addEventButton.setTitle(Constants.addEventButtonTitle, for: .normal)
        addEventButton.titleLabel?.font = .systemFont(ofSize: Constants.addEventButtonTitleSize)
        addEventButton.setTitleColor(Constants.whiteColor, for: .normal)
        addEventButton.backgroundColor = Constants.addEventButtonBackColor
        addEventButton.layer.cornerRadius = Constants.addEventButtonRadius
        
        view.addSubview(addEventButton)
        addEventButton.setHeight(Constants.addEventButtonSize)
        addEventButton.setWidth(Constants.addEventButtonSize)
        addEventButton.pinBottom(to: view.bottomAnchor, Constants.addEventButtonBottom)
        addEventButton.pinLeft(to: view, Constants.addEventButtonLeading)
        
        addEventButton.addTarget(self, action: #selector(addEventButtonPressed), for: .touchUpInside)
    }
    
    private func configureDeleteAllButton() {
        deleteAllButton.translatesAutoresizingMaskIntoConstraints = false
        deleteAllButton.setTitle(Constants.deleteAllButtonTitle, for: .normal)
        deleteAllButton.titleLabel?.font = .systemFont(ofSize: Constants.deleteAllButtonTitleSize)
        deleteAllButton.setTitleColor(Constants.whiteColor, for: .normal)
        deleteAllButton.backgroundColor = Constants.deleteAllButtonBackColor
        deleteAllButton.layer.cornerRadius = Constants.deleteAllButtonRadius
        
        view.addSubview(deleteAllButton)
        deleteAllButton.setHeight(Constants.deleteAllButtonHeight)
        deleteAllButton.setWidth(Constants.deleteAllButtonWidth)
        deleteAllButton.pinBottom(to: view.bottomAnchor, Constants.deleteAllButtonBottom)
        deleteAllButton.pinRight(to: view, Constants.deleteAllButtonRight)
        
        deleteAllButton.addTarget(self, action: #selector(deleteAllButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func addEventButtonPressed() {
        let wishEventCreationVC = WishEventCreationViewController()
        wishEventCreationVC.delegate = self  // Устанавливаем делегат
        present(wishEventCreationVC, animated: true)
    }
    
    @objc
    private func deleteAllButtonPressed() {
        WishEventArray.removeAll()
        saveEvents()
        collectionView.reloadData()
    }
    
    // MARK: - UserDefaults Handling
    func addNewEvent(_ event: WishEventModel) {
        WishEventArray.append(event)
        saveEvents()
    }
    
    private func saveEvents() {
        do {
            // Кодируем массив событий
            let encodedData = try JSONEncoder().encode(WishEventArray)
            // Сохраняем закодированные данные в UserDefaults
            defaults.set(encodedData, forKey: Constants.wishEventKey)
            print("Events saved: \(WishEventArray)")
        } catch {
            print("Error encoding events: \(error)")
        }
    }
    
    private func loadEvents() {
        if let savedEventsData = defaults.data(forKey: Constants.wishEventKey),
           let decodedEvents = try? JSONDecoder().decode([WishEventModel].self, from: savedEventsData) {
            WishEventArray = decodedEvents
        } else {
            WishEventArray = []
        }
    }
}

// MARK: - UICollectionViewDataSource
extension WishCalendarViewController: UICollectionViewDataSource {
    func collectionView(
        _
        collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return WishEventArray.count
    }
    
    func collectionView(
        _
        collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishEventCell.reuseIdentifier, for: indexPath)
        guard let wishEventCell = cell as? WishEventCell else { return cell }
        let event = WishEventArray[indexPath.item]
        wishEventCell.configure(with: event)
        
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
        let event = WishEventArray[indexPath.item]
        
        // Получаем текст, который нужно отобразить
        let descriptionText = event.description
        let font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        
        // Ширина ячейки за вычетом отступов
        let width = collectionView.bounds.width - 20
        
        // Используем метод boundingRect для вычисления высоты текста
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let estimatedSize = descriptionText.boundingRect(
            with: size,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        )
        
        // Высота ячейки будет зависеть от высоты текста, добавляем отступы
        let height = max(estimatedSize.height + 65, Constants.cellHeight)
        return CGSize(width: collectionView.bounds.width - 10, height: height)
    }
    func collectionView(
        _
        collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print("Cell tapped at index \(indexPath.item)")
    }
}

extension WishCalendarViewController: WishEventCreationDelegate {
    func didAddNewEvent(_ event: WishEventModel) {
        addNewEvent(event)
    }
}
