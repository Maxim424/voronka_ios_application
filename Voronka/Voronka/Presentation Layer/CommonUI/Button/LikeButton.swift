//
//  LikeButton.swift
//  Voronka
//
//  Created by Максим Кузнецов on 19.04.2023.
//

import UIKit

final class LikeButton: UIButton {
    
    // MARK: - Properties.
    
    private var likeImageView = UIImageView()
    private var likeLabel = UILabel()
    private var isLiked = false
    private var likeValue = 0
    
    // MARK: - Constructors.
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup views.
    
    private func setupView() {
        self.addSubview(likeImageView)
        likeImageView.pinTop(to: self, 8)
        likeImageView.pinCenterX(to: self)
        
        self.addSubview(likeLabel)
        likeLabel.pinTop(to: likeImageView.bottomAnchor, 5)
        likeLabel.pinCenterX(to: self)
        likeLabel.font = AppConstants.Design.Font.Secondary.medium(withSize: 14)
        likeLabel.textColor = AppConstants.Design.Color.Secondary.White
    }
    
    // MARK: - switchLiked function.
    
    public func switchLiked() {
        setLiked(value: !isLiked)
        if isLiked {
            setLikeValue(value: likeValue + 1)
        } else {
            setLikeValue(value: likeValue - 1)
        }
    }
    
    // MARK: - Getters and setters.
    
    public func setLikeValue(value: Int) {
        likeValue = value
        likeLabel.text = String(value)
    }
    
    public func getLikeValue() -> Int {
        return likeValue
    }
    
    public func setLiked(value: Bool) {
        isLiked = value
        if value {
            likeImageView.image = UIImage(named: "heart.fill1")
        } else {
            likeImageView.image = UIImage(named: "heart")
        }
    }
    
    public func getLiked() -> Bool {
        return self.isLiked
    }
}
