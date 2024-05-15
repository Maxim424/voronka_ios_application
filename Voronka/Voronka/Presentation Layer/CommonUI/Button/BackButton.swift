//
//  BackButton.swift
//  Voronka
//
//  Created by Danil Shvetsov on 05.02.2023.
//

import UIKit

final class BackButton: UIButton {
    
    private let appearance: Appearance
    
    init(appearance: Appearance) {
        self.appearance = appearance
        
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        
        self.setImage(appearance.buttonImage, for: .normal)
        self.tintColor = appearance.tintColor
        
        self.contentVerticalAlignment = .fill
        self.contentHorizontalAlignment = .fill
        
        self.setWidth(to: appearance.width)
        self.setHeight(to: appearance.height)
    }
    
}

extension BackButton {
    
    struct Appearance {
        static let common = Appearance(
            // Current image is available in iOS 14.0+.
            buttonImage: AppConstants.Design.Image.BackButton,
            
            tintColor: AppConstants.Design.Color.Secondary.Blue,
            
            width: 18,
            height: 24
        )
        
        let buttonImage: UIImage
        
        let tintColor: UIColor
        
        let width: CGFloat
        let height: CGFloat
    }
    
}
