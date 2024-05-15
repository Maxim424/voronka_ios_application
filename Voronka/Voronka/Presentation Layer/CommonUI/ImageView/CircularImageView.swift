//
//  CircularImageView.swift
//  Voronka
//
//  Created by Danil Shvetsov on 22.11.2022.
//

import UIKit

final class CircularImageView: UIImageView {
    
    init(frame: CGRect, borderWidth: CGFloat, borderColor: CGColor) {
        super.init(frame: frame)
        
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
        self.clipsToBounds = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2
        self.clipsToBounds = true
    }
}
