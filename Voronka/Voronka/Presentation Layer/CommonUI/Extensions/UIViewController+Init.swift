//
//  UIViewController+Init.swift
//  Voronka
//
//  Created by Danil Shvetsov on 14.02.2023.
//

import UIKit

extension UIViewController {
    
    convenience init(title: String, image: UIImage?) {
        self.init()
        
        tabBarItem.image = image
        navigationItem.title = title
    }
    
}
