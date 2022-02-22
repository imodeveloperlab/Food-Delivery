//
//  Checkout1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class Checkout1ViewController: DSViewController {
    
    let selectAddress = SearchAddress1ViewController()
    let selectDeliveryTime = SelectDeliveryTimeViewController()
    
    var dropOffNote: String?
    var deliveryAddress: String?
    var deliveryTime: Date?
    
    var selectedDeliveryMethod = 0
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        prefersLargeTitles = false
        title = "Checkout"
        update()
        showBottom(content: processToPaymentButton())
    }
    
    func update() {
        
        // Delivery details section
        let deliveryDetailsSection = selectedDeliveryMethod  == 0 ? shippingAddressSection() : pickUpSection()
        
        show(content: [orderSection(),
                       popularSection(),
                       spaceSection().zeroTopInset(),
                       shippingMethodSection(),
                       deliveryDetailsSection,
                       deliveryTimeSection(),
                       spaceSection(),
                       discountSection(),
                       spaceSection(),
                       totalsSection()])
    }
}

// MARK: - Process to payment section

extension Checkout1ViewController {
    
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

extension Checkout1ViewController {
    
    /// Order section
    /// - Returns: DSSection
    func orderSection() -> DSSection {
        
        let p1 = orderProduct(title: "Original Ramen", note: "Please dont put egg", imageName: "RD1")
        let p2 = orderProduct(title: "Noodle with Chicken Curry Soup", imageName: "RD6")
        
        let section = [p1, p2].list().headlineHeader("Your order")
        
        section.background = .secondaryBackground
        
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
        
        // Product note
        if let note = note {
            composer.add(sfSymbol: "highlighter", style: .custom(size: 12, weight: .medium), tint: .brand, spacing: 10)
            composer.add(type: .subheadlineWithSize(13), text: " \(note)", newLine: false)
        }
        
        composer.add(price: DSPrice(amount: "10", currency: "$"))
        
        // Action
        var action = composer.actionViewModel()
        action.leftImage(image: UIImage.named(imageName), size: .size(CGSize(width: 90, height: 90)))
        action.supplementaryItems = [quantityPicker()]
        
        return action
    }
    
    /// Quantity picker
    /// - Returns: DSSupplementaryView
    func quantityPicker() -> DSSupplementaryView {
        
        let picker = DSQuantityPickerVM(quantity: 1)
        picker.width = .absolute(110)
        picker.height = .absolute(35)
        
        return DSSupplementaryView(view: picker, position: .rightBottom)
    }
}

// MARK: - Order Section

extension Checkout1ViewController {

    /// Popular
    /// - Returns: DSSection
    func popularSection() -> DSSection {
        
        let p1 = product(title: "Mushroom & Nori Noodle", rating: "4.1", time: "30 min", imageName: "RD2")
        let p2 = product(title: "Chicken Peanut Noodle", rating: "4.2", time: "30 min", imageName: "RD3")
        let p3 = product(title: "Spicy Chicken Noodle", rating: "4.9", time: "30 min", imageName: "RD4")

        let section = [p1, p2, p3].gallery()
        section.headlineHeader("You may also like")
        section.background = .secondaryBackground
        
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
                 imageName: String) -> DSViewModel {
        
        // Text
        let composer = DSTextComposer()
        composer.add(type: .text(font: .headlineWithSize(15), color: .subheadline), text: title, spacing: 5)
        composer.add(sfSymbol: "star.fill", style: .small, tint: .custom(.systemYellow), spacing: 5)
        composer.add(type: .subheadlineWithSize(13), text: " \(rating)   ", newLine: false)
        composer.add(sfSymbol: "clock.fill", style: .small, newLine: false)
        composer.add(type: .subheadlineWithSize(13), text: " \(time)", newLine: false)
        composer.add(price: DSPrice(amount: "10", currency: "$"))
        
        // Action
        var action = composer.actionViewModel()
        action.leftImage(image: UIImage.named(imageName), size: .size(.init(width: 70, height: 70)))
        action.width = .estimated(150)
        action.height = .absolute(95)
        
        action.supplementaryItems = [addButton(position: .rightBottom)]
        
        return action
    }
    
    // Add button
    func addButton(position: DSSupplementaryViewPosition) -> DSSupplementaryView {
        
        var button = DSButtonVM(title: "Add", type: .link) { (btn) in
            self.pop()
        }
        
        button.height = .absolute(30)
        
        return DSSupplementaryView(view: button,
                                   position: position,
                                   background: .white,
                                   insets: .small,
                                   cornerRadius: .custom(5))
    }
}

// MARK: - Shipping

extension Checkout1ViewController {
    
    /// Shipping method section
    /// - Returns: DSSection
    func shippingMethodSection() -> DSSection {
        
        let segment = DSSegmentVM(segments: ["Delivery", "Pickup"])
        segment.selectedSegmentIndex = 0
        
        segment.didTapOnSegment = { segment in
            self.selectedDeliveryMethod = segment.index
            self.update()
        }
        
        return [segment].list().headlineHeader("Shipping")
    }
    
    /// Shipping adress section
    /// - Returns: DSSection
    func shippingAddressSection() -> DSSection {
        
        return [addressViewModel(),
                dropOffNoteViewModel()].list().headlineHeader("Address Details", size: 14)
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
        model.rightArrow()
        
        model.didTap = { (model: DSViewModel) in
            self.push(PickUpLocation1ViewController())
        }
        
        return [model].list().headlineHeader("Pick Up Details", size: 14)
    }
    
    /// Delivery time section
    /// - Returns: DSSection
    func deliveryTimeSection() -> DSSection {
        return [deliveryTimeViewModel()].list().headlineHeader("Delivery Time", size: 14)
    }
    
    /// Address
    /// - Returns: DSViewModel
    func addressViewModel() -> DSViewModel {
        
        var address = action(title: "Address",
                             subtitle: deliveryAddress ?? "Select Address",
                             icon: "mappin.circle")
        
        address.didTap = { (_: DSViewModel) in
            
            self.present(vc: self.selectAddress, presentationStyle: .formSheet)
            
            self.selectAddress.didSelectAddress = { address in
                self.deliveryAddress = address
                self.selectAddress.dismiss()
                self.update()
            }
        }
        
        return address
    }
    
    /// Drop off note
    /// - Returns: DSViewModel
    func dropOffNoteViewModel() -> DSViewModel {
        
        let note = textField(placeHolder: "Drop Off Note", value: dropOffNote)
        note.leftSFSymbolName = "doc.text.fill"
        note.didUpdate = { textField in
            self.dropOffNote = textField.text
        }
        
        return note
    }
    
    /// Drop off note
    /// - Returns: DSViewModel
    func deliveryTimeViewModel() -> DSViewModel {
        
        var time = action(title: "Time",
                            subtitle:  self.deliveryTime?.stringFormattedHour() ?? "Set Delivery Time",
                            icon: "clock")
        
        time.didTap = { (_: DSViewModel) in
        
            self.present(vc: self.selectDeliveryTime, presentationStyle: .formSheet)
            
            self.selectDeliveryTime.didSelectTime = { date in
                self.deliveryTime = date
                self.selectDeliveryTime.dismiss()
                self.update()
            }
        }
        
        return time
    }
    
    func action(title: String, subtitle: String, icon: String) -> DSActionVM {
        
        // Text
        let text = DSTextComposer()
        text.add(type: .caption2, text: title, spacing: 5)
        text.add(type: .headlineWithSize(15), text: subtitle)
        
        // Transform text to action
        var action = text.actionViewModel()
        action.leftIcon(sfSymbolName: icon)
        action.rightArrow()
        
        // Handle did tap
        action.didTap { [unowned self] (_: DSActionVM) in
            self.dismiss()
        }
        
        return action
    }
}

// MARK: - Discount

extension Checkout1ViewController {
    
    func discountSection() -> DSSection {
        
        var label = DSLabelVM(.headline, text: "Have a discount code?")
        label.height = .absolute(40)
        label.supplementaryItems = [addButton(position: .rightCenter)]
        
        return [label].list()
    }
}

// MARK: - Totals

extension Checkout1ViewController {
    
    func totalsSection() -> DSSection {
        
        var viewModels = [DSViewModel]()
        viewModels.append(serviceRow(title: "Full Vegie Salad (1 items)", price: DSPrice(amount: "10.00", currency: "$")))
        viewModels.append(serviceRow(title: "Toasted Sandwich (1 items)", price: DSPrice(amount: "10.00", currency: "$")))
        viewModels.append(serviceRow(title: "Delivery Fee", price: DSPrice(amount: "5.00", currency: "$")))
        viewModels.append(serviceRow(bold: true, title: "Total", price: DSPrice(amount: "25.00", currency: "$")))
        
        return viewModels.list().headlineHeader("Order Review")
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

struct Checkout1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: Checkout1ViewController())
            PreviewContainer(VC: nav, OrangeAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
