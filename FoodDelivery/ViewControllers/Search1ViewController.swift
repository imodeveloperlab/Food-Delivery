//
//  Search1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class Search1ViewController: DSViewController {
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Search"
        update()
    }
    
    // Call every time some data have changed
    func update() {
        showTop(content: searchTextFieldSection())
        show(content: recentSection(), categoriesSection())
    }
    
    @objc func openFilters() {
        self.dismiss()
    }
    
    @objc func openSort() {
        self.dismiss()
    }
}

// MARK: - Search

extension Search1ViewController {
    
    func searchTextFieldSection() -> DSSection {
        
        let textField = DSTextFieldVM.search(placeholder: "Search")
        return textField.list()
    }
}

// MARK: - Recent

extension Search1ViewController {
    
    /// Products gallery
    /// - Returns: DSSection
    func recentSection() -> DSSection {
        
        let searches = ["fried chicken", "japanese ramen", "Beachwear", "pizza mozzarella", "boba tea"]
        
        let models = searches.map { (search) -> DSViewModel in
            
            let composer = DSTextComposer()
            composer.add(type: .subheadlineWithSize(14), text: search)
            
            var text = composer.textViewModel()
            
            var icon = DSImageVM(imageValue: .sfSymbol(name: "clock.arrow.circlepath", style: .medium), contentMode: .scaleAspectFit)
            
            icon.width = .absolute(20)
            icon.height = .absolute(20)
            
            text.leftSideView = DSSideView(view: icon)
            text.height = .absolute(30)
            
            var button = DSButtonVM(sfSymbol: "xmark", type: .linkBlack)
            button.width = .absolute(15)
            button.height = .absolute(15)
            
            text.rightSideView = DSSideView(view: button)
            
            return text
        }
        
        let section = models.list()
        
        // Header
        var header = DSActionVM(title: "Search History")
        header.style.displayStyle = .default
        header.rightButton(title: "Clear") { [unowned self] in
            self.dismiss()
        }
        
        section.header = header
        
        return section
    }
    
    /// Categories
    /// - Returns: DSSection
    func categoriesSection() -> DSSection {
        
        let c1 = categoryHorizontal(title: "Breakfast", subtitle: "30+ menu", imageName: "Category1")
        let c2 = categoryHorizontal(title: "Salad Veggie", subtitle: "13+ menu", imageName: "Category2")
        let c3 = categoryHorizontal(title: "Noodles", subtitle: "10+ menu", imageName: "Category3")
        let c4 = categoryHorizontal(title: "Chicken Dishes", subtitle: "10+ menu", imageName: "Category11")
        let c5 = categoryHorizontal(title: "Egg Dishes", subtitle: "5+ menu", imageName: "Category8")
        let c6 = categoryHorizontal(title: "Seafood", subtitle: "5+ menu", imageName: "Category4")
        let c7 = categoryHorizontal(title: "Pizza", subtitle: "5+ menu", imageName: "Category7")
        let c8 = categoryHorizontal(title: "Pasta", subtitle: "10+ menu", imageName: "Category10")
        
        let section = [c1, c2, c3, c4, c5, c6, c7, c8].list().headlineHeader("Search By Category")
        
        return section
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Search1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: Search1ViewController())
            PreviewContainer(VC: nav, OrangeAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}

fileprivate let p1Image = URL(string: "https://images.pexels.com/photos/2529157/pexels-photo-2529157.jpeg?cs=srgb&dl=pexels-melvin-buezo-2529157.jpg&fm=jpg")
fileprivate let p2Image = URL(string: "https://images.pexels.com/photos/2529146/pexels-photo-2529146.jpeg?cs=srgb&dl=pexels-melvin-buezo-2529146.jpg&fm=jpg")
fileprivate let p3Image = URL(string: "https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg?cs=srgb&dl=pexels-melvin-buezo-2529148.jpg&fm=jpg")
