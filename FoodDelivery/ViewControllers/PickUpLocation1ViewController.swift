//
//  PickUpLocation1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class PickUpLocation1ViewController: DSViewController {
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        prefersLargeTitles = false
        title = "Pick Up"
        update()
    }
    
    func update() {
        
        show(content: [
                restaurantOnMap(),
                restaurantInfo(),
                pickUpSection(),
                spaceSection(space: 5),
                operatingHoursSection(),
                pickUpInformation()])
        
        showBottom(content: showOnTheMapButton())
    }
}

// MARK: - Restaurant Info

extension PickUpLocation1ViewController {
    
    // Process to payment button
    func showOnTheMapButton() -> DSViewModel {
        
        // Process to payment button
        let button = DSButtonVM(title: "Show on the map", icon: UIImage(systemName: "map.fill")) { btn in
            self.pop()
        }

        return button
    }
    
    /// Pickup time section
    /// - Returns: DSSection
    func pickUpSection() -> DSSection {
        
        let composer = DSTextComposer()
        composer.add(type: .subheadline, text: "You can pick up your order at:")
        composer.add(type: .headlineWithSize(14), text: "4235 Royal Messa Verde, Yumme Resturant")
        
        var model = composer.actionViewModel()
        model.style.displayStyle = .grouped(inSection: false)
        model.leftIcon(sfSymbolName: "mappin.and.ellipse")
        
        return [model].list().headlineHeader("Pick Up Details", size: 14)
    }
    
    // Restaurant on map
    func restaurantOnMap() -> DSSection {
        
        // Map
        let faker = DSFaker()
        let map = DSMapVM(coordinate: faker.address.coordinate)
        return map.list()
    }
}

// MARK: - Restaurant Info

extension PickUpLocation1ViewController {
    
    // Restaurant info
    func restaurantInfo() -> DSSection {
        
        let composer = DSTextComposer()
        
        // Title
        composer.add(type: .headlineWithSize(23), text: "Right From Oven ", spacing: 7)
        composer.add(badge: "#1", type: .text(font: .headlineWithSize(14), color: .white), backgroundColor: UIColor(0x00BAE9), cornerRadius: 5, newLine: false)
        
        // Rating and type
        composer.add(sfSymbol: "star.fill", tint: .custom(.systemYellow), spacing: 20)
        composer.add(type: .subheadline, text: " 4.6", newLine: false)
        composer.add(type: .subheadlineWithSize(13), text: " (678)", newLine: false)
        composer.add(type: .subheadline, text: " Bread, Cacke $$", newLine: false)
      
        return composer.textViewModel().list()
    }
    
    /// Operating hours section
    /// - Returns: DSSection
    func operatingHoursSection() -> DSSection {
        
        let today = row(day: "Tuesday", time: "10:00 - 15:00")
        let section = [today].list(separator: true)
        section.headlineHeader("Today Operating Hours")
        
        return section
    }
    
    func pickUpInformation() -> DSSection {
        
        let message = "Please show your QR Code within transaction checkout to pick up you order"
        return messageBannerSection(text: message, icon: "info.circle.fill")
    }
    
    /// Row
    /// - Parameters:
    ///   - day: String
    ///   - time: String?
    /// - Returns: DSViewModel
    func row(day: String, time: String? = nil) -> DSViewModel {
        
        // Label
        var label = DSLabelVM(.subheadlineWithSize(15), text: day)
        label.height = .absolute(20)
        
        // Time
        if let time = time {
            
            let composer = DSTextComposer(alignment: .right)
            composer.add(sfSymbol: "clock", style: .custom(size: 12, weight: .medium))
            composer.add(type: .subheadlineWithSize(14), text: " \(time)", newLine: false)
            var timeLabel = composer.textViewModel()
            timeLabel.width = .absolute(120)
            label.rightSideView = DSSideView(view: timeLabel)
            
        } else {
            
            let composer = DSTextComposer(alignment: .right)
            composer.add(type: .text(font: .headlineWithSize(14), color: .custom(.systemRed)), text: "Off Day", newLine: false)
            var timeLabel = composer.textViewModel()
            timeLabel.width = .absolute(120)
            label.rightSideView = DSSideView(view: timeLabel)
        }
        
        return label
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct PickUpLocation1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: PickUpLocation1ViewController())
            PreviewContainer(VC: nav, OrangeAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
