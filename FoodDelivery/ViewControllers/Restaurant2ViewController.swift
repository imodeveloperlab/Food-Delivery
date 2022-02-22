//
//  Restaurant2ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class Restaurant2ViewController: DSViewController {
    
    var selectedFilter: String = "All Menu"
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        prefersLargeTitles = false
        title = "Restaurant Info"        
        update()
    }
    
    func update() {
        
        show(content: [
                restaurantOnMap(),
                restaurantInfo(),
                DSSpaceVM().list().zeroTopBottomInset(),
                spaceSection(),
                operatingHoursSection()])
    }
}

// MARK: - Restaurant Info

extension Restaurant2ViewController {
    
    // Restaurant on map
    func restaurantOnMap() -> DSSection {
        
        // Map
        let faker = DSFaker()
        var map = DSMapVM(coordinate: faker.address.coordinate)

        // Button
        var button = DSButtonVM(sfSymbol: "location.fill", style: .medium, type: .cleanWithBorder) { btn in
            self.pop()
        }
        
        button.width = .absolute(40)
        button.height = .absolute(40)
        map.supplementaryItems = [button.asSupplementary(position: .rightBottom, insets: .insets(.zero), cornerRadius: .custom(5))]
        
        return map.list()
    }
}

// MARK: - Restaurant Info

extension Restaurant2ViewController {
    
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
        
        // Description
        composer.add(type: .subheadline, text: "Lorem ipsum et dolor sit amet, and consectetur eadipiscing elit. Ametmo magna the cursus yum dolor praesenta the  pulvinar tristique the food.", spacing: 20)
        
        // Address
        composer.add(type: .headline, text: "Detail Address", spacing: 5)
        composer.add(type: .subheadline, text: "3891 Ranchview Dr. Richardson, California 62639")
      
        return composer.textViewModel().list()
    }
    
    /// Operating hours section
    /// - Returns: DSSection
    func operatingHoursSection() -> DSSection {
        
        let monday = row(day: "Monday", time: "10:00 - 19:00")
        let tuesday = row(day: "Tuesday", time: "10:00 - 15:00")
        let wednesday = row(day: "Wednesday", time: "10:00 - 19:00")
        let thursday = row(day: "Thursday", time: "10:00 - 19:00")
        let friday = row(day: "Friday", time: "10:00 - 15:00")
        let saturday = row(day: "Saturday")
        let sunday = row(day: "Sunday")

        let section = [monday, tuesday, wednesday, thursday, friday, saturday, sunday].list(separator: true)
        section.headlineHeader("Operational Hours")
        
        return section
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
            composer.add(type: .subheadlineWithSize(14), text: "\(time)")
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

struct Restaurant2ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: Restaurant2ViewController())
            PreviewContainer(VC: nav, OrangeAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
