//
//  LabeledPicker.swift
//  Voronka
//
//  Created by Danil Shvetsov on 06.02.2023.
//

import UIKit

final class LabeledPicker: UIButton {
    
    private lazy var title: UILabel = {
        let label = UILabel()
        
        label.text = config.text
        label.textColor = appearance.labelTextColor
        label.textAlignment = .left
        label.font = appearance.labelFont
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        
        textField.font = appearance.textFieldFont
        textField.textColor = appearance.textFieldFontColor
        textField.tintColor = appearance.textFieldTintColor
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        
        textField.attributedPlaceholder = NSAttributedString(
            string: config.placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: appearance.placeholderColor]
        )
        
        textField.delegate = self
        textField.inputView = picker
        
        return textField
    }()
    
    private lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        
        picker.dataSource = self
        picker.delegate = self
        
        return picker
    }()
    
    private lazy var underline: UIView = {
        let view = UIView()
        
        view.backgroundColor = appearance.underlineViewDefaultColor
        
        return view
    }()
    
    private lazy var downArrow: UIImageView = {
        let arrow = UIImageView()
        
        arrow.image = appearance.downArrowImage
        arrow.tintColor = appearance.downArrowTintColor
        
        return arrow
    }()
    
    private let config: Configuration
    private let appearance: Appearance
    
    init(configuration: Configuration, appearance: Appearance) {
        self.config = configuration
        self.appearance = appearance
        
        super.init(frame: .zero)
        
        self.addTarget(self, action: #selector(labeledPickerPressed), for: .touchUpInside)
        
        self.setHeight(to: 45)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUI() {
        layoutTitle()
        layoutTextField()
        layoutUnderline()
        layoutArrow()
    }
    
    private func layoutTitle() {
        self.addSubview(title)
        
        title.pinTop(to: self.topAnchor)
        title.pinLeft(to: self.leadingAnchor)
        title.pinRight(to: self.trailingAnchor)
    }
    
    private func layoutTextField() {
        let toolbar = setupToolbar()
        self.textField.inputAccessoryView = toolbar
        
        self.addSubview(textField)
        
        textField.pinTop(to: title.bottomAnchor, appearance.textFieldTopOffset)
        textField.pinLeft(to: self.leadingAnchor)
        textField.pinRight(to: self.trailingAnchor)
        
        textField.setHeight(to: appearance.textFieldFont.lineHeight)
    }
    
    private func setupToolbar() -> UIToolbar {
        // A toolbar for date picker.
        let toolbar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 50))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(toolbarPressedCancel))
        let barButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(toolbarPressedDone))
        toolbar.setItems([cancel, flexible, barButton], animated: true)
        
        return toolbar
    }
    
    @objc
    private func toolbarPressedCancel() {
        self.textField.resignFirstResponder()
    }
    
    @objc
    private func toolbarPressedDone() {
        let row = self.picker.selectedRow(inComponent: 0)
        self.picker.selectRow(row, inComponent: 0, animated: false)
        self.textField.text = self.config.options[row]
        
        self.textField.resignFirstResponder()
    }
    
    private func layoutUnderline() {
        self.addSubview(underline)
        
        underline.pinTop(to: textField.bottomAnchor, appearance.underlineViewTopOffset)
        underline.pinLeft(to: self.leadingAnchor)
        underline.pinRight(to: self.trailingAnchor)
        
        underline.setHeight(to: appearance.underlineViewHeight)
    }
    
    private func layoutArrow() {
        self.addSubview(downArrow)
        
        downArrow.pinCenterY(to: self)
        downArrow.pinRight(to: self.trailingAnchor, appearance.downArrowTrailingOffset)
    }
    
    @objc
    private func labeledPickerPressed() {
        if textField.isEditing {
            textField.resignFirstResponder()
            disableForegroundFonts()
        } else {
            textField.becomeFirstResponder()
            enableForegroundFonts()
        }
    }
    
    internal func enableForegroundFonts() {
        UIView.animate(withDuration: 0.17, delay: 0.04, animations: {}) { _ in
            UIView.transition(with: self.underline, duration: 0.17, options: .transitionCrossDissolve) {
                self.underline.backgroundColor = self.appearance.underlineViewSelectedColor
            }
            UIView.transition(with: self.title, duration: 0.17, options: .transitionCrossDissolve) {
                self.title.textColor = self.appearance.underlineViewSelectedColor
            }
            UIView.transition(with: self.downArrow, duration: 0.17, options: .transitionCrossDissolve) {
                self.downArrow.tintColor = self.appearance.underlineViewSelectedColor
            }
        }
    }
    
    internal func disableForegroundFonts() {
        UIView.animate(withDuration: 0.17, delay: 0.04, animations: {}) { _ in
            UIView.transition(with: self.underline, duration: 0.17, options: .transitionCrossDissolve) {
                self.underline.backgroundColor = self.appearance.underlineViewDefaultColor
            }
            UIView.transition(with: self.title, duration: 0.17, options: .transitionCrossDissolve) {
                self.title.textColor = self.appearance.textFieldFontColor
            }
            UIView.transition(with: self.downArrow, duration: 0.17, options: .transitionCrossDissolve) {
                self.downArrow.tintColor = self.appearance.downArrowTintColor
            }
        }
    }
    
}

extension LabeledPicker {
    
    struct Configuration {
        let text: String
        let placeholder: String
        let options: [String]
    }
    
    struct Appearance {
        static let common = Appearance(
            labelTextColor: AppConstants.Design.Color.Primary.White,
            labelFont: AppConstants.Design.Font.Primary.bold(withSize: 14),
            
            textFieldFont: AppConstants.Design.Font.Secondary.regular(withSize: 15),
            textFieldFontColor: AppConstants.Design.Color.Primary.White,
            textFieldTintColor: AppConstants.Design.Color.Primary.Blue,
            textFieldTopOffset: 7,
            
            placeholderColor: AppConstants.Design.Color.GrayScale.UltraLight,
            
            underlineViewDefaultColor: AppConstants.Design.Color.Secondary.UnderlineLightGray,
            underlineViewSelectedColor: AppConstants.Design.Color.Primary.Blue,
            underlineViewTopOffset: 5,
            underlineViewHeight: 0.5,
            
            downArrowImage: AppConstants.Design.Image.DownArrow,
            downArrowTintColor: AppConstants.Design.Color.GrayScale.UltraLight,
            downArrowTrailingOffset: 15
            
        )
        
        let labelTextColor: UIColor
        let labelFont: UIFont
        
        let textFieldFont: UIFont
        let textFieldFontColor: UIColor
        let textFieldTintColor: UIColor
        let textFieldTopOffset: Int
        
        let placeholderColor: UIColor
        
        let underlineViewDefaultColor: UIColor
        let underlineViewSelectedColor: UIColor
        let underlineViewTopOffset: Int
        let underlineViewHeight: CGFloat
        
        let downArrowImage: UIImage
        let downArrowTintColor: UIColor
        let downArrowTrailingOffset: Int
    }
    
}

extension LabeledPicker: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return config.options.count
    }
    
}

extension LabeledPicker: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return config.options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = config.options[row]
    }
    
}

extension LabeledPicker: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        enableForegroundFonts()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        disableForegroundFonts()
    }
    
}
