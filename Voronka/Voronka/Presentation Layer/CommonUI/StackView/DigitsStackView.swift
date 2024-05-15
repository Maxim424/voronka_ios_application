//
//  DigitsStackView.swift
//  Voronka
//
//  Created by Danil Shvetsov on 05.02.2023.
//

import UIKit

final class DigitsStackView: UIStackView {
    
    internal var digits = [DigitTextField]()
    
    internal let callback: () -> Void
    internal let configuration: Configuration
    internal let appearance: Appearance
    
    init(configuration: Configuration, appearance: Appearance, callback:  @escaping () -> Void) {
        self.configuration = configuration
        self.appearance = appearance
        self.callback = callback
        
        super.init(frame: .zero)
        
        setupUI()
        setupDigits()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        self.distribution = .fillEqually
        self.spacing = appearance.spacing
    }
    
    private func setupDigits() {
        for i in 0..<configuration.digitsAmount {
            let textField = DigitTextField()
            textField.backgroundColor = appearance.textFieldDefaultBackgroundColor
            
            textField.layer.borderColor = appearance.textFieldDefaultBorderColor.cgColor
            textField.layer.borderWidth = appearance.textFieldBorderWidth
            textField.layer.cornerRadius = appearance.cornerRadius
            textField.layer.masksToBounds = true
            
            textField.textColor = appearance.textColor
            textField.tintColor = appearance.tintColor
            textField.font = appearance.font
            textField.textAlignment = .center
            
            textField.keyboardType = .asciiCapableNumberPad
            
            if i != 0 {
                textField.previousTF = digits[i - 1]
            }
            
            textField.delegate = self
            
            digits.append(textField)
            self.addArrangedSubview(textField)
        }
    }
    
    var getEnteredAuthCode: String {
        let digitsArray = digits.map{ $0.text }.compactMap { $0 }
        return digitsArray.reduce(emptyString, +)
    }
}

extension DigitsStackView {
    
    struct Configuration {
        let digitsAmount: Int
    }
    
    struct Appearance {
        static let common = Appearance(
            spacing: 8,
            
            textFieldDefaultBackgroundColor: AppConstants.Design.Color.GrayScale.Dark,
            
            textFieldDefaultBorderColor: AppConstants.Design.Color.Secondary.BorderWhite,
            textFieldDigitedBorderColor: AppConstants.Design.Color.Primary.Blue,
            
            textFieldBorderWidth: 0.6,
            
            textColor: AppConstants.Design.Color.Primary.White,
            
            font: AppConstants.Design.Font.Primary.bold(withSize: 34),
            
            cornerRadius: 7,
            
            tintColor: AppConstants.Design.Color.Primary.Blue,
            
            errorBackgroundColor: AppConstants.Design.Color.Primary.Red,
            successBackgroundColor: AppConstants.Design.Color.Primary.Green
        )
        
        let spacing: CGFloat
        
        let textFieldDefaultBackgroundColor: UIColor
        
        let textFieldDefaultBorderColor: UIColor
        let textFieldDigitedBorderColor: UIColor
        
        let textFieldBorderWidth: CGFloat
        
        let textColor: UIColor
        
        let font: UIFont
        
        let cornerRadius: CGFloat
        
        let tintColor: UIColor
        
        let errorBackgroundColor: UIColor
        let successBackgroundColor: UIColor
    }
    
}

extension DigitsStackView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField == digits[5] && self.getEnteredAuthCode.count == 6 {
            textField.text = string
            callback()
            return false
        }
        
        if (textField.text?.count)! < 1 && string.count > 0 {
            for i in 0..<digits.count - 1 {
                if digits[i] == textField {
                    digits[i + 1].becomeFirstResponder()
                }
            }
            textField.text = string
            callback()
            return false
            
        } else if (textField.text?.count)! >= 1 && string.count == 0 {
            textField.text = ""
            callback()
            return false
            
        } else if (textField.text?.count)! >= 1 {
            for i in 0..<digits.count - 1 {
                if digits[i] == textField {
                    digits[i + 1].becomeFirstResponder()
                    digits[i + 1].text = string
                }
            }
            callback()
            return false
            
        } else if string.isEmpty {
            textField.deleteBackward()
            callback()
            return false
        }
        return true
    }
    
}

private let emptyString = ""
