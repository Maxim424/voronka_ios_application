//
//  UserProfileTableViewCell.swift
//  Voronka
//
//  Created by Максим Кузнецов on 04.12.2022.
//

import UIKit

// MARK: - Constants.

extension UserProfileTableViewCell {
    private enum Constants {
        
        // MARK: - Paddings of all components.
        
        fileprivate enum Paddings {
            
            fileprivate enum ButtonImage {
                static let height: Int = 22
                static let leftPadding: Int = 25
            }
            
            fileprivate enum InfoStackView {
                static let leftPadding: Int = 25
            }
            
            fileprivate enum TitleLabel {
                static let rightPadding: CGFloat = 50
            }
        }
        
        // MARK: - Colors of all components.
        
        fileprivate enum Colors {
            
            fileprivate static let clear = UIColor(ciColor: .clear)
            
            fileprivate enum ButtonImageView {
                static let borderColor = UIColor.white.cgColor
            }
            
            fileprivate enum InfoStackView {
                
                fileprivate enum TitleLabel {
                    static let text = UIColor(ciColor: .white)
                }
            }
        }
        
        // MARK: - Fonts of all components.
        
        fileprivate enum Fonts {
            
            fileprivate enum InfoStackView {
                fileprivate enum TitleLabel {
                    static let text = AppConstants.Design.Font.Primary.regular(withSize: 16)
                }
            }
        }
    }
}

// MARK: - Cell class.
final class UserProfileTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "ProfileCell"
        
    // MARK: - Properties.
    
    private let buttonImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    
    // MARK: - Constructors.
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        setupView()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public function for text setup.
    
    public func setText(text: String) {
        titleLabel.text = text
    }
    
    // MARK: - Public function for image setup.
    
    public func setImage(imageName: String) {
        buttonImageView.image = UIImage(named: imageName)
    }
    
    // MARK: - View setup.
    
    private func setupView() {
        setupButtonImageView()
        setupTitleLabel()
    }
    
    // MARK: - setupButtonImageView function.
    
    private func setupButtonImageView() {
        contentView.addSubview(buttonImageView)
        buttonImageView.pinCenterY(to: contentView.centerYAnchor)
        buttonImageView.pinCenterX(to: contentView.leadingAnchor, Constants.Paddings.ButtonImage.leftPadding)
        buttonImageView.isUserInteractionEnabled = false
    }
    
    // MARK: - setupTitleLabel function.
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.pinCenterY(to: contentView.centerYAnchor)
        titleLabel.pinLeft(to: buttonImageView.centerXAnchor, Constants.Paddings.InfoStackView.leftPadding)
        titleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: self.frame.width - Constants.Paddings.TitleLabel.rightPadding).isActive = true
        titleLabel.isUserInteractionEnabled = false
        
        titleLabel.backgroundColor = Constants.Colors.clear
        titleLabel.textColor = Constants.Colors.InfoStackView.TitleLabel.text
        titleLabel.font = Constants.Fonts.InfoStackView.TitleLabel.text
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = .zero
        titleLabel.lineBreakMode = .byWordWrapping
    }
}

