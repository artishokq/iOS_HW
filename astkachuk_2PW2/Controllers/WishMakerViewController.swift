//
//  WishMakerViewController.swift
//  astkachuk_2PW2
//
//  Created by Artem Tkachuk on 28.10.2024.
//

import UIKit

final class WishMakerViewController: UIViewController {
    
    // MARK: - Properties
    private var colorModel = ColorModel()
    private let wishMakerView = WishMakerView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWishMakerView()
        
        // Устанавливаем положение слайдеров в зависимости от заданного начального цвета
        wishMakerView.getSliderRed().setSliderValue(Float(colorModel.red), animated: false)
        wishMakerView.getSliderGreen().setSliderValue(Float(colorModel.green), animated: false)
        wishMakerView.getSliderBlue().setSliderValue(Float(colorModel.blue), animated: false)
        
        configureSliderActions()
        configureButtonActions()
        updateBackgroundColor()
    }
    // MARK: - Configure WishMakerView
    private func configureWishMakerView() {
        view.addSubview(wishMakerView)
        
        wishMakerView.translatesAutoresizingMaskIntoConstraints = false
        wishMakerView.pinTop(to: view.topAnchor)
        wishMakerView.pinBottom(to: view.bottomAnchor)
        wishMakerView.pinLeft(to: view.leadingAnchor)
        wishMakerView.pinRight(to: view.trailingAnchor)
    }
    
    // MARK: - Configure Actions
    private func configureSliderActions() {
        wishMakerView.getSliderRed().setValueChangedHandler { [weak self] value in
            self?.colorModel.red = CGFloat(value)
            self?.updateBackgroundColor()
        }
        
        wishMakerView.getSliderGreen().setValueChangedHandler { [weak self] value in
            self?.colorModel.green = CGFloat(value)
            self?.updateBackgroundColor()
        }
        
        wishMakerView.getSliderBlue().setValueChangedHandler { [weak self] value in
            self?.colorModel.blue = CGFloat(value)
            self?.updateBackgroundColor()
        }
    }
    
    private func configureButtonActions() {
        wishMakerView.getRandomColorButton().addTarget(self, action: #selector(changeToRandomColor), for: .touchUpInside)
        wishMakerView.getHexColorButton().addTarget(self, action: #selector(chanheToHexColor), for: .touchUpInside)
        wishMakerView.getHideSlidersButton().addTarget(self, action: #selector(slidersVisibility), for: .touchUpInside)
    }
    
    // MARK: - Background Update
    private func updateBackgroundColor() {
        view.backgroundColor = colorModel.getColor()
    }
    
    // MARK: - Button Actions
    @objc
    private func slidersVisibility() {
        wishMakerView.getSlidersStack().isHidden.toggle()
        let buttonTitle = wishMakerView.getSlidersStack().isHidden ? "Вернуть слайдеры" : "Скрыть слайдеры"
        wishMakerView.getHideSlidersButton().setTitle(buttonTitle, for: .normal)
    }
    
    @objc
    private func changeToRandomColor() {
        let newColor = ColorModel(random: true)
        colorModel = newColor
        updateBackgroundColor()
        
        wishMakerView.getSliderRed().setSliderValue(Float(colorModel.red), animated: true)
        wishMakerView.getSliderGreen().setSliderValue(Float(colorModel.green), animated: true)
        wishMakerView.getSliderBlue().setSliderValue(Float(colorModel.blue), animated: true)
    }
    
    @objc
    private func chanheToHexColor() {
        let alertController = UIAlertController(title: "Введите Hex-код", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "#FFFFFF"
            textField.keyboardType = .default
        }
        
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let self = self,
                  let hexText = alertController.textFields?.first?.text else { return }
            
            // Убираем лишние символы и приводим к верхнему регистру
            let cleanedHexString = hexText.trimmingCharacters(in: CharacterSet.alphanumerics.inverted).uppercased()
            
            // Создаем множество допустимых символов и проверяем наличие только этих символов
            let validHexCharacters = CharacterSet(charactersIn: "0123456789ABCDEF")
            let hexCharacterSet = CharacterSet(charactersIn: cleanedHexString)
            let isValidHex = validHexCharacters.isSuperset(of: hexCharacterSet)
            
            // Проверяем длину строки
            let isValidLength = cleanedHexString.count == 6
            
            if isValidHex && isValidLength {
                // Создаем UIColor и преобразуем в CIColor для получения компонентов RGB
                if let color = UIColor(hexString: cleanedHexString) {
                    let rgbColorComponents = CIColor(color: color)
                    self.colorModel.red = rgbColorComponents.red
                    self.colorModel.green = rgbColorComponents.green
                    self.colorModel.blue = rgbColorComponents.blue
                    
                    // Обновляем слайдеры с новыми значениями
                    self.wishMakerView.getSliderRed().setSliderValue(Float(colorModel.red), animated: true)
                    self.wishMakerView.getSliderGreen().setSliderValue(Float(colorModel.green), animated: true)
                    self.wishMakerView.getSliderBlue().setSliderValue(Float(colorModel.blue), animated: true)
                    
                    self.updateBackgroundColor()
                }
            } else {
                // Показываем предупреждение о некорректном hex-коде
                let errorAlert = UIAlertController(
                    title: "Ошибка",
                    message: "Некорректный Hex-код цвета. Пожалуйста, введите 6 символов, используя цифры 0-9 и буквы A-F. Пример: #FFFFFF или FFFFFF",
                    preferredStyle: .alert
                )
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(errorAlert, animated: true, completion: nil)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
