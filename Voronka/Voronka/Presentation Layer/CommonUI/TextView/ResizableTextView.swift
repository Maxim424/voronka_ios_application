//
//  ResizableTextView.swift
//  Voronka
//
//  Created by Danil Shvetsov on 06.02.2023.
//

import UIKit

final class ResizableTextView: UIButton {
    
    private lazy var title: UILabel = {
        let label = UILabel()
        
        label.text = config.title
        label.textColor = appearance.labelTextColor
        label.textAlignment = .left
        label.font = appearance.labelFont
        label.numberOfLines = 1
        
        return label
    }()
    
    internal lazy var textView: UITextView = {
        let textView = UITextView()
        
        textView.textColor = appearance.textViewTextColor
        textView.textContainer.heightTracksTextView = true
        textView.isScrollEnabled = false
        textView.backgroundColor = appearance.textViewBackgroundColor
        textView.font = appearance.textViewFont
        textView.layer.cornerRadius = appearance.textViewCornerRadius
        textView.layer.borderWidth = appearance.textViewBorderWidth
        textView.layer.borderColor = appearance.textViewBorderColor.cgColor
        textView.layer.masksToBounds = true
        textView.showsHorizontalScrollIndicator = false
        textView.showsVerticalScrollIndicator = false
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 35)
        textView.delegate = self
        
        return textView
    }()
    
    private lazy var remainedCharactersLabel: UILabel = {
        let label = UILabel()
        
        label.text = "\(maxCharactersAmount)"
        label.textColor = appearance.textViewBorderColor
        label.textAlignment = .center
        label.font = appearance.textViewFont
        label.numberOfLines = 1
        
        return label
    }()
    
    private var heightConstraint: NSLayoutConstraint?
    
    private let maxCharactersAmount: Int = 200
    
    private let config: Configuration
    private let appearance: Appearance
    
    init(configuration: Configuration, appearance: Appearance) {
        self.config = configuration
        self.appearance = appearance
        
        super.init(frame: .zero)
        
        self.addTarget(self, action: #selector(resizableTextViewPressed(_:)), for: .touchUpInside)
        
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUI() {
        layoutTitle()
        layoutTextView()
        layoutRemainedChars()
    }

    private func layoutTitle() {
        self.addSubview(title)
        
        title.pinTop(to: self.topAnchor)
        title.pinLeft(to: self.leadingAnchor)
        title.pinRight(to: self.trailingAnchor)
        
        title.setHeight(to: appearance.labelFont.lineHeight)
    }
    
    private func layoutTextView() {
        self.addSubview(textView)
        
        textView.pinTop(to: title.bottomAnchor, appearance.textViewTopOffset)
        textView.pinLeft(to: self.leadingAnchor)
        textView.pinRight(to: self.trailingAnchor)
        
        textView.heightAnchor.constraint(greaterThanOrEqualToConstant: appearance.textViewFont.lineHeight * 4 + 20).isActive = true
    }
    
    private func layoutRemainedChars() {
        self.addSubview(remainedCharactersLabel)
        
        remainedCharactersLabel.pinTop(to: self.textView.topAnchor, appearance.remainedCharactersLabelTopOffset)
        remainedCharactersLabel.pinRight(to: self.trailingAnchor, appearance.remainedCharactersLabelTrailingOffset)
        
        remainedCharactersLabel.setWidth(to: appearance.remainedCharactersLabelWidth)
        remainedCharactersLabel.setHeight(to: appearance.labelFont.lineHeight)
    }
    
    @objc
    private func resizableTextViewPressed(_ sender: UIButton) {
        if textView.isFirstResponder {
            textView.resignFirstResponder()
            textViewDidEndEditing(textView)
        } else {
            textView.becomeFirstResponder()
            textViewDidBeginEditing(textView)
            if config.isBio {
                trackAmountOfEnteredCharacters()
            }
        }
    }
    
    internal func enableForegroundFonts() {
        UIView.animate(withDuration: 0.17, delay: 0.04, animations: {}) { _ in
            UIView.transition(with: self.textView, duration: 0.17, options: .transitionCrossDissolve) {
                self.textView.layer.borderColor = self.appearance.textViewSelectedBorderColor.cgColor
            }
            UIView.transition(with: self.title, duration: 0.17, options: .transitionCrossDissolve) {
                self.title.textColor = self.appearance.textViewSelectedBorderColor
            }
            UIView.transition(with: self.remainedCharactersLabel, duration: 0.17, options: .transitionCrossDissolve) {
                self.remainedCharactersLabel.textColor = self.appearance.textViewSelectedBorderColor
            }
        }
    }
    
    internal func disableForegroundFonts() {
        UIView.animate(withDuration: 0.17, delay: 0.04, animations: {}) { _ in
            UIView.transition(with: self.textView, duration: 0.17, options: .transitionCrossDissolve) {
                self.textView.layer.borderColor = self.appearance.textViewBorderColor.cgColor
            }
            UIView.transition(with: self.title, duration: 0.17, options: .transitionCrossDissolve) {
                self.title.textColor = self.appearance.labelTextColor
            }
            UIView.transition(with: self.remainedCharactersLabel, duration: 0.17, options: .transitionCrossDissolve) {
                self.remainedCharactersLabel.textColor = self.appearance.textViewBorderColor
            }
        }
    }
    
    private func updateTextFieldHeight() {
        let textViewWidth = textView.frame.width
        let textViewHeight = textView.sizeThatFits(.init(width: textViewWidth, height: .greatestFiniteMagnitude)).height
        
        if textViewHeight > config.maxHeight {
            if heightConstraint == nil {
                heightConstraint = textView.heightAnchor.constraint(equalToConstant: textViewHeight)
                heightConstraint?.isActive = true
                textView.textContainer.heightTracksTextView = false
                textView.isScrollEnabled = true
            }
        } else {
            heightConstraint?.isActive = false
            heightConstraint = nil
            textView.textContainer.heightTracksTextView = true
            textView.isScrollEnabled = false
        }
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    internal func trackAmountOfEnteredCharacters() {
        if textView.text.count > maxCharactersAmount {
            UIView.animate(withDuration: 0.17, delay: 0.04, animations: {}) { _ in
                UIView.transition(with: self.textView, duration: 0.17, options: .transitionCrossDissolve) {
                    self.textView.layer.borderColor = self.appearance.restictionColor.cgColor
                }
                UIView.transition(with: self.title, duration: 0.17, options: .transitionCrossDissolve) {
                    self.title.textColor = self.appearance.restictionColor
                }
                UIView.transition(with: self.remainedCharactersLabel, duration: 0.17, options: .transitionCrossDissolve) {
                    self.remainedCharactersLabel.textColor = self.appearance.restictionColor
                }
            }
        } else {
            UIView.animate(withDuration: 0.17, delay: 0.04, animations: {}) { _ in
                UIView.transition(with: self.textView, duration: 0.17, options: .transitionCrossDissolve) {
                    self.textView.layer.borderColor = self.appearance.textViewSelectedBorderColor.cgColor
                }
                UIView.transition(with: self.title, duration: 0.17, options: .transitionCrossDissolve) {
                    self.title.textColor = self.appearance.textViewSelectedBorderColor
                }
                UIView.transition(with: self.remainedCharactersLabel, duration: 0.17, options: .transitionCrossDissolve) {
                    self.remainedCharactersLabel.textColor = self.appearance.textViewSelectedBorderColor
                }
            }
        }
    }
    
    internal func isTextViewDataValid() -> Bool {
        return textView.text.count <= maxCharactersAmount
    }
    
}

extension ResizableTextView {
    
    struct Configuration {
        let title: String
        let maxHeight: CGFloat
        let isBio: Bool
    }
    
    struct Appearance {
        static let common = Appearance(
            labelTextColor: AppConstants.Design.Color.Primary.White,
            labelFont: AppConstants.Design.Font.Primary.bold(withSize: 14),
            
            textViewFont: AppConstants.Design.Font.Secondary.regular(withSize: 15),
            textViewTextColor: AppConstants.Design.Color.Primary.White,
            textViewBackgroundColor: .clear,
            textViewTopOffset: 7,
            textViewCornerRadius: 10,
            textViewBorderWidth: 0.5,
            textViewBorderColor: AppConstants.Design.Color.Secondary.UnderlineLightGray,
            textViewSelectedBorderColor: AppConstants.Design.Color.Primary.Blue,
            
            underlineViewDefaultColor: AppConstants.Design.Color.Secondary.UnderlineLightGray,
            underlineViewHeight: 0.5,
            
            restictionColor: AppConstants.Design.Color.Primary.Red,
            
            remainedCharactersLabelTopOffset: 10,
            remainedCharactersLabelTrailingOffset: 5,
            remainedCharactersLabelWidth: 30,
            
            placeholderColor: AppConstants.Design.Color.GrayScale.UltraLight
        )
        
        let labelTextColor: UIColor
        let labelFont: UIFont
        
        let textViewFont: UIFont
        let textViewTextColor: UIColor
        let textViewBackgroundColor: UIColor
        let textViewTopOffset: Int
        let textViewCornerRadius: CGFloat
        let textViewBorderWidth: CGFloat
        let textViewBorderColor: UIColor
        let textViewSelectedBorderColor: UIColor
        
        let underlineViewDefaultColor: UIColor
        let underlineViewHeight: CGFloat
        
        let restictionColor: UIColor
        
        let remainedCharactersLabelTopOffset: Int
        let remainedCharactersLabelTrailingOffset: Int
        let remainedCharactersLabelWidth: Int
        
        let placeholderColor: UIColor
    }
    
}

extension ResizableTextView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        enableForegroundFonts()
        if config.isBio {
            trackAmountOfEnteredCharacters()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if config.isBio {
            trackAmountOfEnteredCharacters()
        }
        
        disableForegroundFonts()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if config.isBio {
            trackAmountOfEnteredCharacters()
        }
        updateTextFieldHeight()
        
        remainedCharactersLabel.text = "\(maxCharactersAmount - textView.text.count)"
    }
    
}
