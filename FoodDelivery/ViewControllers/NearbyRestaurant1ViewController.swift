//
//  NearbyRestaurant1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class NearbyRestaurant1ViewController: DSViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        title = "Nearby Restaurants"
        update()
        
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchFood))
        navigationItem.rightBarButtonItems = [search]
    }
    
    @objc func searchFood() {
        self.pop()
    }
    
    func update() {
        
        show(content: [restaurantsSection()])
    }
}

// MARK: - Restaurants

extension NearbyRestaurant1ViewController {
    
    /// Restaurants
    /// - Returns: DSSection
    func restaurantsSection() -> DSSection {
        
        let p1 = restaurant(title: "Right From Oven", subtitle: "Bread, Cake ⋅ $$", rating: "4.5", imageName: "Restaurant2")
        
        let p2 = restaurant(title: "Brown Coffee Shop", subtitle:  "Bread, Cake ⋅ $$", rating: "4.5", imageName: "Restaurant3")
        let p3 = restaurant(title: "Brown Bakery", subtitle: "Bread, Cake ⋅ $$", rating: "4.5", imageName: "Restaurant4")
        let p4 = restaurant(title: "Salad Factory", subtitle: "Bread, Cake ⋅ $$", rating: "4.5", imageName: "Restaurant1")
        
        let section = [p1, p2, p3, p4].list()
        
        return section
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct NearbyRestaurant1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: NearbyRestaurant1ViewController(), OrangeAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
