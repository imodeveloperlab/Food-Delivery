//
//  Categories1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class Categories1ViewController: DSViewController {
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Categories"

        update()
        
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchFood))
        
        navigationItem.rightBarButtonItems = [search]
    }
    
    @objc func searchFood() {
        self.pop()
    }
    
    func update() {
        
        show(content: [categoriesSection()])
    }
}

// MARK: - Categories

extension Categories1ViewController {
    
    /// Categories
    /// - Returns: DSSection
    func categoriesSection() -> DSSection {
        
        let c1 = category(title: "Breakfast", subtitle: "30+ menu", imageName: "Category1")
        let c2 = category(title: "Salad Veggie", subtitle: "13+ menu", imageName: "Category2")
        let c3 = category(title: "Noodles", subtitle: "10+ menu", imageName: "Category3")
        let c4 = category(title: "Chicken Dishes", subtitle: "10+ menu", imageName: "Category11")
        let c5 = category(title: "Egg Dishes", subtitle: "5+ menu", imageName: "Category8")
        let c6 = category(title: "Seafood", subtitle: "5+ menu", imageName: "Category4")
        let c7 = category(title: "Pizza", subtitle: "5+ menu", imageName: "Category7")
        let c8 = category(title: "Pasta", subtitle: "10+ menu", imageName: "Category10")
        
        let section = [c1, c2, c3, c4, c5, c6, c7, c8].grid()
        
        return section
    }
    
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Categories1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: Categories1ViewController(), OrangeAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
