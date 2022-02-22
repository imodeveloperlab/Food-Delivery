//
//  DSViewController+Helpers.swift
//  DSKit+FoodDelivery
//
//  Created by Borinschi Ivan on 15.04.2021.
//  Copyright © 2021 Borinschi Ivan. All rights reserved.
//

import Foundation
import DSKit
import UIKit

extension DSViewController {
    
    func spaceSection(space: CGFloat = 15) -> DSSection {
        
        var space = DSSpaceVM(type: .custom(space))
        space.style.colorStyle = .secondary
        let spaceSection = space.list().zeroLeftRightInset()
        return spaceSection
    }
    
    func textField(placeHolder: String, value: String? = nil) -> DSTextFieldVM {
        
        let textField = DSTextFieldVM(text: value, placeholder: placeHolder)
        textField.height = .absolute(48)
        return textField
    }
    
    
    func productInfoComposer(title: String,
                             rating: String,
                             prepareTime: String,
                             price: DSPrice = DSPrice.random(min: 5, max: 25)) -> DSTextComposer {
        
        // Text
        let composer = DSTextComposer()
        composer.add(type: .text(font: .headlineWithSize(15), color: .subheadline), text: title, spacing: 5)
        composer.add(sfSymbol: "star.fill", style: .small, tint: .custom(.systemYellow), spacing: 5)
        composer.add(type: .subheadlineWithSize(13), text: " \(rating)   ", newLine: false)
        composer.add(sfSymbol: "clock.fill", style: .small, tint: .subheadline, newLine: false)
        composer.add(type: .subheadlineWithSize(13), text: " \(prepareTime)", newLine: false)
        composer.add(price: DSPrice.random(min: 5, max: 25))
        
        return composer
    }
    
    /// Category
    /// - Parameters:
    ///   - title: String
    ///   - subtitle: String
    ///   - imageName: String
    /// - Returns: DSViewModel
    func category(title: String,
                  subtitle: String,
                  imageName: String) -> DSViewModel {
        
        // Text
        let composer = DSTextComposer()
        composer.add(type: .headlineWithSize(15), text: title)
        composer.add(type: .subheadlineWithSize(12), text: subtitle)
        composer.add(type: .subheadlineWithSize(12), text: "From ")
        composer.add(price: DSPrice.random(min: 5, max: 25, discount: false), newLine: false)
        
        // Action
        var action = composer.actionViewModel()
        action.topImage(image: UIImage.named(imageName),
                        height: .unknown,
                        contentMode: .scaleAspectFit)
        action.width = .absolute(160)
        action.height = .absolute(180)
        action.zeroSpaceToTopImage = true
        action.rightIcon(sfSymbolName: "chevron.right.square.fill", tintColor: .text(.brand))
        
        return action
    }
    
    /// Category Horizontal
    /// - Parameters:
    ///   - title: String
    ///   - subtitle: String
    ///   - imageName: String
    /// - Returns: DSViewModel
    func categoryHorizontal(title: String,
                            subtitle: String,
                            imageName: String) -> DSViewModel {
        
        // Text
        let composer = DSTextComposer()
        composer.add(type: .headlineWithSize(15), text: title)
        composer.add(type: .subheadlineWithSize(12), text: subtitle)
        composer.add(type: .subheadlineWithSize(12), text: "From ")
        composer.add(price: DSPrice.random(min: 5, max: 25, discount: false), newLine: false)
        
        // Action
        var action = composer.actionViewModel()
        action.leftImage(image: UIImage.named(imageName), size: .size(.init(width: 60, height: 60)), contentMode: .scaleAspectFit)
        action.rightIcon(sfSymbolName: "chevron.right.square.fill", tintColor: .text(.brand))
        
        return action
    }
    
    /// Restaurant
    /// - Parameters:
    ///   - title: String
    ///   - subtitle: String
    ///   - rating: String
    ///   - imageName: String
    /// - Returns: DSViewModel
    func restaurant(title: String,
                    subtitle: String,
                    rating: String,
                    imageName: String) -> DSViewModel {
        
        // Text
        let composer = DSTextComposer()
        composer.add(type: .headline, text: "\(title) ")
        composer.add(sfSymbol: "star.fill", style: .small, tint: .custom(.systemYellow), newLine: false)
        composer.add(type: .subheadline, text: " \(rating)", newLine: false)
        composer.add(type: .subheadline, text: subtitle)
        
        // Action
        var action = composer.actionViewModel()
        action.topImage(image: UIImage.named(imageName),
                        height: .unknown)
        
        action.height = .absolute(200)
        action.rightIcon(sfSymbolName: "chevron.right.square.fill", tintColor: .text(.brand))
        action.supplementaryItems = [distanceLabel(title: "1.\(Int.random(in: 1...9)) km")]
        
        return action
    }
    
    /// Distance label supplementary view
    /// - Parameter title: String
    /// - Returns: DSSupplementaryView
    func distanceLabel(title: String) -> DSSupplementaryView {
        
        let label = DSLabelVM(.text(font: .headlineWithSize(11), color: .black),
                              text: title)
        
        let supView = DSSupplementaryView(view: label,
                                          position: .leftBottom,
                                          background: .secondary,
                                          insets: .small,
                                          offset: .custom(.init(x: 10, y: 75)),
                                          cornerRadius: .custom(5))
        return supView
    }
    
    /// Message banner section
    /// - Parameters:
    ///   - text: String
    ///   - icon: String
    /// - Returns: DSSection
    func messageBannerSection(text: String, icon: String) -> DSSection {
        
        // Composer
        let composer = DSTextComposer()
        composer.add(type: .text(font: .subheadlineWithSize(15), color: .custom(UIColor(0x0095BD))),
                     text: text,
                     newLine: false)
        
        // Model
        var model = composer.textViewModel()
        
        // Image
        var image = DSImageVM(imageValue: .sfSymbol(name: icon, style: .large), displayStyle: .default, contentMode: .scaleAspectFit)
        image.tintColor = .custom(UIColor(0x00BAE9))
        image.width = .absolute(20)
        image.height = .absolute(20)
        
        model.leftSideView = DSSideView(view: image)
        model.style.displayStyle = .grouped(inSection: false)
        
        // Custom colors
        var colors = DSAppearance.shared.main.secondaryView
        colors.background = UIColor(0xE0FAFF)
        model.style.colorStyle = .custom(colors)
        
        return model.list()
    }
}
