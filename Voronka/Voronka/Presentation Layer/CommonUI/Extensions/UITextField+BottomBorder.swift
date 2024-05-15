//
//  UITextField+BottomBorder.swift
//  Voronka
//
//  Created by Danil Shvetsov on 31.01.2023.
//

import UIKit

extension UITextField {
    
    public func setBottomBorder(withColor color: UIColor, withWidth width: CGFloat) {
        self.borderStyle = UITextField.BorderStyle.none
        self.backgroundColor = UIColor.clear
        let width: CGFloat = width

        let borderLine = UIView(frame: CGRect(x: 0, y: self.frame.height + 2 * width, width: self.frame.width, height: width))
        borderLine.backgroundColor = color
        
        self.addSubview(borderLine)
    }

}
