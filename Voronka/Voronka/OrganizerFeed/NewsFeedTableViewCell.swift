//
//  NewsFeedTableViewCell.swift
//  Voronka
//
//  Created by Danil Shvetsov on 25.01.2023.
//

import UIKit

final class NewsFeedTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "NewsFeedTableViewCell"
    
    // MARK: - Declaration of all components in cell.
    
    
    
    // MARK: - Constructors.
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.contentView.backgroundColor = UIColor(rgb: 0x1D1D1D)
        
        setupView()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View setup.
    
    private func setupView() {
        
    }
    
}
