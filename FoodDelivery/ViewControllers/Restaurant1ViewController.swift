//
//  Restaurant1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class Restaurant1ViewController: DSViewController {
    
    var selectedFilter: String = "All Menu"
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        prefersLargeTitles = false
        title = "Details"
        
        // Search
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchProducts))
        
        navigationItem.rightBarButtonItems = [search]
        
        update()
    }
    
    @objc func searchProducts() {
        self.pop()
    }
    
    func update() {
        
        show(content: [
                restaurantInfo(),
                popularSection(),
                filtersSection(),
                filtredMenuSection()])
    }
}


// MARK: - Restaurant Info

extension Restaurant1ViewController {
    
    func restaurantInfo() -> DSSection {
        
        let composer = DSTextComposer()
        composer.add(type: .text(font: .headlineWithSize(20), color: .white), text: "Express Ramen Shop  ", spacing: 5)
        composer.add(badge: "#1", type: .text(font: .headlineWithSize(14), color: .white), backgroundColor: UIColor(0x00BAE9), cornerRadius: 5, newLine: false)
        composer.add(sfSymbol: "star.fill", style: .small, tint: .custom(.systemYellow), spacing: 10)
        composer.add(type: .text(font: .headlineWithSize(13), color: .white), text: " 4.6", newLine: false)
        composer.add(type: .text(font: .subheadlineWithSize(13), color: .white), text: " (678)", newLine: false)
        composer.add(type: .text(font: .headlineWithSize(13), color: .white), text: " Bread, Cacke $$", newLine: false)
        composer.add(badge: "Pickup", type: .text(font: .subheadline, color: .white), backgroundColor: .black, cornerRadius: 5)
        composer.add(type: .body, text: " ", newLine: false)
        composer.add(badge: "Free Delivery", type: .text(font: .subheadline, color: .white), backgroundColor: .black, cornerRadius: 5, newLine: false)
        
        var card = DSCardVM(composer: composer,
                            backgroundImage: .image(image: UIImage.named("R1")))
                
        return card.list()
    }
}


// MARK: - Filters

extension Restaurant1ViewController {
    
    /// Products gallery
    /// - Returns: DSSection
    func filtersSection() -> DSSection {
        
        let filters = ["All Menu", "Breakfast", "Lunch", "Beverage"]
        
        let viewModels = filters.map { (filter) -> DSViewModel in
            filterModel(title: filter)
        }
        
        let section = viewModels.gallery().headlineHeader("Right From Oven's Menu", size: 20)
        return section
    }
    
    /// Product
    /// - Parameters:
    ///   - title: String
    ///   - count: Int
    /// - Returns: DSViewModel
    func filterModel(title: String) -> DSViewModel {
        
        // Is selected
        let selected = title == self.selectedFilter
        
        // Text
        let composer = DSTextComposer(alignment: .center)
        composer.add(type: .headlineWithSize(14), text: title)
        
        // Action
        var filter = composer.actionViewModel()
        
        filter.height = .absolute(35)
        
        // Selected style
        if selected {
            
            // Create a copy of colors from secondaryView colors
            var colors = DSAppearance.shared.main.secondaryView
            
            // Change the colors
            colors.background = colors.button.background
            colors.text.headline = colors.button.title
            colors.text.subheadline = colors.button.title
            
            // Set custom colors to filter
            filter.style.colorStyle = .custom(colors)
        }
        
        filter.width = .estimated(100)
        filter.style.displayStyle = .grouped(inSection: false)
        
        // Handle did tap
        filter.didTap { [unowned self] (_: DSActionVM) in
            self.selectedFilter = title
            self.update()
        }
        
        return filter
    }
}

// MARK: - Popular

extension Restaurant1ViewController {
    
    /// Popular
    /// - Returns: DSSection
    func popularSection() -> DSSection {
        
        let p1 = product(title: "Authentic Japanese Ramen", rating: "4.5", time: "30 min", imageName: "RD1")
        let p2 = product(title: "Mushroom & Nori Noodle", rating: "4.1", time: "30 min", discount: "-25%" , imageName: "RD2")
        let p3 = product(title: "Chicken Peanut Noodle", rating: "4.2", time: "30 min", discount: "-15%", imageName: "RD3")
        let p4 = product(title: "Spicy Chicken Noodle", rating: "4.9", time: "30 min", imageName: "RD4")

        let section = [p1, p2, p3, p4].grid()
        section.headlineHeader("Popular Menu", size: 20)
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
                 discount: String? = nil,
                 imageName: String) -> DSViewModel {
        
        // Text
        let composer = productInfoComposer(title: title, rating: rating, prepareTime: time)
        
        // Action
        var action = composer.actionViewModel()
        action.topImage(image: UIImage.named(imageName),
                        height: .unknown)
        
        action.width = .absolute(160)
        action.height = .absolute(250)
        
        if let discount = discount {
            action.supplementaryItems = [label(title: discount)]
        }
        
        return action
    }
    
    /// Label supplementary view
    /// - Parameter title: String
    /// - Returns: DSSupplementaryView
    func label(title: String) -> DSSupplementaryView {
        
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

// MARK: - Menu

extension Restaurant1ViewController {
    
    /// Popular
    /// - Returns: DSSection
    func filtredMenuSection() -> DSSection {
        
        let p1 = popularProduct(title: "Original Ramen", rating: "4.5", time: "30 min", discount: "-25%", imageName: "RD5")
        
        let p2 = popularProduct(title: "Noodle with Chicken Curry Soup", rating: "4.5", time: "30 min", discount: "-25%", imageName: "RD6")
        let p3 = popularProduct(title: "Kwiteau with Chicken Slices", rating: "4.5", time: "30 min", discount: "-25%", imageName: "RD7")
        
        let section = [p1, p2, p3].list()
        
        return section
    }
    
    /// Popular
    /// - Parameters:
    ///   - title: String
    ///   - subtitle: String
    ///   - imageName: String
    /// - Returns: DSViewModel
    func popularProduct(title: String,
                         rating: String,
                         time: String,
                         discount: String,
                         imageName: String) -> DSViewModel {
        
        // Text
        let composer = productInfoComposer(title: title, rating: rating, prepareTime: time)
        
        // Action
        var action = composer.actionViewModel()
        action.leftImage(image: UIImage.named(imageName), size: .size(CGSize(width: 100, height: 80)))
        
        return action
    }
}


// MARK: - SwiftUI Preview

import SwiftUI

struct Restaurant1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: Restaurant1ViewController())
            PreviewContainer(VC: nav, OrangeAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
