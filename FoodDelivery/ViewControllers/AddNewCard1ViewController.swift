//
//  AddNewCard1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit
import DSKitFakery

open class AddNewCard1ViewController: DSViewController {
    
    let searchCountry = SearchCountry1ViewController()
    
    // Form Values
    var countryNameValue: String? = nil
    var cardNumberValue: String? = nil
    var cardExpireDateValue: String? = nil
    var cardCVVValue: String? = nil
    var cardHolderValue: String? = nil
    var postalCodeValue: String? = nil
    var saveCardForFutureTransaction = false
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        prefersLargeTitles = false
        title = "Add New Card"
        update()
        
        let button = DSButtonVM(title: "Submit")
        self.showBottom(content: button)
    }
    
    func update() {
        
        let sections = [weAcceptSection(),
                        cardNumberSection(),
                        cardDateAndCVVSection(),
                        cardHolderInformationSection(),
                        saveCardSection(),
                        paymentSecurity()]
        
        show(content: sections)
    }
}

// MARK: - We accept

extension AddNewCard1ViewController {
    
    func weAcceptSection() -> DSSection {
        
        let visa = paymentMethod(icon: "LightVisa")
        let master = paymentMethod(icon: "LightMasterCard")
        let americanExpress = paymentMethod(icon: "LightAmericanExpress")
        
        return [visa, master, americanExpress].gallery().subheadlineHeader("We accept")
    }
    
    func paymentMethod(icon: String) -> DSViewModel {
        
        var image = DSImageVM(image: UIImage.named(icon),
                              displayStyle: .default,
                              contentMode: .scaleAspectFit)
        
        image.width = .absolute(64)
        image.height = .absolute(40)
        
        return image
    }
}

// MARK: - Card Form Sections
 
extension AddNewCard1ViewController {
    
    // Card number section
    func cardNumberSection() -> DSSection {
        
        var cardNumber = cardNumberTextField()
        
        // Scan button on the right
        var button = DSButtonVM(sfSymbol: "barcode.viewfinder")
        button.width = .absolute(30)
        button.height = .absolute(30)
        
        button.didTap = { (model) in
            self.pop()
        }
        
        cardNumber.supplementaryItems = [button.asSupplementary(position: .rightCenter, background: .clear, insets: .insets(.zero))]
        
        return [cardNumber].list().headlineHeader("Card Information")
    }
    
    // Card date and cvv section
    func cardDateAndCVVSection() -> DSSection {
        
        let cardExpireDate = expireDateTextField()
        let cardCVV = cvvTextField()
        return [cardExpireDate, cardCVV].grid().interItemTopInset()
    }
    
    // Card holder info
    func cardHolderInformationSection() -> DSSection {

        let cardholderName = holderNameTextField()
        let cardholderCountry = countryTextField()
        let postalCode = postalCodeTextField()
        
        let section = [cardholderName, cardholderCountry, postalCode].list()
        section.headlineHeader("Cardholder Information")
        
        return section
    }
    
    // Save card for future transaction
    func saveCardSection() -> DSSection {
        
        var label = DSLabelVM(.headlineWithSize(15), text: "Save card for future transaction")
        var switchView = DSSwitchVM(isOn: saveCardForFutureTransaction)
        switchView.didUpdate = { isOn in
            self.saveCardForFutureTransaction = isOn
        }
        
        label.rightSideView = DSSideView(view: switchView)
        label.height = .absolute(35)
        
        return label.list()
    }
    
    // Payment Security Section
    func paymentSecurity() -> DSSection {
        
        let message = "Your payment is secure. Your card detail will not be shared with sellers."
        return messageBannerSection(text: message,
                                    icon: "lock.fill")
       
    }
}

// MARK: - Text Fields

extension AddNewCard1ViewController {
    
    // Card number text field
    func cardNumberTextField() -> DSViewModel {
        
        // Card Number
        let cardNumber = textField(placeHolder: "Card Number", value: cardNumberValue)
        cardNumber.leftSFSymbolName = "creditcard"
        cardNumber.validationPattern = patternNumbers
        cardNumber.validateMinimumLength = 16
        cardNumber.validateMaximumLength = 16
        
        // Update
        cardNumber.didUpdate = { [unowned self] textField in
            self.cardNumberValue = textField.text
        }
        
        return cardNumber
    }
    
    // Expire date text field
    func expireDateTextField() -> DSViewModel {
        
        // Card expire date
        let cardExpireDate = textField(placeHolder: "Expire Date", value: cardExpireDateValue)
        
        // Update
        cardExpireDate.didUpdate = { [unowned self] textField in
            self.cardExpireDateValue = textField.text
        }
        
        // Validation
        cardExpireDate.handleValidation = { text in
            
            guard let text = text else {
                return true
            }
            
            if text.isEmpty {
                return true
            }
            
            return self.validateCreditCardExpiry(text) == .valid
        }
        
        return cardExpireDate
    }
    
    // CVV Text field
    func cvvTextField() -> DSViewModel {
        
        let cardCVV = textField(placeHolder: "CVV", value: cardCVVValue)
        
        // Update
        cardCVV.didUpdate = { [unowned self] textField in
            cardCVVValue = textField.text
        }
        
        // Validation
        cardCVV.validateMinimumLength = 3
        cardCVV.validateMaximumLength = 3
        cardCVV.validationPattern = patternNumbers
        
        return cardCVV
    }
    
    // Holder Name text field
    func holderNameTextField() -> DSViewModel {
        
        let cardholderName = textField(placeHolder: "Cardholder Name", value: cardHolderValue)
        cardholderName.leftSFSymbolName = "person"
        cardholderName.validationPattern = patternName
        
        // Update
        cardholderName.didUpdate = { [unowned self] textField in
            self.cardHolderValue = textField.text
        }
        
        return cardholderName
    }
    
    // Card Holder Country Text Field
    func countryTextField() -> DSViewModel {
        
        // Text field
        let country = textField(placeHolder: "Country", value: countryNameValue)
        country.leftSFSymbolName = "globe"
        country.validationPattern = patternAddress
        country.validateMinimumLength = 3
        country.validateMaximumLength = 120
        
        // Update
        country.didTap = { [unowned self] textField in
            
            // User did select country in searchCountry view controller
            self.searchCountry.didSelectCountry = { [unowned self] countryName in
                self.countryNameValue = countryName
                self.searchCountry.dismiss()
                self.update()
            }
            
            // Present search country view controller
            self.present(vc: self.searchCountry, presentationStyle: .formSheet)
        }
        
        // Alway valid
        country.handleValidation = { _ in return true }
    
        return country
    }
    
    // Postal code text field
    func postalCodeTextField() -> DSViewModel {
        
        let postalCode = textField(placeHolder: "Postal Code", value: postalCodeValue)
        postalCode.leftSFSymbolName = "signpost.left"
        
        // Validation
        postalCode.validationPattern = patternAddress
        postalCode.validateMinimumLength = 3
        postalCode.validateMaximumLength = 10
        return postalCode
    }
}

// MARK: - Expire date validation

extension AddNewCard1ViewController {
    
    enum ExpiryValidation {
        case valid, invalidInput, expired
    }
    
    func validateCreditCardExpiry(_ input: String) -> ExpiryValidation {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/yyyy"

        guard let enteredDate = dateFormatter.date(from: input) else {
            return .invalidInput
        }
        let calendar = Calendar.current
        let components = Set([Calendar.Component.month, Calendar.Component.year])
        let currentDateComponents = calendar.dateComponents(components, from: Date())
        let enteredDateComponents = calendar.dateComponents(components, from: enteredDate)

        guard let eMonth = enteredDateComponents.month, let eYear = enteredDateComponents.year, let cMonth = currentDateComponents.month, let cYear = currentDateComponents.year, eMonth >= cMonth, eYear >= cYear else {
            return .expired
        }
        return .valid
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct AddNewCard1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            let nav = DSNavigationViewController(rootViewController: AddNewCard1ViewController())
            PreviewContainer(VC: nav, OrangeAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
