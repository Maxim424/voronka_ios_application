//
//  LabeledTextField.swift
//  Voronka
//
//  Created by Danil Shvetsov on 04.02.2023.
//

import UIKit

final class LabeledTextField: UIButton {
    
    internal lazy var title: UILabel = {
        let label = UILabel()
        
        label.text = config.titleText
        
        label.textColor = appearance.titleColor
        label.font = appearance.titleFont
        
        return label
    }()
    
    internal lazy var textField: UITextField = {
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
        
        return textField
    }()
    
    private lazy var underlineView: UIView = {
        let view = UIView()
        
        view.backgroundColor = appearance.underlineViewDefaultColor
        
        return view
    }()
    
    private let config: Configuration
    private let appearance: Appearance
    
    init(configuration: Configuration, appearance: Appearance) {
        self.config = configuration
        self.appearance = appearance
        
        super.init(frame: .zero)
        
        self.addTarget(self, action: #selector(labeledTextFieldPressed), for: .touchUpInside)
    
        [title, textField, underlineView].forEach({ addSubview($0) })
        layout()
    }
    
    private func layout() {
        [title, textField, underlineView].forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            title.heightAnchor.constraint(equalToConstant: appearance.titleFont.lineHeight),
            
            textField.topAnchor.constraint(equalTo: title.bottomAnchor, constant: appearance.titleBottomOffset),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: appearance.textFieldFont.lineHeight),
            
            underlineView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: appearance.underlineViewTopOffset),
            underlineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            underlineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            underlineView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            underlineView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func labeledTextFieldPressed() {
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
            UIView.transition(with: self.underlineView, duration: 0.17, options: .transitionCrossDissolve) {
                self.underlineView.backgroundColor = self.appearance.underlineViewSelectedColor
            }
            UIView.transition(with: self.title, duration: 0.17, options: .transitionCrossDissolve) {
                self.title.textColor = self.appearance.underlineViewSelectedColor
            }
        }
    }
    
    internal func disableForegroundFonts() {
        UIView.animate(withDuration: 0.17, delay: 0.04, animations: {}) { _ in
            UIView.transition(with: self.underlineView, duration: 0.17, options: .transitionCrossDissolve) {
                self.underlineView.backgroundColor = self.appearance.underlineViewDefaultColor
            }
            UIView.transition(with: self.title, duration: 0.17, options: .transitionCrossDissolve) {
                self.title.textColor = self.appearance.textFieldFontColor
            }
        }
    }
    
    internal func isTextFieldDataValid() -> Bool {
        return !(textField.text?.isEmpty ?? true)
    }
    
}
 
extension LabeledTextField {
    
    struct Configuration {
        let titleText: String
        let placeholder: String
    }
    
    struct Appearance {
        static let common = Appearance(
            titleFont: AppConstants.Design.Font.Primary.bold(withSize: 14),
            titleBottomOffset: 7,
            titleColor: AppConstants.Design.Color.Primary.White,
            
            textFieldFont: AppConstants.Design.Font.Secondary.regular(withSize: 15),
            textFieldFontColor: AppConstants.Design.Color.Primary.White,
            textFieldTintColor: AppConstants.Design.Color.Primary.Blue,
            
            placeholderColor: AppConstants.Design.Color.GrayScale.UltraLight,
            
            underlineViewDefaultColor: AppConstants.Design.Color.Secondary.UnderlineLightGray,
            underlineViewSelectedColor: AppConstants.Design.Color.Primary.Blue,
            underlineViewHeight: 0.5,
            underlineViewTopOffset: 5,
            
            restrictionColor: AppConstants.Design.Color.Primary.Red
        )
        
        let titleFont: UIFont
        let titleBottomOffset: CGFloat
        let titleColor: UIColor
        
        let textFieldFont: UIFont
        let textFieldFontColor: UIColor
        let textFieldTintColor: UIColor
        
        let placeholderColor: UIColor
        
        let underlineViewDefaultColor: UIColor
        let underlineViewSelectedColor: UIColor
        let underlineViewHeight: CGFloat
        let underlineViewTopOffset: CGFloat
        
        let restrictionColor: UIColor
    }
 
}

extension LabeledTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        enableForegroundFonts()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        disableForegroundFonts()
    }
    
}
