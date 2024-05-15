//
//  CategoriesTagList.swift
//  Voronka
//
//  Created by Ирлан Абушахманов on 20.04.2023.
//

import UIKit

import TagListView

extension TagView {
    func resetSelection() {
        isSelected = false
        underlinedView.backgroundColor = .clear
        textColor = AppConstants.Design.Color.GrayScale.Medium
    }
    
    private func underlineView() {
        addSubview(underlinedView)

        underlinedView.pinTop(to: bottomAnchor)
        underlinedView.pinLeft(to: leadingAnchor, viewOffset)
        underlinedView.pinRight(to: trailingAnchor, viewOffset)
        underlinedView.setHeight(to: 2)
    }

    func categoriesSelected() {
        underlineView()
        UIView.animate(withDuration: 0.4, delay: 0.1, animations: {}) { _ in
            UIView.transition(with: self, duration: 0.3) {
                self.textColor = self.isSelected ? .white : AppConstants.Design.Color.GrayScale.Medium
            }
            UIView.transition(with: self, duration: 0.2) {
                self.underlinedView.backgroundColor = self.isSelected ? AppConstants.Design.Color.Primary.Blue : .clear
            }
        }
    }
    
    func interestSelected() {
        UIView.animate(withDuration: 0.4, delay: 0.1, animations: {}) { _ in
            UIView.transition(with: self, duration: 0.2) {
                self.backgroundColor = self.isSelected ? AppConstants.Design.Color.Primary.Blue :
                                                         AppConstants.Design.Color.GrayScale.Medium
            }
        }
    }
    
}

private let viewOffset = 5

