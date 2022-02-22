//
//  TrackingDetails1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class TrackingDetails1ViewController: DSViewController {
    
    let selectAddress = SearchAddress1ViewController()
    let selectDeliveryTime = SelectDeliveryTimeViewController()
    
    var dropOffNote: String?
    var deliveryAddress: String?
    var deliveryTime: Date?
    
    var selectedDeliveryMethod = 0
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        prefersLargeTitles = false
        title = "Tracking"
        update()
        showBottom(content: deliveryPerson())
    }
    
    func update() {
        
        show(content: [orderStatusSection(),
                       spaceSection(space: 3),
                       orderSection(),
                       spaceSection(space: 3),
                       recipientAddressSection(),
                       spaceSection(space: 3),
                       totalsSection(),
                       spaceSection(space: 3),
                       paymentMethodsSection()])
    }
}

// MARK: - Delivery Person

extension TrackingDetails1ViewController {
    
    func deliveryPerson() -> DSViewModel {
        
        // Text
        let text = DSTextComposer()
        text.add(type: .headline, text: "Ronald Richards", spacing: 5)
        
        text.add(rating: Int.random(in: 2...5),
                 maximumValue: 5,
                 positiveSymbol: "star.fill",
                 negativeSymbol: "star", style: .custom(size: 12, weight: .medium),
                 tint: .custom(UIColor.systemYellow),
                 spacing: 5)
        
        // Action
        var action = DSActionVM(composer: text)
        action.style.displayStyle = .grouped(inSection: false)
        action.leftImage(url: URL.profileUrl(index: 7), style: .circle)
        
        action.supplementaryItems = [phone()]
        
        return action
        
    }
    
    func phone() -> DSSupplementaryView {
        
        var image = DSImageVM(imageValue: .sfSymbol(name: "phone.circle.fill", style: .medium))
        
        image.tintColor = .text(.custom(UIColor.systemGreen))
        image.width = .absolute(50)
        image.height = .absolute(50)
        image.contentMode = .scaleAspectFit
        
        return image.asSupplementary(position: .rightCenter,
                                     background: .clear,
                                     insets: .insets(.zero))
    }

}

// MARK: - Order Status

extension TrackingDetails1ViewController {
    
    func orderStatusSection() -> DSSection {
        
        let composer = DSTextComposer()
        composer.add(type: .subheadline, text: "Order Status")
        composer.add(type: .text(font: .headlineWithSize(20), color: .brand), text: "Agent Driving To Restaurant", spacing: 15)
        
        composer.add(type: .subheadline, text: "Restaurant")
        composer.add(type: .headline, text: "Express Ramen Shop")
        composer.add(type: .subheadlineWithSize(13), text: "3891 Ranchview Dr. Richardson, California 62639")
        
        let text = composer.textViewModel()
        
        return text.list()
    }
}

// MARK: - Recipient Address

extension TrackingDetails1ViewController {
    
    func recipientAddressSection() -> DSSection {
        let viewModels = [recipientAddress(), recipientNote()]
        return viewModels.list().headlineHeader("Recipient Address")
    }
    
    func recipientAddress() -> DSViewModel {
        
        let composer = DSTextComposer()
        composer.add(type: .headlineWithSize(15), text: "3891 Ranchview Dr. Richardson")
        composer.add(type: .subheadlineWithSize(13), text: "3891 Ranchview Dr. Richardson, California 62639")
        
        var address = composer.actionViewModel()
        address.rightNone()
        address.style.displayStyle = .default
        address.leftIcon(sfSymbolName: "mappin.circle", size: .init(width: 20, height: 20))
        address.leftViewPosition = .top
        
        return address
    }
    
    func recipientNote() -> DSViewModel {
        
        let composer = DSTextComposer()
        composer.add(type: .headlineWithSize(15), text: "Please put in front of my door")
        
        var address = composer.actionViewModel()
        address.rightNone()
        address.style.displayStyle = .default
        address.leftIcon(sfSymbolName: "doc.plaintext", size: .init(width: 20, height: 20))
        address.leftViewPosition = .top
        
        return address
    }
}

// MARK: - Process to payment section

extension TrackingDetails1ViewController {
    
    // Process to payment button
    func processToPaymentButton() -> DSViewModel {
        
        // Process to payment button
        var button = DSButtonVM(title: "Process to payment", textAlignment: .left) { btn in
            self.pop()
        }
        
        button.supplementaryItems = [price()]
        return button
    }
    
    // Price
    func price() -> DSSupplementaryView {
        
        // Composer
        let composer = DSTextComposer(alignment: .center)
        let color = DSDesignablePriceColor(currency: .white, amount: .white, regularAmount: .white)
        composer.add(price: DSPrice(amount: "25", currency: "$"), color: .custom(color))
        
        // Text
        var text = composer.textViewModel()
        text.height = .absolute(30)
        text.width = .absolute(50)
        
        // Supplementary view
        return DSSupplementaryView(view: text,
                                   position: .rightCenter,
                                   background: .lightBlur,
                                   insets: .small,
                                   cornerRadius: .custom(8))
    }
}

// MARK: - Order Section

extension TrackingDetails1ViewController {
    
    /// Order section
    /// - Returns: DSSection
    func orderSection() -> DSSection {
        
        let p1 = orderProduct(title: "Original Ramen", note: "Please dont put egg", imageName: "RD1")
        let p2 = orderProduct(title: "Noodle with Chicken Curry Soup", imageName: "RD6")
        let section = [p1, p2].list().headlineHeader("Your order from Right From Oven")
        
        return section
    }
    
    /// Order product
    /// - Parameters:
    ///   - title: String
    ///   - subtitle: String
    ///   - imageName: String
    /// - Returns: DSViewModel
    func orderProduct(title: String,
                      note: String? = nil,
                      imageName: String) -> DSViewModel {
        
        // Text
        let composer = DSTextComposer()
        composer.add(type: .headlineWithSize(15), text: title, spacing: 5)
        
        composer.add(sfSymbol: "number.square", style: .custom(size: 12, weight: .medium), tint: .brand, spacing: 10)
        composer.add(type: .subheadlineWithSize(13), text: " 1 item", newLine: false)
        
        composer.add(price: DSPrice(amount: "10", currency: "$"))
        
        // Action
        var action = composer.actionViewModel()
        action.leftImage(image: UIImage.named(imageName), size: .size(CGSize(width: 70, height: 70)))
        
        return action
    }
}

extension TrackingDetails1ViewController {
    
    /// Payment methods section
    /// - Returns: DSSection
    func paymentMethodsSection() -> DSSection {
        
        let visa = paymentMethodViewModel(title: "3789", icon: "LightVisa")
        return [visa].list().headlineHeader("Payment Method")
    }
    
    /// Product checkbox view model
    /// - Parameter method: PaymentMethod
    /// - Returns: DSActionVM
    func paymentMethodViewModel(title: String, icon: String) -> DSActionVM {
        
        // Composer
        let composer = DSTextComposer()
        composer.add(type: .text(font: .headlineWithSize(15), color: .subheadline), text: "•••• \(title)")
        
        // Checkbox
        var action = composer.actionViewModel()
        
        // Set left image
        action.leftImage(image: UIImage.named(icon),
                         style: .default,
                         size: .size(CGSize(width: 60, height: 35)),
                         contentMode: .scaleAspectFit)
        
        // Handle did top on pay method
        action.didTap { [unowned self] (action: DSActionVM) in
            self.pop()
        }
        
        return action
    }
    
}

// MARK: - Totals

extension TrackingDetails1ViewController {
    
    func totalsSection() -> DSSection {
        
        var viewModels = [DSViewModel]()
        viewModels.append(serviceRow(title: "Full Vegie Salad (1 items)", price: DSPrice(amount: "10.00", currency: "$")))
        viewModels.append(serviceRow(title: "Toasted Sandwich (1 items)", price: DSPrice(amount: "10.00", currency: "$")))
        viewModels.append(serviceRow(title: "Delivery Fee", price: DSPrice(amount: "5.00", currency: "$")))
        viewModels.append(serviceRow(bold: true, title: "Total", price: DSPrice(amount: "25.00", currency: "$")))
        
        return viewModels.list().headlineHeader("Payment Details")
    }
    
    /// Row
    /// - Parameters:
    ///   - bold: Bool
    ///   - title: String
    ///   - price: DSPrice
    /// - Returns: DSViewModel
    func serviceRow(bold: Bool = false, title: String, price: DSPrice) -> DSViewModel {
        
        let composer = DSTextComposer()
        composer.add(type:  bold ? .headline : .subheadline, text: title)
        
        var action = composer.actionViewModel()
        action.style.displayStyle = .default
        action.rightPrice(price: price)
        
        return action
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct TrackingDetails1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: TrackingDetails1ViewController())
            PreviewContainer(VC: nav, OrangeAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
