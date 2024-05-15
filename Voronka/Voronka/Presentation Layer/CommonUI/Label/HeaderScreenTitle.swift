//
//  HeaderScreenTitle.swift
//  Voronka
//
//  Created by Danil Shvetsov on 04.02.2023.
//

import UIKit

final class HeaderScreenTitle: UILabel {
    
    private let configuration: Configuration
    private let appearance: Appearance
    
    init(configuration: Configuration, appearance: Appearance) {
        self.configuration = configuration
        self.appearance = appearance
        
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.text = configuration.text
        
        self.font = appearance.font
        self.textColor = appearance.textColor
        self.textAlignment = appearance.textAlignment
        self.numberOfLines = configuration.numberOfLines
    }
    
}

extension HeaderScreenTitle {
    
    struct Configuration {
        let text: String
        let numberOfLines: Int
    }
    
    struct Appearance {
        
        static let common = Appearance(
            font: AppConstants.Design.Font.Primary.bold(withSize: 20),
            textColor: AppConstants.Design.Color.Primary.White,
            textAlignment: .left
        )
        
        let font: UIFont
        let textColor: UIColor
        let textAlignment: NSTextAlignment
    }
}
