//
//  Home1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class Home1ViewController: DSViewController {
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        update()
    }
    
    func update() {
        
        show(content: [userLocation(),
                       searchSection(),
                       productsGallery(),
                       categoriesSection(),
                       popularSection(),
                       restaurantsSection()])
    }
}

// MARK: - Categories

extension Home1ViewController {
    
    /// Categories
    /// - Returns: DSSection
    func categoriesSection() -> DSSection {
        
        let c1 = category(title: "Breakfast", subtitle: "30+ menu", imageName: "Category1")
        let c2 = category(title: "Salad Veggie", subtitle: "13+ menu", imageName: "Category2")
        let c3 = category(title: "Noodles", subtitle: "10+ menu", imageName: "Category3")
        let section = [c1, c2, c3].gallery()
        section.header = header(title: "All Categories")
        
        return section
    }
}

// MARK: - Popular

extension Home1ViewController {
    
    /// Popular
    /// - Returns: DSSection
    func popularSection() -> DSSection {
        
        let p1 = product(title: "Marinated Grilled Salmon", rating: "4.5", time: "30 min", discount: "-15%", imageName: "p3")
        let p2 = product(title: "Beef Sandwich", rating: "4.5", time: "30 min", discount: "-25%", imageName: "p2")
        let p3 = product(title: "Coco Strawberry Pancake", rating: "4.5", time: "30 min", discount: "-35%", imageName: "p1")
        
        let section = [p1, p3, p2].gallery()
        section.header = header(title: "Popular Products")

        return section
    }
    
    /// Popular
    /// - Parameters:
    ///   - title: String
    ///   - subtitle: String
    ///   - imageName: String
    /// - Returns: DSViewModel
    func product(title: String,
                 rating: String,
                 time: String,
                 discount: String,
                 imageName: String) -> DSViewModel {
        
        // Text
        let composer = productInfoComposer(title: title, rating: rating, prepareTime: time)
        
        // Action
        var action = composer.actionViewModel()
        action.topImage(image: UIImage.named(imageName),
                        height: .unknown)
        
        action.width = .fractional(0.5)
        action.height = .absolute(250)
        action.supplementaryItems = [discountLabel(title: discount)]
        
        return action
    }
    
    /// Discount label supplementary view
    /// - Parameter title: String
    /// - Returns: DSSupplementaryView
    func discountLabel(title: String) -> DSSupplementaryView {
        
        let label = DSLabelVM(.text(font: .headlineWithSize(13), color: .white),
                              text: title)
        
        let supView = DSSupplementaryView(view: label,
                                          position: .leftTop,
                                          background: .custom(appearance.brandColor),
                                          insets: .small,
                                          offset: .custom(.init(x: 0, y: 15)),
                                          cornerRadius: .custom(0))
        return supView
    }
}

// MARK: - Gallery

extension Home1ViewController {
    
    /// Products gallery
    /// - Returns: DSSection
    func productsGallery() -> DSSection {
        
        // Pasta
        var p1 = DSImageVM(image: UIImage.named("BannerPasta"),
                           height: .estimated(150))
        
        p1.supplementaryItems = [bannerText(title: "PASTA",
                                            subtitle: "DAY FESTIVAL",
                                            discount: "Get 25% off every pasta purchase")]
        
        // Sushi
        var p2 = DSImageVM(image: UIImage.named("BannerSushi"),
                           height: .estimated(150))
        
        p2.supplementaryItems = [bannerText(title: "SUSHI",
                                                subtitle: "DAY Festival",
                                                discount: "Get 35% off")]
        
        // Oranges
        var p3 = DSImageVM(image: UIImage.named("BannerOranges"),
                           height: .estimated(150))
        
        p3.supplementaryItems = [bannerText(title: "ORANGES",
                                                subtitle: "DAY Festival",
                                                discount: "Get 50% off")]
        
        let pageControl = DSPageControlVM(type: .viewModels([p1, p2, p3]))
        return pageControl.list().zeroLeftRightInset()
    }
    
    /// Banner text
    /// - Parameters:
    ///   - title: String
    ///   - subtitle: String
    ///   - discount: String
    /// - Returns: DSSupplementaryView
    func bannerText(title: String,
                    subtitle: String,
                    discount: String) -> DSSupplementaryView {
        
        let composer = DSTextComposer()
        composer.add(type: .text(font: .headlineWithSize(30), color: .brand), text: title)
        composer.add(type: .headlineWithSize(15), text: subtitle, spacing: 30)
        composer.add(type: .subheadline, text: discount)
        
        return composer.textViewModel().asSupplementary(position: .leftBottom, background: .clear, offset: .margins)
    }
}

// MARK: - Location

extension Home1ViewController {
    
    /// User Location
    /// - Returns: DSSection
    func userLocation() -> DSSection {
        
        let composer = DSTextComposer()
        composer.add(type: .subheadlineWithSize(15), text: "Your Location")
        composer.add(type: .headline, text: "2464 Royal Ln. Mesa")
        var action = composer.actionViewModel()
        
        action.rightButton(title: "Change", sfSymbolName: "location.circle.fill", style: .medium) {
            self.dismiss()
        }
        
        return action.list()
    }
}

// MARK: - Search

extension Home1ViewController {
    
    /// Search
    /// - Returns: DSSection
    func searchSection() -> DSSection {
        
        let searchTextField = DSTextFieldVM.search(placeholder: "What do you want to eat?")
        
        return searchTextField.list()
    }
}

// MARK: - Restaurants

extension Home1ViewController {
    
    /// Restaurants
    /// - Returns: DSSection
    func restaurantsSection() -> DSSection {
        
        let p1 = restaurant(title: "Right From Oven", subtitle: "Bread, Cake ⋅ $$", rating: "4.5", imageName: "Restaurant2")
        let p2 = restaurant(title: "Brown Coffee Shop", subtitle:  "Bread, Cake ⋅ $$", rating: "4.5", imageName: "Restaurant3")
        let p3 = restaurant(title: "Brown Bakery", subtitle: "Bread, Cake ⋅ $$", rating: "4.5", imageName: "Restaurant4")
        let p4 = restaurant(title: "Salad Factory", subtitle: "Bread, Cake ⋅ $$", rating: "4.5", imageName: "Restaurant1")
        
        let section = [p1, p2, p3, p4].list()
        section.header = header(title: "Nearby Restaurants")
        
        return section
    }
}

// MARK: - Header

extension Home1ViewController {
    
    /// Header view model
    /// - Parameter title: String
    /// - Returns: DSViewModel
    func header(title: String) -> DSViewModel {
        
        let composer = DSTextComposer()
        composer.add(type: .headline, text: title)
        var header = composer.actionViewModel()
        header.style.displayStyle = .default

        header.rightButton(title: "See All", sfSymbolName: "chevron.right", style: .medium) { [unowned self] in
            self.dismiss()
        }
        
        return header
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Home1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: Home1ViewController(), OrangeAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
