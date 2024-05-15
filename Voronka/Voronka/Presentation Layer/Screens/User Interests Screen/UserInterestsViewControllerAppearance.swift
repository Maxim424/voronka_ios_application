//
//  UserInterestsViewControllerAppearance.swift
//  Voronka
//
//  Created by Ирлан Абушахманов on 20.04.2023.
//

import UIKit

extension UserInterestsViewController {
    func setupAppearance() {
        setupCategoriesTagListAppearance()
        toSelectTagListAppearance()
        youHaveChosenLabelAppearance()
        chosenTagListAppearance()
        dropTagsButtonAppearance()
        dropTagsButtonAppearance()
        endButtonAppearance()
    }

    private func setupCategoriesTagListAppearance() {
        categoriesTagList.delegate = categoriesDelegate
        categoriesTagList.textFont = AppConstants.Design.Font.Primary.bold(withSize: 16)
        categoriesTagList.textColor = AppConstants.Design.Color.GrayScale.Medium
        categoriesTagList.tagBackgroundColor = .clear
    }
    
    private func toSelectTagListAppearance() {
        toSelectTagList.delegate = toSelectDelegate
        toSelectTagList.textFont = AppConstants.Design.Font.Primary.regular(withSize: 16)
        toSelectTagList.tagBackgroundColor = AppConstants.Design.Color.GrayScale.Medium
        toSelectTagList.marginX = 4
        toSelectTagList.marginY = 6
        toSelectTagList.paddingX = 10
        toSelectTagList.paddingY = 4
        toSelectTagList.cornerRadius = 12
    }
    
    private func youHaveChosenLabelAppearance() {
        youHaveChosenLabel.text = "Вы выбрали \(chosenInterests.count)/\(maxTagsAmount):"
        youHaveChosenLabel.textColor = AppConstants.Design.Color.Primary.White
        youHaveChosenLabel.textAlignment = .left
        youHaveChosenLabel.font = AppConstants.Design.Font.Primary.bold(withSize: 14)
    }
    
    private func chosenTagListAppearance() {
        chosenTagList.delegate = chosenDelegate
        chosenTagList.textFont = AppConstants.Design.Font.Primary.regular(withSize: 16)
        chosenTagList.tagBackgroundColor = AppConstants.Design.Color.Primary.Blue
        chosenTagList.marginX = 4
        chosenTagList.marginY = 6
        chosenTagList.paddingX = 10
        chosenTagList.paddingY = 4
        chosenTagList.cornerRadius = 12
    }
    
    private func dropTagsButtonAppearance() {
        var buttonConfiguration = UIButton.Configuration.plain()
        
        buttonConfiguration.baseForegroundColor = AppConstants.Design.Color.GrayScale.Medium
        buttonConfiguration.attributedTitle = AttributedString("сбросить теги", attributes: AttributeContainer(
            [
                NSAttributedString.Key.font : UIFont(name: "RFDewiExtended-Bold", size: 16)!
            ])
        )
        
        let symbolConfiguration = UIImage.SymbolConfiguration(scale: .medium)
        buttonConfiguration.image = AppConstants.Design.Image.BorderedCross.withConfiguration(symbolConfiguration)
        buttonConfiguration.imagePadding = 4
        
        dropTagsButton.configuration = buttonConfiguration
        dropTagsButton.semanticContentAttribute = .forceRightToLeft
        dropTagsButton.addTarget(self, action: #selector(deleteAllChose), for: .touchUpInside)
    }
    
    private func endButtonAppearance() {
        endButton.addTarget(self, action: #selector(endButtonPressed), for: .touchUpInside)
    }
}
