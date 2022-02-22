//
//  Payment1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class Payment1ViewController: DSViewController {
    
    public var selectedMethod: String = "3789"
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        prefersLargeTitles = false
        title = "Payment Method"
        update()
    }
    
    func update() {
        
        show(content: [balanceSection(),
                       paymentMethodsSection(),
                       addPaymentMethod(),
                       spaceSection(),
                       totalsSection()])
        
        var button = DSButtonVM(title: "Confirm Payment", textAlignment: .left) { btn in
            self.pop()
        }
        
        button.supplementaryItems = [price()]
        self.showBottom(content: button)
    }
    
    func price() -> DSSupplementaryView {
        
        let composer = DSTextComposer(alignment: .center)
        let color = DSDesignablePriceColor(currency: .white, amount: .white, regularAmount: .white)
        composer.add(price: DSPrice(amount: "17", currency: "$"), color: .custom(color))
        var text = composer.textViewModel()
        
        text.height = .absolute(30)
        text.width = .absolute(50)
        
        return DSSupplementaryView(view: text,
                                   position: .rightCenter,
                                   background: .lightBlur,
                                   insets: .small,
                                   cornerRadius: .custom(8))
    }
}

// MARK: - Balance

extension Payment1ViewController {
    
    // Balance Section
    func balanceSection() -> DSSection {
        
        let composer = DSTextComposer()
        composer.add(type: .headline, text: "Yummie Balance", spacing: 5)
        composer.add(sfSymbol: "creditcard.fill", tint: .custom(UIColor(0x00BAE9)))
        composer.add(type: .text(font: .headlineWithSize(15), color: .custom(UIColor(0x00BAE9))), text: " $230", newLine: false)
        
        var text = composer.textViewModel()
        text.style.displayStyle = .grouped(inSection: false)
        text.style.borderStyle = .custom(width: 0.5, color: UIColor.black.withAlphaComponent(0.3))
        
        return text.list()
    }
}

// MARK: - Payment methods section

extension Payment1ViewController {
    
    /// Payment methods section
    /// - Returns: DSSection
    func paymentMethodsSection() -> DSSection {
        
        let visa = paymentMethodViewModel(title: "3789", icon: "LightVisa")
        let master = paymentMethodViewModel(title: "5345", icon: "LightMasterCard")
        return [visa, master].list().headlineHeader("Saved Payment")
    }
    
    /// Product checkbox view model
    /// - Parameter method: PaymentMethod
    /// - Returns: DSActionVM
    func paymentMethodViewModel(title: String, icon: String) -> DSActionVM {
        
        // Composer
        let composer = DSTextComposer()
        composer.add(type: .text(font: .headlineWithSize(15), color: .subheadline), text: "•••• \(title)")
        
        // Is selected
        let selected = selectedMethod == title
        
        // Checkbox
        var checkbox = composer.checkboxActionViewModel(selected: selected)
        
        // Set left image
        checkbox.leftImage(image: UIImage.named(icon),
                           style: .default,
                           size: .size(CGSize(width: 60, height: 35)),
                           contentMode: .scaleAspectFit)
        
        // Handle did top on pay method
        checkbox.didTap { [unowned self] (action: DSActionVM) in
            self.selectedMethod = title
            self.update()
        }
        
        return checkbox
    }
}

// MARK: - Add payment method

extension Payment1ViewController {
 
    func addPaymentMethod() -> DSSection {
        
        let addVisa = paymentMethod(title: "Add Credit Card", icon: "LightCreditCard")
        let addPayPal = paymentMethod(title: "Paypal", icon: "LightPaypal")
        return [addVisa, addPayPal].list().headlineHeader("Add Payment Method")
    }
    
    func paymentMethod(title: String, icon: String) -> DSViewModel {
        
        // Composer
        let composer = DSTextComposer()
        composer.add(type: .text(font: .headlineWithSize(15), color: .subheadline), text: title)
        
        // Action
        var action = composer.actionViewModel()
        action.rightArrow()
        action.leftImage(image: UIImage.named(icon),
                         style: .default,
                         size: .size(.init(width: 60, height: 40)),
                         contentMode: .scaleAspectFit)
        
        return action
    }
}

// MARK: - Totals

extension Payment1ViewController {
    
    func totalsSection() -> DSSection {
        
        var viewModels = [DSViewModel]()
        viewModels.append(serviceRow(title: "Full Vegie Salad (1 items)", price: DSPrice(amount: "10.00", currency: "$")))
        viewModels.append(serviceRow(title: "Toasted Sandwich (1 items)", price: DSPrice(amount: "10.00", currency: "$")))
        viewModels.append(serviceRow(title: "Delivery Fee", price: DSPrice(amount: "5.00", currency: "$")))
        
        viewModels.append(serviceRow(title: "Discount", price: DSPrice(amount: "8.00", currency: "$")))
        viewModels.append(serviceRow(bold: true, title: "Total", price: DSPrice(amount: "17.00", currency: "$")))
        
        return viewModels.list().headlineHeader("Payment Details")
    }
    
    /// Row
    /// - Parameters:
    ///   - bold: Bool
    ///   - title: String
    ///   - price: DSPrice
    /// - Returns: DSViewModel
    func serviceRow(bold: Bool = false, title: String, price: DSPrice) -> DSViewModel {
        
        // Composer
        let composer = DSTextComposer()
        composer.add(type:  bold ? .headline : .subheadline, text: title)
        
        // Action
        var action = composer.actionViewModel()
        action.style.displayStyle = .default
        action.rightPrice(price: price)
        action.height = .absolute(20)
        
        return action
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct Payment1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: Payment1ViewController())
            PreviewContainer(VC: nav, OrangeAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
