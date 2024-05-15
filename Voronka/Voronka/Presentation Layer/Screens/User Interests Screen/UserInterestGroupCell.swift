//
//  UserInterestGroupCell.swift
//  Voronka
//
//  Created by Danil Shvetsov on 09.02.2023.
//

import UIKit

final class UserInterestGroupCell: UICollectionViewCell {
    
    static let reuseIdentifier = "InterestGroupCell"
    
    // MARK: - Declaring components of cell.
    
    internal let label = UILabel()
    private let underlineView = UIView()
    
    override var isSelected: Bool {
            didSet {
                UIView.animate(withDuration: 0.4, delay: 0.1, animations: {}) { _ in
                    UIView.transition(with: self.label, duration: 0.3) {
                        self.label.textColor = self.isSelected ? AppConstants.Design.Color.Primary.White : AppConstants.Design.Color.GrayScale.Medium
                    }
                    UIView.transition(with: self.underlineView, duration: 0.2) {
                        self.underlineView.layer.opacity = self.isSelected ? 1 : 0
                    }
                }
            }
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        setupLabel()
        setupUnderlineView()
    }
    
    private func setupLabel() {
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.textColor = AppConstants.Design.Color.GrayScale.Medium
        label.font = AppConstants.Design.Font.Primary.bold(withSize: 14)
        label.numberOfLines = 1
        
        self.contentView.addSubview(label)
        label.pin(to: self, [.top, .left, .right])
    }
    
    private func setupUnderlineView() {
        underlineView.backgroundColor = AppConstants.Design.Color.Primary.Blue
        underlineView.layer.opacity = 0
        
        self.contentView.addSubview(underlineView)
        
        underlineView.pinTop(to: self.label.bottomAnchor)
        underlineView.pinLeft(to: self.label.leadingAnchor)
        underlineView.pinRight(to: self.label.trailingAnchor)
        underlineView.setHeight(to: 2)
    }
    
    public func configure(with viewModel: UserInterestGroupsViewModel) {
        label.text = viewModel.name
    }
}
