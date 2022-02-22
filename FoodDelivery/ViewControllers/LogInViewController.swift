//
//  LogInViewController.swift
//  DSKit
//
//  Created by Borinschi Ivan on 02.03.2021.
//

import DSKit

open class LogIn1ViewController: DSViewController {
    
    var userEmailValue: String? = "john.doe@dskit.app"
    var userPasswordValue: String? = "qqqqqqqqq"
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        showContent()
        showBottomContent()
    }
    
    func showContent() {
        
        // Text
        let space1 = DSSpaceVM(type: .custom(50))
        let composer = DSTextComposer()
        composer.add(type: .headlineWithSize(38), text: "Welcome to\nPizza Corso Restaurant")
        composer.add(type: .body, text: "An exciting place for the whole\nfamily to eat")
        
        let text = composer.textViewModel()
        let space2 = DSSpaceVM(type: .custom(50))
        
        // Form
        let email = DSTextFieldVM.email(text: userEmailValue, placeholder: "Email")
        email.didUpdate = { textField in
            self.userEmailValue = textField.text
        }
        
        let password = DSTextFieldVM.password(text: userPasswordValue, placeholder: "Password")
        password.didUpdate = { textField in
            self.userPasswordValue = textField.text
        }
        
        // Buttons
        let login = DSButtonVM(title: "Login") { [unowned self] (_: DSButtonVM)  in
            
            self.isCurrentFormValid { isFormValid in
                
                if isFormValid {
                    self.show(message: "Welcome back! 🤗", type: .success, icon: UIImage(systemName: "checkmark.circle.fill")) {
                        self.dismiss()
                    }
                    
                } else {
                    self.show(message: "Please input valid email and password", type: .error)
                }
            }            
        }
        
        let forgotPassword = DSButtonVM(title: "Forgot password?", type: .link, textAlignment: .left) { [unowned self] (_: DSButtonVM)  in
            self.dismiss()
        }
        
        let section = [space1, text, space2, email, password, login, forgotPassword].list()
        section.doubleMarginLeftRightInsets()
        
        // Show content
        show(content: section)
    }
    
    func showBottomContent() {
        
        var signUp = DSButtonVM(title: "Sign Up",
                                icon: DSSFSymbolConfig.buttonIcon("chevron.right"),
                                type: .secondaryView,
                                textAlignment: .left) { [unowned self] (_: DSButtonVM) in
            self.dismiss()
        }
        
        signUp.imagePosition = .rightMargin
        
        // Show bottom content
        showBottom(content: [signUp].list().doubleMarginLeftRightInsets())
    }
}

// MARK: - SwiftUI Preview

import SwiftUI

struct LogIn1ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        Group {
            PreviewContainer(VC: LogIn1ViewController(), OrangeAppearance()).edgesIgnoringSafeArea(.all)
        }
    }
}
