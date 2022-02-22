//
//  SignUp1ViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit

open class SignUp1ViewController: DSViewController {
    
    // Form values
    var fullNameValue: String? = "John Doe"
    var emailValue: String? = "john.doe@dskit.app"
    var passwordValue: String? = "qqqqqqqq"
    var repeatPasswordValue: String? = "qqqqqqqq"
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        showContent()
        showPoweredBy()
    }
    
    func showContent() {
        
        // Text
        let composer = DSTextComposer(alignment: .center)
        composer.add(sfSymbol: "flame.fill",
                     style: .custom(size: 40, weight: .bold),
                     tint: .brand,
                     spacing: 30)
    
        let text = composer.textViewModel()
        
        // Bottom button
        let icon = UIImage.named("facebook")
        var signUp = DSButtonVM(title: "Login with Facebook",
                                icon: icon,
                                type: .facebook,
                                textAlignment: .left) { [unowned self] (_: DSButtonVM) in
            self.dismiss()
        }
        
        signUp.imagePosition = .rightMargin
        
        let emailLabel = DSLabelVM(.subheadline, text: "or sign up with Email", alignment: .center)
        
        let section = [text, signUp, emailLabel].list()
        section.doubleMarginLeftRightInsets()
        
        // Show text section
        show(content: section, getFormSection(), termsAndPrivacySection())
    }
    
    func showBottomContent() {
        
        // Continue
        let continueAsUser = DSButtonVM(title: "Continue as John",
                                        type: .default) { [unowned self] (_: DSButtonVM) in
            self.dismiss()
        }
        
        // Another account
        let chooseAnotherAccount = DSButtonVM(title: "Choose another account",
                                              type: .link,
                                              textAlignment: .center) { [unowned self] (_: DSButtonVM) in
            self.dismiss()
        }
        
        let sections = [[continueAsUser, chooseAnotherAccount].list().doubleMarginLeftRightInsets()]
        
        // Show bottom button
        showBottom(content: sections)
    }
    
    func showPoweredBy() {
        
        let powerByText = DSTextComposer(alignment: .center)
        powerByText.add(type: .subheadline, text: "Powered by ")
        powerByText.add(type: .headline, text: "DSKit", icon: UIImage(named: "dskitIcon"), newLine: false)
        
        var poweredByAction = DSActionVM(composer: powerByText)
        poweredByAction.style.displayStyle = .default
        showBottom(content: poweredByAction)
    }
}

// MARK: - Form section

extension SignUp1ViewController {
    
    func getFormSection() -> DSSection {
        
        // Name
        let name = DSTextFieldVM.name(text: fullNameValue, placeholder: "Full Name")
        name.didUpdate = { textField in
            self.fullNameValue = textField.text
        }
        
        // Email
        let email = DSTextFieldVM.email(text: emailValue, placeholder: "Email")
        email.didUpdate = { textField in
            self.emailValue = textField.text
        }
        
        // Password
        let password = DSTextFieldVM.password(text: passwordValue, placeholder: "Password")
        password.didUpdate = { textField in
            self.passwordValue = textField.text
        }
        
        // Repeat password
        let repeatPassword = DSTextFieldVM.password(text: repeatPasswordValue, placeholder: "Repeat password")
        repeatPassword.didUpdate = { textField in
            self.repeatPasswordValue = textField.text
        }
        
        // Custom validation, check if repeat password is equal to password
        repeatPassword.handleValidation = { repeatPasswordText in
            return repeatPasswordText == self.passwordValue
        }
        
        let continueButton = DSButtonVM(title: "Register") { [unowned self] (_: DSButtonVM)  in
            
            self.isCurrentFormValid { isFormValid in
                
                if isFormValid {
                    self.show(message: "Welcome to Pizza Corso", type: .success, icon: UIImage(systemName: "checkmark.circle.fill")) {
                        self.dismiss()
                    }
                    
                } else {
                    self.show(message: "Please input valid info in form", type: .error)
                }
            }
        }
        
        let section = [name, email, password, repeatPassword, continueButton].list()
        section.doubleMarginLeftRightInsets()
        
        return section
    }
}

// MARK: - Terms and Privacy Section

extension SignUp1ViewController {
    
    func termsAndPrivacySection() -> DSSection {
        
        var text = DSActiveTextVM(.subheadline, text: "By signing up, you agree to our\nTerms and Privacy", alignment: .center)
        
        text.links = ["Terms": "http://dskit.app", "Privacy": "http://dskit.app"]
        
        return text.list()
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct SignUp1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: SignUp1ViewController(), OrangeAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
