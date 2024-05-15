//
//  DateOfBirthPicker.swift
//  Voronka
//
//  Created by Danil Shvetsov on 06.02.2023.
//

import UIKit

final class DateOfBirthPicker: UIButton {
    
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
        textField.inputView = datePicker
        
        return textField
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        
        var components = DateComponents()
        components.year = -150
        let minDate = Calendar.current.date(byAdding: components, to: Date())

        components.year = 0
        let maxDate = Calendar.current.date(byAdding: components, to: Date())

        picker.date = Calendar.current.date(byAdding: .year, value: -18, to: Date())!
        picker.minimumDate = minDate
        picker.maximumDate = maxDate
        
        picker.addTarget(self, action: #selector(dateValueChanged(_:)), for: .valueChanged)
        
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
        
        self.addTarget(self, action: #selector(dateOfBirthPickerPressed), for: .touchUpInside)
        
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
        
        title.setHeight(to: appearance.labelFont.lineHeight)
    }
    
    private func layoutTextField() {
        let toolbar = setupToolbar()
        self.textField.inputAccessoryView = toolbar
        
        textField.addTarget(self, action: #selector(dateOfBirthPickerPressed), for: .touchUpInside)
        
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
        if let datePicker = self.textField.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .long
            self.textField.text = dateformatter.string(from: datePicker.date)
        }
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
    private func dateValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none

        self.textField.text = dateFormatter.string(from: sender.date)
    }
    
    @objc
    private func dateOfBirthPickerPressed() {
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

extension DateOfBirthPicker {
    
    struct Configuration {
        let text: String
        let placeholder: String
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
            downArrowTintColor: AppConstants.Design.Color.Secondary.UnderlineLightGray,
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

extension DateOfBirthPicker: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        enableForegroundFonts()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        disableForegroundFonts()
    }
    
}
