//
//  SelectDeliveryTimeViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 23.12.2020.
//

import Foundation
import DSKit

class SelectDeliveryTimeViewController: DSViewController {
    
    let date: Date = Date()
    var didSelectTime: ((Date) -> Void)?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Delivery Time"
        show(content: getAvailableTimes())
    }
}

// MARK: - Times section
extension SelectDeliveryTimeViewController {
    
    /// Generate available times for person
    /// - Parameter person: Person
    /// - Returns: DSSection
    func getAvailableTimes() -> [DSSection] {
        
        var sections = [DSSection]()
        sections.append(getTimeIntervalsSection(startHour: 8, header: "Morning"))
        sections.append(getTimeIntervalsSection(startHour: 12, header: "Day"))
        sections.append(getTimeIntervalsSection(startHour: 18, header: "Evening"))
        return sections
    }
}

// MARK: - Times section
extension SelectDeliveryTimeViewController {
    
    /// Get time interval section
    /// - Parameter startHour: Int
    /// - Returns: DSSection
    func getTimeIntervalsSection(startHour: Int, header: String) -> DSSection {
        
        var models = [DSViewModel]()
        
        // Randomly generate hours and minutes
        for i in 1...4 {
            
            let hour = startHour + i
            
            // Hour
            let timeFixHour = getTimeViewModel(hour: hour, minute: 15)
            
            // Half hour
            let timeHalfHour = getTimeViewModel(hour: hour, minute: 30)
            
            models.append(contentsOf: [timeFixHour, timeHalfHour])
        }
        
        // Handle did tap on time
        models = models.didTap { [unowned self] (time: DSLabelVM) in
            guard let date = time.object as? Date else { return }
            self.didSelectTime?(date)
        }
        
        return models.grid(columns: 4).headlineHeader(header)
    }
    
    func getTimeViewModel(hour: Int, minute: Int) -> DSViewModel {
        
        // Style
        let font = appearance.fonts.headline.withSize(15)
        let color = appearance.secondaryView.text.title1
        
        // Hour
        var time = DSLabelVM(.custom(font: font, color: color), text: "\(hour): \(minute)", alignment: .center)
        time.height = .absolute(43)
        time.style.displayStyle = .grouped(inSection: false)
        time.object = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: self.date) as AnyObject
        
        return time
    }
}

// MARK: - Helpers
extension SelectDeliveryTimeViewController {
    
    /// Header section
    /// - Parameter text: String
    /// - Returns: DSSection
    func headerSection(text: String) -> DSSection {
        let morning = DSLabelVM(.title2, text: text)
        return morning.list()
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct SelectDeliveryTimeViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: SelectDeliveryTimeViewController(), OrangeAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
