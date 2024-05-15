//
//  UserAvatarPicker.swift
//  Voronka
//
//  Created by Danil Shvetsov on 05.02.2023.
//

import UIKit

final class UserAvatarPicker: UIButton {
    
    internal var image = CircularImageView(
        frame: .zero,
        borderWidth: 0,
        borderColor: UIColor.clear.cgColor
    )
    internal let picker = UIImagePickerController()
    internal let addAvatarButton = UIButton()
    
    private let config: Configuration
    private let appearance: Appearance
    
    init(configuration: Configuration, appearance: Appearance) {
        self.config = configuration
        self.appearance = appearance
        
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupImage()
        setupAddAvatarButton()
    }
    
    private func setupImage() {
        image = CircularImageView(
            frame: CGRect(x: 0, y: 0, width: config.width, height: config.height),
            borderWidth: 0,
            borderColor: UIColor.clear.cgColor
        )
        image.image = AppConstants.Design.Image.SampleAvatar

        self.addSubview(image)
        
        image.pinCenter(to: self)
        image.setHeight(to: config.height)
        image.setWidth(to: config.width)
    }
    
    private func setupAddAvatarButton() {
        addAvatarButton.setImage(appearance.addButtonImage, for: .normal)
        addAvatarButton.backgroundColor = appearance.addButtonBackgroundColor
        addAvatarButton.tintColor = appearance.addButtonTintColor
        addAvatarButton.layer.cornerRadius = appearance.addButtonCornerRadius
        addAvatarButton.isUserInteractionEnabled = false
        
        self.addSubview(addAvatarButton)
        
        addAvatarButton.pinTop(to: self.topAnchor, appearance.addButtonTopOffset)
        addAvatarButton.pinRight(to: self.centerXAnchor, -Int(config.width) / 2)

        addAvatarButton.setWidth(to: appearance.addButtonWidth)
        addAvatarButton.setHeight(to: appearance.addButtonHeight)
    }
    
}

extension UserAvatarPicker {
    
    struct Configuration {
        let width: CGFloat
        let height: CGFloat
    }
    
    struct Appearance {
        static let common = Appearance(
            addButtonImage: UIImage(systemName: "plus") ?? UIImage(),
            
            addButtonBackgroundColor: AppConstants.Design.Color.Primary.Blue,
            addButtonTintColor: AppConstants.Design.Color.Primary.White,
            
            addButtonCornerRadius: 11,
            addButtonTopOffset: 1,
            
            addButtonWidth: 21,
            addButtonHeight: 21
        )
        
        let addButtonImage: UIImage
        let addButtonBackgroundColor: UIColor
        let addButtonTintColor: UIColor
        let addButtonCornerRadius: CGFloat
        let addButtonTopOffset: Int
        let addButtonWidth: CGFloat
        let addButtonHeight: CGFloat
    }
    
}
