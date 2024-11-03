//
//  CustomSliderView.swift
//  astkachuk_2PW2
//
//  Created by Artem Tkachuk on 29.10.2024.
//

import UIKit

final class CustomSliderView: UIView {
    // MARK: - Constants
    enum Constants {
        static let titleTopPadding: Double = 10
        static let titleLeadingPadding: Double = 20
        static let sliderBottomPadding: Double = 10
        static let sliderLeadingPadding: Double = 20
    }
    
    private var valueChanged: ((Double) -> Void)?
    private var slider: UISlider = UISlider()
    private var titleView: UILabel = UILabel()
    
    // MARK: - Initialization
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        for view in [slider, titleView] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        titleView.pinCenterX(to: self)
        titleView.pinTop(to: self, Constants.titleTopPadding)
        titleView.pinLeft(to: self, Constants.titleLeadingPadding)
        
        slider.pinTop(to: titleView.bottomAnchor)
        slider.pinCenterX(to: self)
        slider.pinBottom(to: self, Constants.sliderBottomPadding)
        slider.pinLeft(to: self, Constants.sliderLeadingPadding)
    }
    
    // MARK: - Accessor Methods
    func setValueChangedHandler(_ handler: @escaping (Double) -> Void) {
        valueChanged = handler
    }
    
    func setSliderValue(_ value: Float, animated: Bool) {
        slider.setValue(value, animated: animated)
    }
    
    func getSliderValue() -> Float {
        return slider.value
    }
    
    func getTitle() -> String? {
        return titleView.text
    }
    
    @objc
    private func sliderValueChanged() {
        valueChanged?(Double(slider.value))
    }
}
