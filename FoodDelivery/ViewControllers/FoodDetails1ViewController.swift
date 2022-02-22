//
//  FoodDetails1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class FoodDetails1ViewController: DSViewController {
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        prefersLargeTitles = false
        title = "Product Info"
        update()
    }
    
    func update() {
        
        show(content: [
            productInfo(),
            mainIngredients(),
            information()
        ])
        
        showBottom(content: butomSection())
    }
}

// MARK: - Restaurant Info

extension FoodDetails1ViewController {
    
    // Restaurant info
    func productInfo() -> DSSection {
        
        var image = DSImageVM(image: UIImage.named("PD1"))
        image.height = .absolute(250)
        image.supplementaryItems = [likeButton()]
        
        let composer = DSTextComposer()
        
        // Title
        composer.add(type: .headlineWithSize(23), text: "Authentic Japanese Ramen", spacing: 7)
        
        // Rating and type
        composer.add(sfSymbol: "star.fill", tint: .custom(.systemYellow), spacing: 10)
        composer.add(type: .subheadlineWithSize(15), text: " 4.5   ", newLine: false)
        composer.add(sfSymbol: "clock.fill" ,newLine: false)
        composer.add(type: .subheadlineWithSize(15), text: " 30 min", newLine: false)
        
        // Price
        composer.add(price: DSPrice.random(min: 5, max: 20, discount: true), size: .extraLarge, spacing: 7)
        
        // Description
        composer.add(type: .subheadline, text: "Lorem ipsum et dolor sit amet, and consectetur eadipiscing elit. Ametmo magna the cursus yum dolor praesenta the  pulvinar tristique the food.", spacing: 20, lineSpacing: 5)
        
        let text = composer.textViewModel()
        
        return [image, DSSpaceVM(type: .custom(0)), text].list()
    }
    
    /// Like button
    /// - Returns: DSSupplementaryView
    func likeButton() -> DSSupplementaryView {
        
        // Text
        let composer = DSTextComposer()
        composer.add(sfSymbol: "heart.fill",
                     style: .medium,
                     tint: .custom(Int.random(in: 0...1) == 0 ? .red : .white))
        
        // Action
        var action = DSActionVM(composer: composer)
        
        // Handle did tap
        action.didTap { [unowned self] (_: DSActionVM) in
            self.dismiss()
        }
        
        // Supplementary view
        let supView = DSSupplementaryView(view: action,
                                          position: .rightTop,
                                          background: .lightBlur,
                                          insets: .small,
                                          offset: .interItemSpacing,
                                          cornerRadius: .custom(10))
        return supView
    }
}

// MARK: - Ingredients

extension FoodDetails1ViewController {
    
    func mainIngredients() -> DSSection {
        
        let images = [4,2,3,1,5].map { (index) -> DSViewModel in
            var image = DSImageVM(image: UIImage.named("I\(index)"))
            image.width = .absolute(40)
            image.height = .absolute(40)
            image.style.cornerStyle = .custom(5)
            return image
        }
        
        return images.gallery().headlineHeader("Main Ingredients")
    }
}

// MARK: - Info

extension FoodDetails1ViewController {
    
    // Product Info
    func information() -> DSSection {
        
        let kal = row(title: "1990 kal", image: "IconCalories")
        let gluten = row(title: "Free Gluten", image: "IconGluttenFree")
        let oragnic = row(title: "Organic", image: "IconOrganic")
        return [kal, gluten, oragnic].gallery().headlineHeader("Food Information")
    }
    
    /// Product Info
    /// - Parameters:
    ///   - title: String
    ///   - image: String
    /// - Returns: DSViewModel
    func row(title: String, image: String) -> DSViewModel {
        
        let composer = DSTextComposer(alignment: .center)
        composer.add(image: UIImage.named(image), size: CGSize(width: 17, height: 17))
        composer.add(type: .subheadline, text: " \(title)", newLine: false)
        
        var text = composer.textViewModel()
        text.style.displayStyle = .grouped(inSection: false)
        text.style.borderStyle = .custom(width: 1, color: UIColor.black.withAlphaComponent(0.1))
        text.width = .estimated(100)
        
        return text
    }
}


// MARK: - Ingredients

extension FoodDetails1ViewController {
    
    func butomSection() -> DSSection {
        let button = DSButtonVM(title: "Add to cart")
        return button.list()
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct FoodDetails1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: FoodDetails1ViewController())
            PreviewContainer(VC: nav, OrangeAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
