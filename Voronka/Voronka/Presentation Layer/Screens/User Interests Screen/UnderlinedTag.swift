//
//  CategoriesTagList.swift
//  Voronka
//
//  Created by Ирлан Абушахманов on 20.04.2023.
//

import UIKit

import TagListView

extension TagView {
    private enum Constants {
        static let animationDuration: TimeInterval = 0.4
        static let animationDelay: TimeInterval = 0.1
        static let underlinedHeight: CGFloat = 2
        static let viewOffset: CGFloat = 5
    }

    func resetSelection() {
        isSelected = false
        underlinedView.backgroundColor = .clear
        textColor = AppConstants.Design.Color.GrayScale.Medium
    }

    private func configureUnderlineView() {
        guard underlinedView.superview == nil else { return }

        addSubview(underlinedView)
        underlinedView.pinTop(to: bottomAnchor)
        underlinedView.pinLeft(to: leadingAnchor, Int(Constants.viewOffset))
        underlinedView.pinRight(to: trailingAnchor, Int(Constants.viewOffset))
        underlinedView.setHeight(to: Constants.underlinedHeight)
    }

    func categoriesSelected() {
        configureUnderlineView()
        animateChanges {
            self.textColor = self.isSelected ? .white : AppConstants.Design.Color.GrayScale.Medium
            self.underlinedView.backgroundColor = self.isSelected ? AppConstants.Design.Color.Primary.Blue : .clear
        }
    }

    func interestSelected() {
        animateChanges {
            self.backgroundColor = self.isSelected ? AppConstants.Design.Color.Primary.Blue :
                                                     AppConstants.Design.Color.GrayScale.Medium
        }
    }

    private func animateChanges(_ changes: @escaping () -> Void) {
        UIView.animate(withDuration: Constants.animationDuration, delay: Constants.animationDelay, animations: changes)
    }
}

private let underlinedView = UIView()

