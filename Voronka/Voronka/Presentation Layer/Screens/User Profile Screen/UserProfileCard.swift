//
//  UserProfileCard.swift
//  Voronka
//
//  Created by Максим Кузнецов on 24.11.2022.
//

import UIKit

// MARK: - Profile card class.

final class UserProfileCard: UIView {
    
    // MARK: - Definitions of all components in profile card.
    
    public var profileImage = UIImageView()
    public var addButton = UIButton(type: .custom)
    public var image = UIImage()
    
    // MARK: - Constructors.
    
    init() {
        super.init(frame: .zero)
        setWidth(to: Constants.Paddings.ProfileImage.width)
        setHeight(to: Constants.Paddings.ProfileImage.height)
        setupView()
    }
        
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View setup.
    
    private func setupView() {
        setupProfileImage(imageName: "vorona")
//        setupAddButton()
    }
    
    // MARK: - Profile image setup.
    
    internal func setupProfileImage(imageName: String) {
        profileImage = UIImageView(image: image)
        profileImage.setHeight(to: Constants.Paddings.ProfileImage.height)
        profileImage.setWidth(to: Constants.Paddings.ProfileImage.width)
        profileImage.layer.cornerRadius = Constants.Paddings.ProfileImage.cornerRadius
        profileImage.clipsToBounds = true
        self.addSubview(profileImage)
        profileImage.pinCenter(to: self)
        profileImage.backgroundColor = Constants.Colors.ProfileImage.backgroundColor
    }
    
    // MARK: - Add button setup.
    
    private func setupAddButton() {
        addButton.setHeight(to: Constants.Paddings.AddButton.height)
        addButton.setWidth(to: Constants.Paddings.AddButton.width)
        self.addSubview(addButton)
        addButton.setTitle("+", for: .normal)
        addButton.titleLabel?.font = Constants.Fonts.AddButton.text
        addButton.titleLabel?.textColor = Constants.Colors.AddButton.textColor
        addButton.backgroundColor = Constants.Colors.AddButton.backgroundColor
        addButton.pinBottom(to: self)
        addButton.pinRight(to: self)
        addButton.layer.cornerRadius = Constants.Paddings.AddButton.cornerRadius
        addButton.clipsToBounds = true
    }
}

// MARK: - Constants.

extension UserProfileCard {
    private enum Constants {
        
        // MARK: - Paddings of all components.
        
        fileprivate enum Paddings {
            fileprivate enum ProfileImage {
                static let height: Int = 77
                static let width: Int = 77
                static let cornerRadius: CGFloat = 38.5
            }
            
            fileprivate enum AddButton {
                static let height: Int = 22
                static let width: Int = 22
                static let cornerRadius: CGFloat = 11
            }
        }
        
        // MARK: - Colors of all components.
        
        fileprivate enum Colors {
            fileprivate enum ProfileImage {
                static let backgroundColor: UIColor = .white
            }
            
            fileprivate enum AddButton {
                static let backgroundColor: UIColor = .systemBlue
                static let textColor: UIColor = .white
            }
        }
        
        // MARK: - Fonts of all components.
        
        fileprivate enum Fonts {
            fileprivate enum AddButton {
                static let text = UIFont.systemFont(ofSize: 15, weight: .bold)
            }
        }
    }
}
