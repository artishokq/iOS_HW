//
//  WishEventCreationView.swift
//  astkachuk_2PW2
//
//  Created by Artem Tkachuk on 01.12.2024.
//

import UIKit

class WishEventCreationView: UIView {
    private enum Constants {
        static let backgroundColor: UIColor = UIColor(hexString: "1C1C1E") ?? .systemGray
        
        static let titlePlaceholder: String = "Название события"
        static let titleBorderStyle: UITextField.BorderStyle = .roundedRect
        static let titleTextColor: UIColor = .black
        static let titleTopPadding: CGFloat = 18
        static let titleHorizontalPadding: CGFloat = 20
        static let titleHeight: CGFloat = 40
        
        static let descriptionTextColor: UIColor = .black
        static let descriptionTopPadding: CGFloat = 15
        static let descriptionHorizontalPadding: CGFloat = 20
        static let descriptionHeight: CGFloat = 80
        static let descriptionFont: UIFont = .systemFont(ofSize: 16)
        static let descriptionNumberOfLines: Int = 0
        static let descriptionCornerRadius: CGFloat = 5.0
        
        static let startDatePickerPlaceholder: String = "Дата начала"
        static let startDateLabelTextColor: UIColor = .white
        static let startDatePickerColor: UIColor = .white
        static let startDateLabelFont: UIFont = .systemFont(ofSize: 20)
        static let startDatePickerMode: UIDatePicker.Mode = .dateAndTime
        static let startDAtePickerStyle: UIDatePickerStyle = .compact
        static let startDatePickerTopPadding: CGFloat = 20
        static let startDateLabelTopPadding: CGFloat = 20
        static let startDateLabelHorixontalPadding: CGFloat = 20
        static let startDatePickerHorizontalPadding: CGFloat = 20
        
        static let endDatePickerPlaceholder: String = "Дата конца"
        static let endDateLabelTextColor: UIColor = .white
        static let endDatePickerColor: UIColor = .white
        static let endDateLabelFont: UIFont = .systemFont(ofSize: 20)
        static let endDatePickerMode: UIDatePicker.Mode = .dateAndTime
        static let endDAtePickerStyle: UIDatePickerStyle = .compact
        static let endDatePickerTopPadding: CGFloat = 20
        static let endDateLabelTopPadding: CGFloat = 22
        static let endDateLabelHorixontalPadding: CGFloat = 20
        static let endDatePickerHorizontalPadding: CGFloat = 20
        
        static let buttonBackgroundColor: UIColor = .orange
        static let buttonHeight: CGFloat = 50
        static let buttonWith: CGFloat = 90
        static let buttonTitle: String = "Добавить"
        static let buttonTopPadding: CGFloat = 15
        static let buttonCorenerRadius: CGFloat = 10
        static let buttonTitleColor: UIColor = .white
        static let buttonTitleSize: CGFloat = 18.0
        
        static let textFieldHeight: CGFloat = 40
        static let padding: CGFloat = 20
    }
    
    // MARK: - Properties
    private let titleTextField: UITextField = UITextField()
    private let descriptionTextView: UITextView = UITextView()
    private let startDateLabel: UILabel = UILabel()
    private let startDatePicker: UIDatePicker = UIDatePicker()
    private let endDatePicker: UIDatePicker = UIDatePicker()
    private let endDateLabel: UILabel = UILabel()
    private let addEventButton: UIButton = UIButton(type: .system)
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        backgroundColor = Constants.backgroundColor
        configureTitleTextField()
        configerDescriptionTextField()
        configerStartDatePicker()
        configerEndDatePicker()
        configureAddEventButton()
    }
    
    private func configureTitleTextField() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleTextField)
        titleTextField.placeholder = Constants.titlePlaceholder
        titleTextField.borderStyle = Constants.titleBorderStyle
        titleTextField.textColor = Constants.titleTextColor
        
        titleTextField.pinTop(to: self.topAnchor, Constants.titleTopPadding)
        titleTextField.pinCenterX(to: self.centerXAnchor)
        titleTextField.pinHorizontal(to: self, Constants.titleHorizontalPadding)
        titleTextField.setHeight(Constants.titleHeight)
    }
    
    private func configerDescriptionTextField() {
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionTextView)
        descriptionTextView.textColor = Constants.descriptionTextColor
        descriptionTextView.font = Constants.descriptionFont
        descriptionTextView.isEditable = true
        descriptionTextView.isScrollEnabled = true
        descriptionTextView.layer.cornerRadius = Constants.descriptionCornerRadius
        
        descriptionTextView.pinTop(to: titleTextField.bottomAnchor, Constants.descriptionTopPadding)
        descriptionTextView.pinCenterX(to: self.centerXAnchor)
        descriptionTextView.pinHorizontal(to: self, Constants.descriptionHorizontalPadding)
        descriptionTextView.setHeight(Constants.descriptionHeight)
    }
    
    private func configerStartDatePicker() {
        startDateLabel.translatesAutoresizingMaskIntoConstraints = false
        startDatePicker.translatesAutoresizingMaskIntoConstraints = false
        addSubview(startDatePicker)
        addSubview(startDateLabel)
        
        startDateLabel.text = Constants.startDatePickerPlaceholder
        startDateLabel.textColor = Constants.startDateLabelTextColor
        startDateLabel.font = Constants.startDateLabelFont
        
        startDatePicker.datePickerMode = Constants.startDatePickerMode
        startDatePicker.preferredDatePickerStyle = Constants.startDAtePickerStyle
        startDatePicker.setValue(Constants.startDatePickerColor, forKey: "textColor")
        
        startDateLabel.pinTop(to: descriptionTextView.bottomAnchor, Constants.startDateLabelTopPadding)
        startDateLabel.pinLeft(to: self, Constants.startDateLabelHorixontalPadding)
        
        startDatePicker.pinTop(to: descriptionTextView.bottomAnchor, Constants.startDatePickerTopPadding)
        startDatePicker.pinLeft(to: self, Constants.startDatePickerHorizontalPadding)
        startDatePicker.pinRight(to: self, Constants.startDatePickerHorizontalPadding)
    }
    
    private func configerEndDatePicker() {
        endDateLabel.translatesAutoresizingMaskIntoConstraints = false
        endDatePicker.translatesAutoresizingMaskIntoConstraints = false
        addSubview(endDatePicker)
        addSubview(endDateLabel)
        
        endDateLabel.text = Constants.endDatePickerPlaceholder
        endDateLabel.textColor = Constants.endDateLabelTextColor
        endDateLabel.font = Constants.endDateLabelFont
        
        endDatePicker.datePickerMode = Constants.endDatePickerMode
        endDatePicker.preferredDatePickerStyle = Constants.endDAtePickerStyle
        endDatePicker.setValue(Constants.endDatePickerColor, forKey: "textColor")
        
        endDateLabel.pinTop(to: startDatePicker.bottomAnchor, Constants.endDateLabelTopPadding)
        endDateLabel.pinLeft(to: self, Constants.endDateLabelHorixontalPadding)
        
        endDatePicker.pinTop(to: startDatePicker.bottomAnchor, Constants.endDatePickerTopPadding)
        endDatePicker.pinLeft(to: self, Constants.endDatePickerHorizontalPadding)
        endDatePicker.pinRight(to: self, Constants.endDatePickerHorizontalPadding)
    }
    
    private func configureAddEventButton() {
        addEventButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(addEventButton)
        addEventButton.setTitle(Constants.buttonTitle, for: .normal)
        addEventButton.titleLabel?.font = .systemFont(ofSize: Constants.buttonTitleSize)
        addEventButton.backgroundColor = Constants.buttonBackgroundColor
        addEventButton.layer.cornerRadius = Constants.buttonCorenerRadius
        addEventButton.setTitleColor(Constants.buttonTitleColor, for: .normal)
        
        addEventButton.setHeight(Constants.buttonHeight)
        addEventButton.setWidth(Constants.buttonWith)
        addEventButton.pinTop(to: endDatePicker.bottomAnchor, Constants.buttonTopPadding)
        addEventButton.pinCenterX(to: self.centerXAnchor)
    }
    
    func getAddEventButton() -> UIButton {
        return addEventButton
    }
    
    func getTitleTextField() -> UITextField {
        return titleTextField
    }
    
    func getDescriptionTextField() -> UITextView {
        return descriptionTextView
    }
    
    func getStartDatePicker() -> UIDatePicker {
        return startDatePicker
    }
    
    func getEndDatePicker() -> UIDatePicker {
        return endDatePicker
    }
}
