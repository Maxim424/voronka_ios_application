//
//  UserInterestsViewControllerConstraints.swift
//  Voronka
//
//  Created by Ирлан Абушахманов on 19.04.2023.
//

import Foundation
import UIKit

extension UserInterestsViewController {
    internal func setupConstraints() {
        tellAboutInterestsLabelConstraints()
        endButtonConstraints()
        underlinedViewsConstraints()
        categoriesTagListConstraints()
        toSelectTagListConstraints()
        
        chosenScrollConstraints()
        chosenTagListConstraints()
        
        youHaveChosenLabelConstraints()
        setupDropTagsButtonPosition()
        
    }
    
    private func tellAboutInterestsLabelConstraints() {
        view.addSubview(tellAboutInterestsLabel)
        
        tellAboutInterestsLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 10)
        tellAboutInterestsLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 32)
        tellAboutInterestsLabel.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, 32)
    }
    
    private func categoriesTagListConstraints() {
        view.addSubview(categoriesTagList)
        
        categoriesTagList.pinTop(to: tellAboutInterestsLabel.bottomAnchor, 16)
        categoriesTagList.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 25)
        categoriesTagList.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, 25)
    }
    
    private func endButtonConstraints() {
        view.addSubview(endButton)
        
        endButton.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, 10)
        endButton.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 16)
        endButton.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, 16)
    }
    
    private func underlinedViewsConstraints() {
        view.addSubview(underlinedViews)
        
        underlinedViews.pinBottom(to: endButton.topAnchor, 22)
        underlinedViews.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 32)
        underlinedViews.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, 32)
    }
    
    private func toSelectTagListConstraints() {
        view.addSubview(toSelectTagList)
        
        toSelectTagList.pinTop(to: categoriesTagList.bottomAnchor, 26)
        toSelectTagList.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 32)
        toSelectTagList.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, 32)
    }
    
    private func youHaveChosenLabelConstraints() {
        view.addSubview(youHaveChosenLabel)
                
        youHaveChosenLabel.pinBottom(to: chosenScroll.topAnchor, 16)
        youHaveChosenLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 16)
        
        youHaveChosenLabel.setHeight(to: 20)
    }
    
    private func chosenScrollConstraints() {
        view.addSubview(chosenScroll)
        
        chosenScroll.setHeight(to: Int(view.safeAreaLayoutGuide.layoutFrame.height) / 7)
        chosenScroll.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 16)
        chosenScroll.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, 16)
        chosenScroll.pinBottom(to: underlinedViews.topAnchor, 20)
        
        chosenScroll.contentSize = CGSizeMake(view.frame.size.width, .infinity)
    }
    
    private func chosenTagListConstraints() {
        chosenTagList.translatesAutoresizingMaskIntoConstraints = false
        chosenScroll.addSubview(chosenTagList)

        NSLayoutConstraint.activate([
            chosenTagList.topAnchor.constraint(equalTo: chosenScroll.topAnchor),
            chosenTagList.bottomAnchor.constraint(equalTo: chosenScroll.bottomAnchor),
            chosenTagList.leadingAnchor.constraint(equalTo: chosenScroll.leadingAnchor),
            chosenTagList.trailingAnchor.constraint(equalTo: chosenScroll.trailingAnchor),
            chosenTagList.widthAnchor.constraint(equalTo: chosenScroll.widthAnchor)
        ])
    }
    
    private func setupDropTagsButtonPosition() {
        view.addSubview(dropTagsButton)
        
        dropTagsButton.pinBottom(to: chosenScroll.topAnchor, 16)
        dropTagsButton.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, 16)
        
        dropTagsButton.setHeight(to: 20)
    }
}
