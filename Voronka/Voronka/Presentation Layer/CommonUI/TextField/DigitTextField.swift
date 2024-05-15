//
//  DigitTextField.swift
//  Voronka
//
//  Created by Danil Shvetsov on 14.02.2023.
//

import UIKit

final class DigitTextField: UITextField {
    
    internal weak var previousTF: DigitTextField?
    internal weak var nextTF: DigitTextField?
    
    override public func deleteBackward() {
        if self.text == "" {
            previousTF?.becomeFirstResponder()
            previousTF?.text = ""
            previousTF?.layer.borderColor = DigitsStackView.Appearance.common.textFieldDefaultBorderColor.cgColor
        }
        
        super.deleteBackward()
    }
}
