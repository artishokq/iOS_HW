//
//  WishEventCreationViewController.swift
//  astkachuk_2PW2
//
//  Created by Artem Tkachuk on 01.12.2024.
//

import UIKit

protocol WishEventCreationDelegate: AnyObject {
    func didAddNewEvent(_ event: WishEventModel)
}

final class WishEventCreationViewController: UIViewController {
    // MARK: - Properties
    private var wishEventCreationView = WishEventCreationView()
    weak var delegate: WishEventCreationDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWishEventCreationView()
        configureButtonAction()
    }
    
    // MARK: - View Configuration
    private func configureWishEventCreationView() {
        view.addSubview(wishEventCreationView)
        
        wishEventCreationView.translatesAutoresizingMaskIntoConstraints = false
        wishEventCreationView.pinTop(to: view.topAnchor)
        wishEventCreationView.pinBottom(to: view.bottomAnchor)
        wishEventCreationView.pinLeft(to: view.leadingAnchor)
        wishEventCreationView.pinRight(to: view.trailingAnchor)
    }
    
    private func configureButtonAction() {
        wishEventCreationView.getAddEventButton().addTarget(self, action: #selector(addEventWishButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func addEventWishButtonPressed() {
        let title = wishEventCreationView.getTitleTextField().text ?? ""
        let description = wishEventCreationView.getDescriptionTextField().text ?? ""

        guard !title.isEmpty else {
            // Показать сообщение, что название обязательно
            showAlert(message: "Название события обязательно!")
            return
        }

        let startDate = formatDate(wishEventCreationView.getStartDatePicker().date)
        let endDate = formatDate(wishEventCreationView.getEndDatePicker().date)
        let newEvent = WishEventModel(title: title, description: description, startDate: startDate, endDate: endDate)
        delegate?.didAddNewEvent(newEvent)
        dismiss(animated: true, completion: nil)
    }

    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)

        // Устанавливаем красную рамку на поле названия, если оно пустое
        let titleField = wishEventCreationView.getTitleTextField()
        if titleField.text?.isEmpty == true {
            titleField.layer.borderColor = UIColor.red.cgColor
            titleField.layer.borderWidth = 1.0
        }
    }

    @objc
    private func titleFieldDidChange() {
        let titleField = wishEventCreationView.getTitleTextField()
        if !(titleField.text?.isEmpty ?? true) {
            titleField.layer.borderColor = UIColor.clear.cgColor
            titleField.layer.borderWidth = 0.0
        }
    }

    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}
