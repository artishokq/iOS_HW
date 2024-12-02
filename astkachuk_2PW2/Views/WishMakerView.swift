//
//  WishMakerView.swift
//  astkachuk_2PW2
//
//  Created by Artem Tkachuk on 30.10.2024.
//

import UIKit

final class WishMakerView: UIView {
    
    // MARK: - Constants
    enum Constants {
        static let sliderMin: Double = 0.0
        static let sliderMax: Double = 1.0
        
        static let stackRadius: CGFloat = 20.0
        static let stackBottomPadding: Double = 10.0
        static let stackLeadingPadding: Double = 20.0
        static let stackBackgroundColor: UIColor = .white
        static let stackSpace: CGFloat = 10.0
        
        static let buttonHeight: Double = 45.0
        static let buttonVerticalSpacing: Double = 10.0
        static let buttonHorizontalSpacing: Double = 5.0
        static let buttonLeadingPadding: Double = 20.0
        static let buttonTrailingPadding: Double = 20.0
        static let buttonBottomPanding: Double = 20.0
        static let buttonFontSize: CGFloat = 18.0
        static let buttonCornerRadius: CGFloat = 10.0
        static let backgroundButtonColor: UIColor = .white
        static let titleOnBackgroundColor: UIColor = .black
        static let addWishButtonText: String = "Добавить желание"
        static let scheduleWishesButtonText: String = "Планировать исполнения желаний"
        static let randomColorButtonText: String = "Случайный цвет"
        static let hexColorButtonText: String = "Введите Hex-код"
        static let hideSlidersButtonText: String = "Скрыть слайдеры"
        
        static let titleTopPadding: Double = 0.0
        static let titleLeadingPadding: Double = 20.0
        static let titleTextColor: UIColor = .white
        static let titleFontSize: CGFloat = 28
        static let titleText: String = "Wish Maker"
        
        static let descriptionTopPadding: Double = 10.0
        static let descriptionLeadingPadding: Double = 20.0
        static let descriptionTrailingPadding: Double = 20.0
        static let descriptionTextColor: UIColor = .white
        static let descriptionFontSize: CGFloat = 15
        static let descriptionText: String = "Можно изменить цвет фона используя слайдеры, кнопку рандомного цвета или ввести HEX-код. Также возможно скрыть слайдеры."
    }
    
    // MARK: - Fields
    private let titleView: UILabel = UILabel()
    private let descriptionView: UILabel = UILabel()
    
    private let slidersStack: UIStackView = UIStackView()
    private let actionStack: UIStackView = UIStackView()
    
    private let hideSlidersButton: UIButton = UIButton(type: .system)
    private let randomColorButton: UIButton = UIButton(type: .system)
    private let hexColorButton: UIButton = UIButton(type: .system)
    private let addWishButton: UIButton = UIButton(type: .system)
    private let scheduleWishesButton: UIButton = UIButton(type: .system)
    
    private var currentColor: UIColor = .white {
        didSet {
            updateUIColors()
        }
    }
    
    private let sliderRed = CustomSliderView(title: "Red", min: Constants.sliderMin, max: Constants.sliderMax)
    private let sliderGreen = CustomSliderView(title: "Green", min: Constants.sliderMin, max: Constants.sliderMax)
    private let sliderBlue = CustomSliderView(title: "Blue", min: Constants.sliderMin, max: Constants.sliderMax)
    
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
        configureTitle()
        configureDescription()
        configureActionStack()
        configureSliders()
        configureRandomColorButton()
        configureHexColorButton()
        configureHideSlidersButton()
    }
    
    private func configureTitle() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.text = Constants.titleText
        titleView.textColor = Constants.titleTextColor
        titleView.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        titleView.textAlignment = .center
        
        addSubview(titleView)
        titleView.pinCenterX(to: self)
        titleView.pinLeft(to: self, Constants.titleLeadingPadding)
        titleView.pinTop(to: safeAreaLayoutGuide.topAnchor, Constants.titleTopPadding)
    }
    
    private func configureDescription() {
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.text = Constants.descriptionText
        descriptionView.textColor = Constants.descriptionTextColor
        descriptionView.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        descriptionView.textAlignment = .justified
        descriptionView.numberOfLines = 0
        
        addSubview(descriptionView)
        
        descriptionView.pinCenterX(to: self)
        descriptionView.pinTop(to: titleView.bottomAnchor, Constants.descriptionTopPadding)
        descriptionView.pinLeft(to: self, Constants.descriptionLeadingPadding)
        descriptionView.pinRight(to: self, Constants.descriptionTrailingPadding)
    }
    
    private func configureAddWishButton() {
        addWishButton.translatesAutoresizingMaskIntoConstraints = false
        addWishButton.backgroundColor = Constants.backgroundButtonColor
        addWishButton.setTitleColor(Constants.titleOnBackgroundColor, for: .normal)
        addWishButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonFontSize)
        addWishButton.setTitle(Constants.addWishButtonText, for: .normal)
        addWishButton.layer.cornerRadius = Constants.buttonCornerRadius
        
        addWishButton.setHeight(Constants.buttonHeight)
    }
    
    private func configureScheduleWishesButton() {
        scheduleWishesButton.translatesAutoresizingMaskIntoConstraints = false
        scheduleWishesButton.backgroundColor = Constants.backgroundButtonColor
        scheduleWishesButton.setTitleColor(Constants.titleOnBackgroundColor, for: .normal)
        scheduleWishesButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonFontSize)
        scheduleWishesButton.setTitle(Constants.scheduleWishesButtonText, for: .normal)
        scheduleWishesButton.layer.cornerRadius = Constants.buttonCornerRadius
        
        scheduleWishesButton.setHeight(Constants.buttonHeight)
    }
    
    private func configureActionStack() {
        actionStack.translatesAutoresizingMaskIntoConstraints = false
        actionStack.axis = .vertical
        actionStack.spacing = Constants.stackSpace
        addSubview(actionStack)
        
        actionStack.addArrangedSubview(scheduleWishesButton)
        actionStack.addArrangedSubview(addWishButton)
        
        configureScheduleWishesButton()
        configureAddWishButton()
        
        actionStack.pinLeft(to: self, Constants.stackLeadingPadding)
        actionStack.pinRight(to: self, Constants.stackLeadingPadding)
        actionStack.pinBottom(to: safeAreaLayoutGuide.bottomAnchor, Constants.stackBottomPadding)
    }
    
    private func configureSliders() {
        slidersStack.translatesAutoresizingMaskIntoConstraints = false
        slidersStack.axis = .vertical
        slidersStack.spacing = Constants.stackSpace
        slidersStack.layer.cornerRadius = Constants.stackRadius
        slidersStack.clipsToBounds = true
        slidersStack.backgroundColor = Constants.stackBackgroundColor
        
        addSubview(slidersStack)
        
        slidersStack.addArrangedSubview(sliderRed)
        slidersStack.addArrangedSubview(sliderGreen)
        slidersStack.addArrangedSubview(sliderBlue)
        
        slidersStack.pinLeft(to: self, Constants.stackLeadingPadding)
        slidersStack.pinRight(to: self, Constants.stackLeadingPadding)
        slidersStack.pinBottom(to: actionStack.topAnchor, Constants.stackBottomPadding)
    }
    
    private func configureRandomColorButton() {
        randomColorButton.setTitle(Constants.randomColorButtonText, for: .normal)
        randomColorButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonFontSize)
        randomColorButton.backgroundColor = Constants.backgroundButtonColor
        randomColorButton.setTitleColor(Constants.titleOnBackgroundColor, for: .normal)
        randomColorButton.layer.cornerRadius = Constants.buttonCornerRadius
        randomColorButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(randomColorButton)
        randomColorButton.pinRight(to: centerXAnchor, Constants.buttonHorizontalSpacing)
        randomColorButton.pinLeft(to: self, Constants.buttonLeadingPadding)
        randomColorButton.setHeight(mode: .equal, Constants.buttonHeight)
        randomColorButton.pinBottom(to: slidersStack.topAnchor, Constants.buttonVerticalSpacing)
    }
    
    private func configureHexColorButton() {
        hexColorButton.setTitle(Constants.hexColorButtonText, for: .normal)
        hexColorButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonFontSize)
        hexColorButton.backgroundColor = Constants.backgroundButtonColor
        hexColorButton.setTitleColor(Constants.titleOnBackgroundColor, for: .normal)
        hexColorButton.layer.cornerRadius = Constants.buttonCornerRadius
        hexColorButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(hexColorButton)
        hexColorButton.pinLeft(to: centerXAnchor, Constants.buttonHorizontalSpacing)
        hexColorButton.pinRight(to: self, Constants.buttonTrailingPadding)
        hexColorButton.setHeight(mode: .equal, Constants.buttonHeight)
        hexColorButton.pinBottom(to: slidersStack.topAnchor, Constants.buttonVerticalSpacing)
    }
    
    private func configureHideSlidersButton() {
        hideSlidersButton.setTitle(Constants.hideSlidersButtonText, for: .normal)
        hideSlidersButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonFontSize)
        hideSlidersButton.backgroundColor = Constants.backgroundButtonColor
        hideSlidersButton.setTitleColor(Constants.titleOnBackgroundColor, for: .normal)
        hideSlidersButton.layer.cornerRadius = Constants.buttonCornerRadius
        hideSlidersButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(hideSlidersButton)
        hideSlidersButton.pinRight(to: centerXAnchor, Constants.buttonHorizontalSpacing)
        hideSlidersButton.pinLeft(to: self, Constants.buttonLeadingPadding)
        hideSlidersButton.setHeight(mode: .equal, Constants.buttonHeight)
        hideSlidersButton.pinBottom(to: randomColorButton.topAnchor, Constants.buttonVerticalSpacing)
    }
    
    private func updateUIColors() {
        // Update button title colors
        addWishButton.setTitleColor(currentColor, for: .normal)
        scheduleWishesButton.setTitleColor(currentColor, for: .normal)
        randomColorButton.setTitleColor(currentColor, for: .normal)
        hexColorButton.setTitleColor(currentColor, for: .normal)
        hideSlidersButton.setTitleColor(currentColor, for: .normal)
    }
    
    // MARK: - Public Methods for Access
    func getSliderRed() -> CustomSliderView {
        return sliderRed
    }
    
    func getSliderGreen() -> CustomSliderView {
        return sliderGreen
    }
    
    func getSliderBlue() -> CustomSliderView {
        return sliderBlue
    }
    
    func getSlidersStack() -> UIStackView {
        return slidersStack
    }
    
    func setColor(_ color: UIColor) {
        currentColor = color
    }
    
    // MARK: - Button Access
    func getHideSlidersButton() -> UIButton {
        return hideSlidersButton
    }
    
    func getRandomColorButton() -> UIButton {
        return randomColorButton
    }
    
    func getHexColorButton() -> UIButton {
        return hexColorButton
    }
    
    func getAddWishButton() -> UIButton {
        return addWishButton
    }
    
    func getScheduleWishesButton() -> UIButton {
        return scheduleWishesButton
    }
}
