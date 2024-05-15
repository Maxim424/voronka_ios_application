//
//  UnderlinedViewsStack.swift
//  Voronka
//
//  Created by Danil Shvetsov on 04.02.2023.
//

import UIKit

final class UnderlinedViewsStack: UIStackView {
    
    private let configuration: Configuration
    private let appearance: Appearance
    
    init(configuration: Configuration, appearance: Appearance) {
        self.configuration = configuration
        self.appearance = appearance
        
        super.init(frame: .zero)
        
        layout()
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        for i in 0..<configuration.viewsAmount {
            let view = UIView()
            
            view.backgroundColor =
                configuration.viewsStates[i] == .unselected
                    ? appearance.defaultBackgroundColor
                    : appearance.selectedBackgroundColor
            view.layer.cornerRadius = appearance.cornerRadius
            view.layer.masksToBounds = true
            
            self.addArrangedSubview(view)
        }
    }
    
    private func layout() {
        self.distribution = .fillEqually
        self.spacing = appearance.viewsSpacing
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: appearance.height).isActive = true
    }
    
}

extension UnderlinedViewsStack {
    
    struct Configuration {
        let viewsAmount: Int
        let viewsStates: [ViewState]
    }
    
    struct Appearance {
        static let common = Appearance(
            defaultBackgroundColor: .black,
            selectedBackgroundColor: AppConstants.Design.Color.Primary.Blue,
            
            cornerRadius: 5,
            
            viewsSpacing: 20,
            
            height: 4
        )
        
        let defaultBackgroundColor: UIColor
        let selectedBackgroundColor: UIColor
        
        let cornerRadius: CGFloat
        
        let viewsSpacing: CGFloat
        
        let height: CGFloat
    }
    
}

extension UnderlinedViewsStack {
    enum ViewState {
        case unselected
        case selected
    }
}
